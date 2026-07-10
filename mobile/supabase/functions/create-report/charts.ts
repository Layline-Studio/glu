// Chart primitives drawn with pdf-lib vector ops. One y-axis per chart, goal
// lines dashed, series always direct-labeled — designed so a doctor can read
// trends without a legend hunt.

import { rgb } from "pdf-lib";
import { Doc, INK } from "./layout.ts";

export const COLORS = {
  series1: rgb(0.165, 0.471, 0.839), // #2a78d6 blue
  series1Fill: rgb(0.902, 0.937, 0.98),
  series2: rgb(0.106, 0.686, 0.478), // #1baf7a green
  series3: rgb(0.929, 0.631, 0.0), // #eda100 amber
  bmi: rgb(0.29, 0.227, 0.655), // #4a3aa7 violet
  trend: rgb(0.55, 0.55, 0.55),
  goal: rgb(0.35, 0.35, 0.35),
  moodBad: rgb(0.75, 0.8, 0.88),
  moodOkay: rgb(0.52, 0.68, 0.88),
  moodGood: rgb(0.33, 0.56, 0.84),
  moodGreat: rgb(0.12, 0.33, 0.67),
  sevMild: rgb(0.804, 0.886, 0.984),
  sevModerate: rgb(0.353, 0.596, 0.898),
  sevSevere: rgb(0.078, 0.322, 0.671),
  dotEmpty: rgb(0.92, 0.92, 0.92),
} as const;

export const CHART = {
  height: 170,
  miniHeight: 92,
  sparklineHeight: 44,
  padLeft: 44,
  padRight: 8,
  padTop: 10,
  padBottom: 16,
  axisFontSize: 7.5,
  labelFontSize: 8.5,
} as const;

export type Rect = { x: number; y: number; width: number; height: number };

type Color = ReturnType<typeof rgb>;

function plotArea(rect: Rect): Rect {
  return {
    x: rect.x + CHART.padLeft,
    y: rect.y + CHART.padBottom,
    width: rect.width - CHART.padLeft - CHART.padRight,
    height: rect.height - CHART.padTop - CHART.padBottom,
  };
}

/** "Nice" rounded tick values covering [0-or-min, max]. */
export function buildTicks(min: number, max: number, count = 4): number[] {
  if (max <= min) max = min + 1;
  const span = max - min;
  const rawStep = span / count;
  const magnitude = Math.pow(10, Math.floor(Math.log10(rawStep)));
  const residual = rawStep / magnitude;
  const step =
    (residual > 5 ? 10 : residual > 2.5 ? 5 : residual > 2 ? 2.5 : residual > 1 ? 2 : 1) *
    magnitude;
  const start = Math.floor(min / step) * step;
  const ticks: number[] = [];
  for (let v = start; v <= max + step * 0.001; v += step) {
    ticks.push(Number(v.toFixed(6)));
  }
  return ticks;
}

type AxisOptions = {
  values: (number | null)[];
  yFormat: (v: number) => string;
  zeroBased: boolean;
  includeValue?: number | null;
};

function yDomain(opts: AxisOptions): { min: number; max: number } {
  const present = opts.values.filter((v): v is number => v != null);
  if (opts.includeValue != null) present.push(opts.includeValue);
  if (present.length === 0) return { min: 0, max: 1 };
  let min = Math.min(...present);
  let max = Math.max(...present);
  if (opts.zeroBased) {
    min = 0;
  } else {
    const pad = Math.max((max - min) * 0.08, max * 0.005, 0.5);
    min = Math.max(0, min - pad);
    max = max + pad;
  }
  if (max <= min) max = min + 1;
  return { min, max };
}

function drawFrame(
  doc: Doc,
  rect: Rect,
  domain: { min: number; max: number },
  yFormat: (v: number) => string,
  dayKeys: string[],
  monthLabelFor: (dayKey: string) => string,
  todayLabel: string,
  integerTicks = false,
): { plot: Rect; scaleY: (v: number) => number; scaleX: (i: number) => number } {
  const plot = plotArea(rect);
  const scaleY = (v: number) =>
    plot.y + ((v - domain.min) / (domain.max - domain.min)) * plot.height;
  const scaleX = (i: number) =>
    plot.x + (dayKeys.length <= 1 ? 0 : (i / (dayKeys.length - 1)) * plot.width);

  let ticks = buildTicks(domain.min, domain.max).filter(
    (t) => t >= domain.min - 1e-9 && t <= domain.max + 1e-9,
  );
  if (integerTicks) {
    ticks = [...new Set(ticks.map((t) => Math.round(t)))].filter(
      (t) => t >= domain.min && t <= domain.max,
    );
  }
  for (const tick of ticks) {
    const y = scaleY(tick);
    doc.page.drawLine({
      start: { x: plot.x, y },
      end: { x: plot.x + plot.width, y },
      thickness: 0.4,
      color: INK.line,
    });
    const label = yFormat(tick);
    const width = doc.widthOf(label, CHART.axisFontSize);
    doc.textAt(label, plot.x - width - 4, y - 2.5, {
      size: CHART.axisFontSize,
      color: INK.muted,
    });
  }

  // Baseline + three x labels: window start, middle month, "Today".
  doc.page.drawLine({
    start: { x: plot.x, y: plot.y },
    end: { x: plot.x + plot.width, y: plot.y },
    thickness: 0.6,
    color: INK.muted,
  });
  const startLabel = monthLabelFor(dayKeys[0]);
  const midLabel = monthLabelFor(dayKeys[Math.floor(dayKeys.length / 2)]);
  doc.textAt(startLabel, plot.x, plot.y - 11, {
    size: CHART.axisFontSize,
    color: INK.muted,
  });
  const midWidth = doc.widthOf(midLabel, CHART.axisFontSize);
  doc.textAt(midLabel, plot.x + plot.width / 2 - midWidth / 2, plot.y - 11, {
    size: CHART.axisFontSize,
    color: INK.muted,
  });
  const todayWidth = doc.widthOf(todayLabel, CHART.axisFontSize);
  doc.textAt(todayLabel, plot.x + plot.width - todayWidth, plot.y - 11, {
    size: CHART.axisFontSize,
    color: INK.muted,
  });

  return { plot, scaleY, scaleX };
}

function drawGoalLine(
  doc: Doc,
  plot: Rect,
  scaleY: (v: number) => number,
  goal: number,
  label: string,
): void {
  const y = scaleY(goal);
  doc.page.drawLine({
    start: { x: plot.x, y },
    end: { x: plot.x + plot.width, y },
    thickness: 0.9,
    color: COLORS.goal,
    dashArray: [4, 3],
  });
  const width = doc.widthOf(label, CHART.axisFontSize, true);
  doc.textAt(label, plot.x + plot.width - width, y + 2.5, {
    size: CHART.axisFontSize,
    bold: true,
    color: COLORS.goal,
  });
}

function polylineSegments(
  values: (number | null)[],
  scaleX: (i: number) => number,
  scaleY: (v: number) => number,
): { x: number; y: number }[][] {
  const segments: { x: number; y: number }[][] = [];
  let current: { x: number; y: number }[] = [];
  values.forEach((value, index) => {
    if (value == null) {
      if (current.length > 0) segments.push(current);
      current = [];
      return;
    }
    current.push({ x: scaleX(index), y: scaleY(value) });
  });
  if (current.length > 0) segments.push(current);
  return segments;
}

export function interpolateMissingValues(
  values: (number | null)[],
): (number | null)[] {
  if (values.length === 0) return [];

  const interpolated = [...values];
  let previousIndex: number | null = null;

  for (let index = 0; index < values.length; index++) {
    const value = values[index];
    if (value == null) continue;

    if (previousIndex != null && index - previousIndex > 1) {
      const start = values[previousIndex];
      const end = value;
      if (start != null) {
        const gap = index - previousIndex;
        for (let offset = 1; offset < gap; offset++) {
          const progress = offset / gap;
          interpolated[previousIndex + offset] =
            start + (end - start) * progress;
        }
      }
    }

    previousIndex = index;
  }

  if (previousIndex != null) {
    const lastValue = values[previousIndex];
    if (lastValue != null) {
      for (let index = previousIndex + 1; index < interpolated.length; index++) {
        interpolated[index] = lastValue;
      }
    }
  }

  return interpolated;
}

function drawPolyline(
  doc: Doc,
  values: (number | null)[],
  scaleX: (i: number) => number,
  scaleY: (v: number) => number,
  color: Color,
  thickness: number,
  fillTo?: number,
): void {
  const segments = polylineSegments(
    interpolateMissingValues(values),
    scaleX,
    scaleY,
  );
  for (const points of segments) {
    if (points.length === 1) {
      doc.page.drawCircle({
        x: points[0].x,
        y: points[0].y,
        size: thickness,
        color,
      });
      continue;
    }
    if (fillTo != null) {
      const path = [
        `M ${points[0].x.toFixed(2)} ${(-points[0].y).toFixed(2)}`,
        ...points.slice(1).map((p) => `L ${p.x.toFixed(2)} ${(-p.y).toFixed(2)}`),
        `L ${points[points.length - 1].x.toFixed(2)} ${(-fillTo).toFixed(2)}`,
        `L ${points[0].x.toFixed(2)} ${(-fillTo).toFixed(2)}`,
        "Z",
      ].join(" ");
      doc.page.drawSvgPath(path, { x: 0, y: 0, color: COLORS.series1Fill });
    }
    const path = [
      `M ${points[0].x.toFixed(2)} ${(-points[0].y).toFixed(2)}`,
      ...points.slice(1).map((p) => `L ${p.x.toFixed(2)} ${(-p.y).toFixed(2)}`),
    ].join(" ");
    doc.page.drawSvgPath(path, {
      x: 0,
      y: 0,
      borderColor: color,
      borderWidth: thickness,
    });
  }
}

export type LineChartOptions = {
  values: (number | null)[];
  trend?: (number | null)[];
  goal?: number | null;
  goalLabel?: string;
  dayKeys: string[];
  yFormat: (v: number) => string;
  monthLabelFor: (dayKey: string) => string;
  todayLabel: string;
  color?: Color;
  zeroBased?: boolean;
  fillUnder?: boolean;
  /** index -> label, drawn as dots on the series (dose events). */
  markers?: Map<number, string>;
  /** Fixed domain override (mood chart pins 1–4). */
  domain?: { min: number; max: number };
  firstLastLabels?: boolean;
  /** Draw the series as dots instead of a connected line (noisy daily data). */
  pointsOnly?: boolean;
};

export function lineChart(doc: Doc, rect: Rect, opts: LineChartOptions): void {
  const domain = opts.domain ??
    yDomain({
      values: opts.trend ? [...opts.values, ...opts.trend] : opts.values,
      yFormat: opts.yFormat,
      zeroBased: opts.zeroBased ?? false,
      includeValue: opts.goal,
    });
  const { plot, scaleY, scaleX } = drawFrame(
    doc,
    rect,
    domain,
    opts.yFormat,
    opts.dayKeys,
    opts.monthLabelFor,
    opts.todayLabel,
  );

  if (opts.pointsOnly) {
    opts.values.forEach((value, index) => {
      if (value == null) return;
      doc.page.drawCircle({
        x: scaleX(index),
        y: scaleY(value),
        size: 1.8,
        color: opts.color ?? COLORS.series1,
      });
    });
  } else {
    drawPolyline(
      doc,
      opts.values,
      scaleX,
      scaleY,
      opts.color ?? COLORS.series1,
      1.6,
      opts.fillUnder ? plot.y : undefined,
    );
  }
  if (opts.trend) {
    drawPolyline(doc, opts.trend, scaleX, scaleY, COLORS.trend, 1.0);
  }
  if (opts.goal != null && opts.goal >= domain.min && opts.goal <= domain.max) {
    drawGoalLine(doc, plot, scaleY, opts.goal, opts.goalLabel ?? "");
  }
  if (opts.markers) {
    for (const [index, label] of opts.markers) {
      const value = opts.values[index];
      if (value == null) continue;
      const x = scaleX(index);
      const y = scaleY(value);
      doc.page.drawCircle({
        x,
        y,
        size: 2.4,
        color: opts.color ?? COLORS.series1,
        borderColor: INK.white,
        borderWidth: 0.6,
      });
      if (label) {
        const width = doc.widthOf(label, 6.5);
        doc.textAt(label, x - width / 2, y + 4.5, {
          size: 6.5,
          color: INK.muted,
        });
      }
    }
  }
  if (opts.firstLastLabels) {
    const present = opts.values
      .map((value, index) => ({ value, index }))
      .filter((p): p is { value: number; index: number } => p.value != null);
    if (present.length > 0) {
      const first = present[0];
      const last = present[present.length - 1];
      doc.textAt(opts.yFormat(first.value), scaleX(first.index) + 2, scaleY(first.value) + 4, {
        size: 7.5,
        bold: true,
        color: INK.text,
      });
      if (last.index !== first.index) {
        const label = opts.yFormat(last.value);
        const width = doc.widthOf(label, 7.5, true);
        doc.textAt(label, scaleX(last.index) - width, scaleY(last.value) + 4, {
          size: 7.5,
          bold: true,
          color: INK.text,
        });
      }
    }
  }
}

export type BarChartOptions = {
  values: number[];
  goal?: number | null;
  goalLabel?: string;
  dayKeys: string[];
  yFormat: (v: number) => string;
  monthLabelFor: (dayKey: string) => string;
  todayLabel: string;
  color?: Color;
};

export function barChart(doc: Doc, rect: Rect, opts: BarChartOptions): void {
  const domain = yDomain({
    values: opts.values,
    yFormat: opts.yFormat,
    zeroBased: true,
    includeValue: opts.goal,
  });
  const { plot, scaleY } = drawFrame(
    doc,
    rect,
    domain,
    opts.yFormat,
    opts.dayKeys,
    opts.monthLabelFor,
    opts.todayLabel,
  );
  const slot = plot.width / opts.values.length;
  const barWidth = Math.max(slot - 1, 1.4);
  opts.values.forEach((value, index) => {
    if (value <= 0) return;
    const height = scaleY(value) - plot.y;
    doc.page.drawRectangle({
      x: plot.x + index * slot + (slot - barWidth) / 2,
      y: plot.y,
      width: barWidth,
      height: Math.max(height, 0.8),
      color: opts.color ?? COLORS.series1,
    });
  });
  if (opts.goal != null && opts.goal <= domain.max) {
    drawGoalLine(doc, plot, scaleY, opts.goal, opts.goalLabel ?? "");
  }
}

export type SeverityStack = { mild: number; moderate: number; severe: number };
export type HeatmapRow = { label: string; values: number[] };

export type SeverityChartOptions = {
  perDay: SeverityStack[];
  dayKeys: string[];
  monthLabelFor: (dayKey: string) => string;
  todayLabel: string;
  legend: { mild: string; moderate: string; severe: string };
};

export function severityStackChart(
  doc: Doc,
  rect: Rect,
  opts: SeverityChartOptions,
): void {
  const totals = opts.perDay.map((d) => d.mild + d.moderate + d.severe);
  const domain = yDomain({
    values: totals,
    yFormat: String,
    zeroBased: true,
  });
  const { plot, scaleY } = drawFrame(
    doc,
    rect,
    domain,
    (v) => String(Math.round(v)),
    opts.dayKeys,
    opts.monthLabelFor,
    opts.todayLabel,
    true,
  );
  const slot = plot.width / opts.perDay.length;
  const barWidth = Math.max(slot - 1, 1.4);
  opts.perDay.forEach((stack, index) => {
    const x = plot.x + index * slot + (slot - barWidth) / 2;
    let base = plot.y;
    for (
      const [key, color] of [
        ["mild", COLORS.sevMild],
        ["moderate", COLORS.sevModerate],
        ["severe", COLORS.sevSevere],
      ] as const
    ) {
      const value = stack[key];
      if (value <= 0) continue;
      const top = scaleY(value) - plot.y;
      doc.page.drawRectangle({
        x,
        y: base,
        width: barWidth,
        height: Math.max(top, 0.8),
        color,
      });
      base += top;
    }
  });
  // Legend row above the plot.
  let legendX = plot.x;
  for (
    const [label, color] of [
      [opts.legend.mild, COLORS.sevMild],
      [opts.legend.moderate, COLORS.sevModerate],
      [opts.legend.severe, COLORS.sevSevere],
    ] as const
  ) {
    doc.page.drawRectangle({
      x: legendX,
      y: plot.y + plot.height + 2,
      width: 7,
      height: 7,
      color,
    });
    doc.textAt(label, legendX + 10, plot.y + plot.height + 3, {
      size: CHART.axisFontSize,
      color: INK.muted,
    });
    legendX += 10 + doc.widthOf(label, CHART.axisFontSize) + 14;
  }
}

function blendColor(low: Color, high: Color, t: number): Color {
  const mix = Math.max(0, Math.min(1, t));
  return rgb(
    low.red + (high.red - low.red) * mix,
    low.green + (high.green - low.green) * mix,
    low.blue + (high.blue - low.blue) * mix,
  );
}

export type HeatmapChartOptions = {
  rows: HeatmapRow[];
  columnLabels: string[];
  columnGroups?: string[];
  lowLabel?: string;
  highLabel?: string;
  lowColor?: Color;
  highColor?: Color;
};

export function heatmapChart(
  doc: Doc,
  rect: Rect,
  opts: HeatmapChartOptions,
): void {
  if (opts.rows.length === 0 || opts.columnLabels.length === 0) return;

  const labelWidth = 120;
  const headerHeight = 24;
  const legendHeight = 18;
  const gridX = rect.x + labelWidth;
  const gridWidth = rect.width - labelWidth;
  const gridBottom = rect.y + legendHeight;
  const gridTop = rect.y + rect.height - headerHeight;
  const gridHeight = gridTop - gridBottom;
  const rowGap = 2;
  const colGap = 2;
  const monthGap = 6;
  const groupBreaks = opts.columnGroups?.map((group, index, groups) =>
    index > 0 && group !== groups[index - 1]
  ) ?? new Array(opts.columnLabels.length).fill(false);
  const extraGapCount = groupBreaks.filter(Boolean).length;
  const rowHeight = Math.max(
    (gridHeight - rowGap * (opts.rows.length - 1)) / opts.rows.length,
    10,
  );
  const cellWidth = Math.max(
    (gridWidth - colGap * (opts.columnLabels.length - 1) - monthGap * extraGapCount) /
      opts.columnLabels.length,
    10,
  );
  const maxValue = Math.max(
    1,
    ...opts.rows.flatMap((row) => row.values),
  );
  const lowColor = opts.lowColor ?? rgb(0.92, 0.96, 0.99);
  const highColor = opts.highColor ?? COLORS.sevSevere;

  const columnX = (index: number) => {
    let extra = 0;
    for (let i = 1; i <= index; i++) {
      if (groupBreaks[i]) extra += monthGap;
    }
    return gridX + index * (cellWidth + colGap) + extra;
  };

  const groupTopY = rect.y + rect.height - 9;
  const labelTopY = rect.y + rect.height - 20;

  if (opts.columnGroups && opts.columnGroups.length === opts.columnLabels.length) {
    let start = 0;
    while (start < opts.columnGroups.length) {
      const group = opts.columnGroups[start];
      let end = start;
      while (end + 1 < opts.columnGroups.length && opts.columnGroups[end + 1] === group) {
        end += 1;
      }
      const startX = columnX(start);
      const endX = columnX(end) + cellWidth;
      const width = doc.widthOf(group, 7, true);
      doc.textAt(group, startX + (endX - startX - width) / 2, groupTopY, {
        size: 7,
        bold: true,
        color: INK.muted,
      });
      doc.page.drawLine({
        start: { x: startX, y: labelTopY + 10 },
        end: { x: endX, y: labelTopY + 10 },
        thickness: 0.5,
        color: INK.line,
      });
      start = end + 1;
    }
  }

  opts.columnLabels.forEach((label, index) => {
    const x = columnX(index);
    doc.textAt(label, x + 1, labelTopY, {
      size: 7,
      color: INK.muted,
    });
  });

  opts.rows.forEach((row, rowIndex) => {
    const y = gridTop - rowHeight - rowIndex * (rowHeight + rowGap);
    const labelY = y + rowHeight / 2 - 3;
    const fitted = row.label.length > 24 ? `${row.label.slice(0, 23)}…` : row.label;
    doc.textAt(fitted, rect.x, labelY, {
      size: 8,
      color: INK.text,
    });
    row.values.forEach((value, columnIndex) => {
      const x = columnX(columnIndex);
      const tone = value <= 0 ? 0 : Math.min(1, value / maxValue);
      doc.page.drawRectangle({
        x,
        y,
        width: cellWidth,
        height: rowHeight,
        color: blendColor(lowColor, highColor, tone),
        borderColor: INK.white,
        borderWidth: 0.4,
      });
      if (value > 0) {
        const text = String(value);
        const size = 6;
        const textWidth = doc.widthOf(text, size, true);
        doc.textAt(text, x + (cellWidth - textWidth) / 2, y + rowHeight / 2 - 2, {
          size,
          bold: true,
          color: INK.white,
        });
      }
    });
  });

  const legendWidth = 104;
  const legendX = rect.x + rect.width - legendWidth;
  const legendY = rect.y + 1;
  const steps = 7;
  for (let index = 0; index < steps; index++) {
    doc.page.drawRectangle({
      x: legendX + index * 10,
      y: legendY,
      width: 9,
      height: 8,
      color: blendColor(lowColor, highColor, steps <= 1 ? 0 : index / (steps - 1)),
    });
  }
  doc.textAt(opts.lowLabel ?? "Low", legendX, legendY + 10, {
    size: 7,
    color: INK.muted,
  });
  const high = opts.highLabel ?? "High";
  const highWidth = doc.widthOf(high, 7);
  doc.textAt(high, legendX + legendWidth - highWidth, legendY + 10, {
    size: 7,
    color: INK.muted,
  });
}

export type WeeklyBarLineChartOptions = {
  barValues: number[];
  lineValues: (number | null)[];
  columnLabels: string[];
  columnGroups?: string[];
  leftFormat: (v: number) => string;
  rightFormat: (v: number) => string;
  barColor?: Color;
  lineColor?: Color;
  showBarLabels?: boolean;
};

export function weeklyBarLineChart(
  doc: Doc,
  rect: Rect,
  opts: WeeklyBarLineChartOptions,
): void {
  if (opts.barValues.length === 0 || opts.columnLabels.length === 0) return;

  const leftPad = 28;
  const rightPad = 34;
  const topPad = 24;
  const bottomPad = 16;
  const monthGap = 6;
  const colGap = 2;
  const groupBreaks = opts.columnGroups?.map((group, index, groups) =>
    index > 0 && group !== groups[index - 1]
  ) ?? new Array(opts.columnLabels.length).fill(false);
  const extraGapCount = groupBreaks.filter(Boolean).length;
  const plot = {
    x: rect.x + leftPad,
    y: rect.y + bottomPad,
    width: rect.width - leftPad - rightPad,
    height: rect.height - topPad - bottomPad,
  };
  const cellWidth = Math.max(
    (plot.width - colGap * (opts.columnLabels.length - 1) - monthGap * extraGapCount) /
      opts.columnLabels.length,
    10,
  );
  const maxBar = Math.max(1, ...opts.barValues);
  const barTicks = buildTicks(0, maxBar, 3).filter((t) => t >= 0 && t <= maxBar + 1e-9);
  const scaleBarY = (v: number) => plot.y + (v / maxBar) * plot.height;
  const scaleRateY = (v: number) => plot.y + (v / 100) * plot.height;
  const columnX = (index: number) => {
    let extra = 0;
    for (let i = 1; i <= index; i++) {
      if (groupBreaks[i]) extra += monthGap;
    }
    return plot.x + index * (cellWidth + colGap) + extra;
  };

  for (const tick of barTicks) {
    const y = scaleBarY(tick);
    doc.page.drawLine({
      start: { x: plot.x, y },
      end: { x: plot.x + plot.width, y },
      thickness: 0.4,
      color: INK.line,
    });
    const label = opts.leftFormat(tick);
    const width = doc.widthOf(label, 7);
    doc.textAt(label, plot.x - width - 4, y - 2.5, {
      size: 7,
      color: INK.muted,
    });
  }

  for (const tick of [0, 50, 100]) {
    const y = scaleRateY(tick);
    const label = opts.rightFormat(tick);
    doc.textAt(label, plot.x + plot.width + 4, y - 2.5, {
      size: 7,
      color: INK.muted,
    });
  }

  const groupTopY = rect.y + rect.height - 9;
  const labelTopY = rect.y + rect.height - 20;
  if (opts.columnGroups && opts.columnGroups.length === opts.columnLabels.length) {
    let start = 0;
    while (start < opts.columnGroups.length) {
      const group = opts.columnGroups[start];
      let end = start;
      while (end + 1 < opts.columnGroups.length && opts.columnGroups[end + 1] === group) {
        end += 1;
      }
      const startX = columnX(start);
      const endX = columnX(end) + cellWidth;
      const width = doc.widthOf(group, 7, true);
      doc.textAt(group, startX + (endX - startX - width) / 2, groupTopY, {
        size: 7,
        bold: true,
        color: INK.muted,
      });
      doc.page.drawLine({
        start: { x: startX, y: labelTopY + 10 },
        end: { x: endX, y: labelTopY + 10 },
        thickness: 0.5,
        color: INK.line,
      });
      start = end + 1;
    }
  }

  opts.columnLabels.forEach((label, index) => {
    const x = columnX(index);
    doc.textAt(label, x + 1, labelTopY, {
      size: 7,
      color: INK.muted,
    });
  });

  opts.barValues.forEach((value, index) => {
    if (value <= 0) return;
    const x = columnX(index);
    const y = scaleBarY(value);
    doc.page.drawRectangle({
      x,
      y: plot.y,
      width: cellWidth,
      height: Math.max(y - plot.y, 0.8),
      color: opts.barColor ?? COLORS.series3,
    });
    if (opts.showBarLabels ?? true) {
      const label = String(value);
      const labelWidth = doc.widthOf(label, 6, true);
      doc.textAt(label, x + (cellWidth - labelWidth) / 2, y + 2, {
        size: 6,
        bold: true,
        color: INK.text,
      });
    }
  });

  const points = opts.lineValues
    .map((value, index) => (value == null ? null : { x: columnX(index) + cellWidth / 2, y: scaleRateY(value) }))
    .filter((point): point is { x: number; y: number } => point != null);
  if (points.length >= 2) {
    const path = [
      `M ${points[0].x.toFixed(2)} ${(-points[0].y).toFixed(2)}`,
      ...points.slice(1).map((p) => `L ${p.x.toFixed(2)} ${(-p.y).toFixed(2)}`),
    ].join(" ");
    doc.page.drawSvgPath(path, {
      x: 0,
      y: 0,
      borderColor: opts.lineColor ?? COLORS.series1,
      borderWidth: 1.2,
    });
  }
  for (const [index, value] of opts.lineValues.entries()) {
    if (value == null) continue;
    const x = columnX(index) + cellWidth / 2;
    const y = scaleRateY(value);
    doc.page.drawCircle({
      x,
      y,
      size: 2.2,
      color: opts.lineColor ?? COLORS.series1,
      borderColor: INK.white,
      borderWidth: 0.5,
    });
  }
}

export type DivergingStackBar = {
  negativeNear: number;
  negativeFar: number;
  positiveNear: number;
  positiveFar: number;
  total: number;
};

export type DivergingStackChartOptions = {
  bars: DivergingStackBar[];
  columnLabels: string[];
  columnGroups?: string[];
  legend: {
    negativeFar: string;
    negativeNear: string;
    positiveNear: string;
    positiveFar: string;
  };
};

export function divergingStackChart(
  doc: Doc,
  rect: Rect,
  opts: DivergingStackChartOptions,
): void {
  if (opts.bars.length === 0 || opts.columnLabels.length === 0) return;

  const leftPad = 28;
  const rightPad = 4;
  const topPad = 24;
  const bottomPad = 28;
  const monthGap = 6;
  const colGap = 2;
  const groupBreaks = opts.columnGroups?.map((group, index, groups) =>
    index > 0 && group !== groups[index - 1]
  ) ?? new Array(opts.columnLabels.length).fill(false);
  const extraGapCount = groupBreaks.filter(Boolean).length;
  const plot = {
    x: rect.x + leftPad,
    y: rect.y + bottomPad,
    width: rect.width - leftPad - rightPad,
    height: rect.height - topPad - bottomPad,
  };
  const centerY = plot.y + plot.height / 2;
  const halfHeight = plot.height / 2;
  const cellWidth = Math.max(
    (plot.width - colGap * (opts.columnLabels.length - 1) - monthGap * extraGapCount) /
      opts.columnLabels.length,
    10,
  );
  const columnX = (index: number) => {
    let extra = 0;
    for (let i = 1; i <= index; i++) {
      if (groupBreaks[i]) extra += monthGap;
    }
    return plot.x + index * (cellWidth + colGap) + extra;
  };
  const scale = (share: number) => halfHeight * Math.max(0, Math.min(1, share));

  for (const tick of [0, 50, 100]) {
    const offset = halfHeight * (tick / 100);
    for (const y of [centerY + offset, centerY - offset]) {
      if (tick === 0 && y !== centerY) continue;
      doc.page.drawLine({
        start: { x: plot.x, y },
        end: { x: plot.x + plot.width, y },
        thickness: tick === 0 ? 0.7 : 0.35,
        color: tick === 0 ? INK.muted : INK.line,
      });
    }
    if (tick > 0) {
      const label = `${tick}%`;
      const width = doc.widthOf(label, 7);
      doc.textAt(label, plot.x - width - 4, centerY + offset - 2.5, {
        size: 7,
        color: INK.muted,
      });
      doc.textAt(label, plot.x - width - 4, centerY - offset - 2.5, {
        size: 7,
        color: INK.muted,
      });
    }
  }

  const groupTopY = rect.y + rect.height - 9;
  const labelTopY = rect.y + rect.height - 20;
  if (opts.columnGroups && opts.columnGroups.length === opts.columnLabels.length) {
    let start = 0;
    while (start < opts.columnGroups.length) {
      const group = opts.columnGroups[start];
      let end = start;
      while (end + 1 < opts.columnGroups.length && opts.columnGroups[end + 1] === group) {
        end += 1;
      }
      const startX = columnX(start);
      const endX = columnX(end) + cellWidth;
      const width = doc.widthOf(group, 7, true);
      doc.textAt(group, startX + (endX - startX - width) / 2, groupTopY, {
        size: 7,
        bold: true,
        color: INK.muted,
      });
      doc.page.drawLine({
        start: { x: startX, y: labelTopY + 10 },
        end: { x: endX, y: labelTopY + 10 },
        thickness: 0.5,
        color: INK.line,
      });
      start = end + 1;
    }
  }
  opts.columnLabels.forEach((label, index) => {
    const x = columnX(index);
    doc.textAt(label, x + 1, labelTopY, {
      size: 7,
      color: INK.muted,
    });
  });

  opts.bars.forEach((bar, index) => {
    if (bar.total <= 0) return;
    const x = columnX(index);
    const negFar = scale(bar.negativeFar / bar.total);
    const negNear = scale(bar.negativeNear / bar.total);
    const posNear = scale(bar.positiveNear / bar.total);
    const posFar = scale(bar.positiveFar / bar.total);

    let y = centerY - negNear;
    if (negNear > 0) {
      doc.page.drawRectangle({
        x,
        y,
        width: cellWidth,
        height: negNear,
        color: COLORS.moodOkay,
      });
    }
    if (negFar > 0) {
      doc.page.drawRectangle({
        x,
        y: y - negFar,
        width: cellWidth,
        height: negFar,
        color: COLORS.moodBad,
      });
    }
    let positiveBase = centerY;
    if (posNear > 0) {
      doc.page.drawRectangle({
        x,
        y: positiveBase,
        width: cellWidth,
        height: posNear,
        color: COLORS.moodGood,
      });
      positiveBase += posNear;
    }
    if (posFar > 0) {
      doc.page.drawRectangle({
        x,
        y: positiveBase,
        width: cellWidth,
        height: posFar,
        color: COLORS.moodGreat,
      });
    }
  });

  const legendItems = [
    [opts.legend.negativeFar, COLORS.moodBad],
    [opts.legend.negativeNear, COLORS.moodOkay],
    [opts.legend.positiveNear, COLORS.moodGood],
    [opts.legend.positiveFar, COLORS.moodGreat],
  ] as const;
  const legendWidth = legendItems.reduce(
    (sum, [label]) => sum + 10 + doc.widthOf(label, 7) + 12,
    -12,
  );
  let legendX = plot.x + plot.width - legendWidth;
  const legendY = rect.y + 10;
  for (const [label, color] of legendItems) {
    doc.page.drawRectangle({
      x: legendX,
      y: legendY,
      width: 7,
      height: 7,
      color,
    });
    doc.textAt(label, legendX + 10, legendY + 1, {
      size: 7,
      color: INK.muted,
    });
    legendX += 10 + doc.widthOf(label, 7) + 12;
  }
}

export type WeeklyStackedBarChartOptions = {
  seriesLabels: string[];
  seriesValues: number[][];
  columnLabels: string[];
  columnGroups?: string[];
  goal?: number | null;
  goalLabel?: string;
  yFormat: (v: number) => string;
  colors?: Color[];
};

export function weeklyStackedBarChart(
  doc: Doc,
  rect: Rect,
  opts: WeeklyStackedBarChartOptions,
): void {
  if (opts.seriesLabels.length === 0 || opts.columnLabels.length === 0) return;
  const leftPad = 28;
  const rightPad = 4;
  const topPad = 34;
  const bottomPad = 26;
  const monthGap = 6;
  const colGap = 2;
  const groupBreaks = opts.columnGroups?.map((group, index, groups) =>
    index > 0 && group !== groups[index - 1]
  ) ?? new Array(opts.columnLabels.length).fill(false);
  const extraGapCount = groupBreaks.filter(Boolean).length;
  const plot = {
    x: rect.x + leftPad,
    y: rect.y + bottomPad,
    width: rect.width - leftPad - rightPad,
    height: rect.height - topPad - bottomPad,
  };
  const totals = opts.columnLabels.map((_, index) =>
    opts.seriesValues.reduce((sum, series) => sum + (series[index] ?? 0), 0)
  );
  const maxValue = Math.max(1, ...totals, opts.goal ?? 0);
  const cellWidth = Math.max(
    (plot.width - colGap * (opts.columnLabels.length - 1) - monthGap * extraGapCount) /
      opts.columnLabels.length,
    10,
  );
  const columnX = (index: number) => {
    let extra = 0;
    for (let i = 1; i <= index; i++) {
      if (groupBreaks[i]) extra += monthGap;
    }
    return plot.x + index * (cellWidth + colGap) + extra;
  };
  const scaleY = (v: number) => plot.y + (v / maxValue) * plot.height;
  const ticks = buildTicks(0, maxValue, 3).filter((t) => t >= 0 && t <= maxValue + 1e-9);

  for (const tick of ticks) {
    const y = scaleY(tick);
    doc.page.drawLine({
      start: { x: plot.x, y },
      end: { x: plot.x + plot.width, y },
      thickness: 0.4,
      color: INK.line,
    });
    const label = opts.yFormat(tick);
    const width = doc.widthOf(label, 7);
    doc.textAt(label, plot.x - width - 4, y - 2.5, {
      size: 7,
      color: INK.muted,
    });
  }

  const colors = opts.colors ?? [
    COLORS.series1,
    COLORS.series2,
    COLORS.series3,
    COLORS.bmi,
    rgb(0.42, 0.42, 0.42),
  ];
  opts.columnLabels.forEach((_, index) => {
    let cumulative = 0;
    opts.seriesValues.forEach((series, seriesIndex) => {
      const value = series[index] ?? 0;
      if (value <= 0) return;
      const y = scaleY(cumulative);
      const top = scaleY(cumulative + value);
      doc.page.drawRectangle({
        x: columnX(index),
        y,
        width: cellWidth,
        height: Math.max(top - y, 0.8),
        color: colors[seriesIndex % colors.length],
      });
      cumulative += value;
    });
  });

  if (opts.goal != null && opts.goal > 0) {
    const y = scaleY(opts.goal);
    doc.page.drawLine({
      start: { x: plot.x, y },
      end: { x: plot.x + plot.width, y },
      thickness: 0.9,
      color: COLORS.goal,
      dashArray: [4, 3],
    });
    if (opts.goalLabel) {
      const width = doc.widthOf(opts.goalLabel, 7, true);
      doc.textAt(opts.goalLabel, plot.x + plot.width - width, y + 2.5, {
        size: 7,
        bold: true,
        color: COLORS.goal,
      });
    }
  }

  const groupTopY = rect.y + rect.height - 9;
  const labelTopY = rect.y + rect.height - 20;
  if (opts.columnGroups && opts.columnGroups.length === opts.columnLabels.length) {
    let start = 0;
    while (start < opts.columnGroups.length) {
      const group = opts.columnGroups[start];
      let end = start;
      while (end + 1 < opts.columnGroups.length && opts.columnGroups[end + 1] === group) {
        end += 1;
      }
      const startX = columnX(start);
      const endX = columnX(end) + cellWidth;
      const width = doc.widthOf(group, 7, true);
      doc.textAt(group, startX + (endX - startX - width) / 2, groupTopY, {
        size: 7,
        bold: true,
        color: INK.muted,
      });
      doc.page.drawLine({
        start: { x: startX, y: labelTopY + 10 },
        end: { x: endX, y: labelTopY + 10 },
        thickness: 0.5,
        color: INK.line,
      });
      start = end + 1;
    }
  }
  opts.columnLabels.forEach((label, index) => {
    doc.textAt(label, columnX(index) + 1, labelTopY, {
      size: 7,
      color: INK.muted,
    });
  });

  let legendX = plot.x;
  const legendY = rect.y + 2;
  opts.seriesLabels.forEach((label, index) => {
    const color = colors[index % colors.length];
    doc.page.drawRectangle({
      x: legendX,
      y: legendY,
      width: 7,
      height: 7,
      color,
    });
    doc.textAt(label, legendX + 10, legendY + 1, {
      size: 7,
      color: INK.muted,
    });
    legendX += 10 + doc.widthOf(label, 7) + 12;
  });
}

export type DotGridOptions = {
  dayKeys: string[];
  /** Marked day indexes; value can carry an intensity (unused -> single tone). */
  marked: Set<number>;
  markedColor?: Color;
  monthLabelFor: (dayKey: string) => string;
};

function parseDayKeyUtc(dayKey: string): Date {
  return new Date(`${dayKey}T12:00:00Z`);
}

function monthKeyFor(dayKey: string): string {
  return dayKey.slice(0, 7);
}

function daysInMonthUtc(year: number, monthIndex: number): number {
  return new Date(Date.UTC(year, monthIndex + 1, 0)).getUTCDate();
}

function monthWeekdayOffsetMonday(day: Date): number {
  return (day.getUTCDay() + 6) % 7;
}

/** Month-grouped calendar with day numbers and real week columns. */
export function dotGridCalendar(doc: Doc, rect: Rect, opts: DotGridOptions): void {
  if (opts.dayKeys.length === 0) return;

  const monthGap = 10;
  const titleHeight = 14;
  const weekdayLabelWidth = 0;
  const verticalGap = 4;
  const presentKeys = new Set(opts.dayKeys);
  const indexByKey = new Map(opts.dayKeys.map((key, index) => [key, index]));
  const monthKeys = [...new Set(opts.dayKeys.map(monthKeyFor))];
  const months = monthKeys.map((monthKey) => {
    const [year, month] = monthKey.split("-").map(Number);
    const firstDay = new Date(Date.UTC(year, month - 1, 1, 12));
    const offset = monthWeekdayOffsetMonday(firstDay);
    const dayCount = daysInMonthUtc(year, month - 1);
    const weekColumns = Math.ceil((offset + dayCount) / 7);
    return { monthKey, year, month: month - 1, offset, dayCount, weekColumns };
  });

  const totalWeekColumns = months.reduce((sum, month) => sum + month.weekColumns, 0);
  const gridWidth = rect.width - weekdayLabelWidth - monthGap * Math.max(months.length - 1, 0);
  const columnWidth = gridWidth / Math.max(totalWeekColumns, 1);
  const rowHeight = (rect.height - titleHeight - verticalGap) / 7;
  const cellWidth = Math.max(columnWidth - 2, 6);
  const cellHeight = Math.max(rowHeight - 2, 6);
  let monthX = rect.x + weekdayLabelWidth;

  for (const month of months) {
    const monthWidth = month.weekColumns * columnWidth;
    const title = opts.monthLabelFor(`${month.monthKey}-01`);
    const titleWidth = doc.widthOf(title, 7, true);
    doc.textAt(title, monthX + (monthWidth - titleWidth) / 2, rect.y + rect.height - 9, {
      size: 7,
      bold: true,
      color: INK.muted,
    });
    doc.page.drawLine({
      start: { x: monthX, y: rect.y + rect.height - titleHeight + 1 },
      end: { x: monthX + monthWidth, y: rect.y + rect.height - titleHeight + 1 },
      thickness: 0.5,
      color: INK.line,
    });

    for (let dayNumber = 1; dayNumber <= month.dayCount; dayNumber++) {
      const slot = month.offset + (dayNumber - 1);
      const week = Math.floor(slot / 7);
      const weekday = slot % 7;
      const x = monthX + week * columnWidth + (columnWidth - cellWidth) / 2;
      const y = rect.y + rect.height - titleHeight - verticalGap -
        (weekday + 1) * rowHeight + (rowHeight - cellHeight) / 2;
      const key = `${month.monthKey}-${String(dayNumber).padStart(2, "0")}`;
      const index = indexByKey.get(key);
      const inWindow = presentKeys.has(key);
      const isMarked = index !== undefined && opts.marked.has(index);

      doc.page.drawRectangle({
        x,
        y,
        width: cellWidth,
        height: cellHeight,
        color: isMarked
          ? opts.markedColor ?? COLORS.series1
          : inWindow
          ? COLORS.dotEmpty
          : INK.white,
        borderColor: INK.line,
        borderWidth: 0.35,
      });
      const label = String(dayNumber);
      const labelWidth = doc.widthOf(label, 5.5, isMarked);
      doc.textAt(label, x + cellWidth - labelWidth - 1.4, y + 1.2, {
        size: 5.5,
        bold: isMarked,
        color: isMarked ? INK.white : inWindow ? INK.muted : INK.faint,
      });
    }

    monthX += monthWidth + monthGap;
  }
}

export type HBarItem = { label: string; value: number; caption?: string };

/** Horizontal ranked bars (top symptoms). */
export function hBarList(
  doc: Doc,
  items: HBarItem[],
  opts: { maxWidth?: number; color?: Color } = {},
): void {
  if (items.length === 0) return;
  const max = Math.max(...items.map((i) => i.value));
  const labelWidth = 150;
  const valueWidth = 30;
  const barMax = (opts.maxWidth ?? 360) - labelWidth - valueWidth;
  for (const item of items) {
    doc.ensure(15);
    doc.textAt(item.label, 48, doc.y - 9, { size: 8.5 });
    const width = max > 0 ? Math.max((item.value / max) * barMax, 2) : 2;
    doc.page.drawRectangle({
      x: 48 + labelWidth,
      y: doc.y - 10.5,
      width,
      height: 8,
      color: opts.color ?? COLORS.series1,
    });
    doc.textAt(String(item.value), 48 + labelWidth + width + 5, doc.y - 9, {
      size: 8.5,
      bold: true,
    });
    doc.y -= 15;
  }
}

export type StatTile = { value: string; caption: string; subCaption?: string };

/** Row(s) of bordered stat tiles, three per row. Values shrink then truncate to fit. */
export function statTiles(doc: Doc, tiles: StatTile[], columns = 3): void {
  const gapPx = 8;
  const tileWidth = (595.28 - 96 - gapPx * (columns - 1)) / columns;
  const tileHeight = 46;
  for (let rowStart = 0; rowStart < tiles.length; rowStart += columns) {
    doc.ensure(tileHeight + gapPx);
    const row = tiles.slice(rowStart, rowStart + columns);
    row.forEach((tile, column) => {
      const x = 48 + column * (tileWidth + gapPx);
      const y = doc.y - tileHeight;
      doc.page.drawRectangle({
        x,
        y,
        width: tileWidth,
        height: tileHeight,
        borderColor: INK.line,
        borderWidth: 0.8,
      });
      doc.textAt(tile.caption, x + 8, y + tileHeight - 14, {
        size: 7,
        color: INK.muted,
      });
      const maxWidth = tileWidth - 16;
      let size = 14;
      while (size > 9 && doc.widthOf(tile.value, size, true) > maxWidth) {
        size -= 1;
      }
      let value = tile.value;
      while (value.length > 1 && doc.widthOf(value + "…", size, true) > maxWidth) {
        value = value.slice(0, -1);
      }
      if (value !== tile.value) value += "…";
      doc.textAt(value, x + 8, y + 14, { size, bold: true });
      if (tile.subCaption) {
        doc.textAt(tile.subCaption, x + 8, y + 4, {
          size: 6.5,
          color: INK.faint,
        });
      }
    });
    doc.y -= tileHeight + gapPx;
  }
}

/** Compact sparkline with endpoint labels; no axes. */
export function sparkline(
  doc: Doc,
  rect: Rect,
  values: (number | null)[],
  yFormat: (v: number) => string,
): void {
  const present = values.filter((v): v is number => v != null);
  if (present.length === 0) return;
  const min = Math.min(...present);
  const max = Math.max(...present);
  const pad = 36;
  const scaleY = (v: number) =>
    rect.y + 6 +
    (max === min ? 0.5 : (v - min) / (max - min)) * (rect.height - 12);
  const scaleX = (i: number) =>
    rect.x + pad +
    (values.length <= 1 ? 0 : (i / (values.length - 1)) * (rect.width - pad * 2));
  drawPolyline(doc, values, scaleX, scaleY, COLORS.series1, 1.4);
  const points = values
    .map((value, index) => ({ value, index }))
    .filter((p): p is { value: number; index: number } => p.value != null);
  const first = points[0];
  const last = points[points.length - 1];
  for (const point of [first, last]) {
    doc.page.drawCircle({
      x: scaleX(point.index),
      y: scaleY(point.value),
      size: 2,
      color: COLORS.series1,
    });
  }
  doc.textAt(yFormat(first.value), rect.x, scaleY(first.value) - 3, {
    size: 7.5,
    bold: true,
  });
  doc.textAt(yFormat(last.value), rect.x + rect.width - pad + 4, scaleY(last.value) - 3, {
    size: 7.5,
    bold: true,
  });
}
