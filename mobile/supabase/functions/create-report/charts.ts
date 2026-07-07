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

function drawPolyline(
  doc: Doc,
  values: (number | null)[],
  scaleX: (i: number) => number,
  scaleY: (v: number) => number,
  color: Color,
  thickness: number,
  fillTo?: number,
): void {
  const segments = polylineSegments(values, scaleX, scaleY);
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

export type DotGridOptions = {
  dayKeys: string[];
  /** Marked day indexes; value can carry an intensity (unused -> single tone). */
  marked: Set<number>;
  markedColor?: Color;
  monthLabelFor: (dayKey: string) => string;
};

/** 13-week × 7-day dot calendar (GitHub-style), oldest week first. */
export function dotGridCalendar(doc: Doc, rect: Rect, opts: DotGridOptions): void {
  const weeks = Math.ceil(opts.dayKeys.length / 7);
  const cell = 9;
  const gapPx = 2.6;
  const gridWidth = weeks * (cell + gapPx);
  const x0 = rect.x;
  const y0 = rect.y + rect.height - cell - 12;

  let lastMonth = "";
  for (let index = 0; index < opts.dayKeys.length; index++) {
    const week = Math.floor(index / 7);
    const day = index % 7;
    const x = x0 + week * (cell + gapPx);
    const y = y0 - day * (cell + gapPx);
    doc.page.drawRectangle({
      x,
      y,
      width: cell,
      height: cell,
      color: opts.marked.has(index)
        ? opts.markedColor ?? COLORS.series1
        : COLORS.dotEmpty,
    });
    // Month initial above the first column of each new month.
    if (day === 0) {
      const month = opts.monthLabelFor(opts.dayKeys[index]);
      if (month !== lastMonth) {
        doc.textAt(month, x, y0 + cell + 4, {
          size: 7,
          color: INK.muted,
        });
        lastMonth = month;
      }
    }
  }
  // Keep the grid inside the reserved rect (defensive; sizes are fixed).
  void gridWidth;
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
