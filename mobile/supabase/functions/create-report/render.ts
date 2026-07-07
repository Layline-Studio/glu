// Page composition: executive summary followed by one page per tracked
// feature (weight, medication, symptoms, mood, nutrition, hydration,
// exercise), skipping features with no data in the 90-day window.

import { PDFDocument, rgb } from "pdf-lib";
import {
  LB_PER_KG,
  NormalizedRecords,
  PatientProfile,
  RawProfile,
  RawRecords,
  ReportWindow,
  buildReportWindow,
  normalizeProfile,
  normalizeRecords,
} from "./data.ts";
import {
  averageOf,
  averagePerDay,
  bmiSeries,
  buildMedicationLevelSeries,
  computeAdherence,
  cravingIntensityStackPerDay,
  cravingOutcomeDistribution,
  cravingTypeFrequency,
  daysMeetingGoal,
  effectiveCalories,
  effectiveFiber,
  effectiveProtein,
  exerciseByActivity,
  injectionSiteUsage,
  latestPerDay,
  loggingConsistency,
  moodDistribution,
  moodScore,
  movingAverageSparse,
  severityStackPerDay,
  sumPerDay,
  symptomFrequency,
  weightSummary,
} from "./aggregate.ts";
import {
  DateFormatters,
  NumberFormatters,
  StringKey,
  Translate,
  makeDateFmt,
  makeNumFmt,
  makeT,
  resolveReportLocale,
} from "./i18n.ts";
import { embedFonts } from "./fonts.ts";
import { CONTENT_WIDTH, Doc, INK, PAGE, renderNotes } from "./layout.ts";
import type { NoteItem } from "./layout.ts";
import {
  CHART,
  COLORS,
  barChart,
  dotGridCalendar,
  hBarList,
  lineChart,
  severityStackChart,
  sparkline,
  statTiles,
} from "./charts.ts";
import type { StatTile } from "./charts.ts";

type Ctx = {
  doc: Doc;
  t: Translate;
  dateFmt: DateFormatters;
  num: NumberFormatters;
  window: ReportWindow;
  records: NormalizedRecords;
  profile: PatientProfile;
  monthLabelFor: (dayKey: string) => string;
  na: string;
};

export async function generateReportPdf(input: {
  profile: RawProfile;
  records: RawRecords;
  now?: Date;
}): Promise<Uint8Array> {
  const profile = normalizeProfile(input.profile);
  const window = buildReportWindow(profile.timeZone, input.now ?? new Date());
  const records = normalizeRecords(input.records, window);

  const locale = resolveReportLocale(profile.appLocale);
  const t = makeT(locale);
  const dateFmt = makeDateFmt(locale, window.timeZone);
  const num = makeNumFmt(locale);
  const monthFmt = new Intl.DateTimeFormat(locale, {
    month: "short",
    timeZone: "UTC",
  });
  const monthLabelFor = (dayKey: string) =>
    monthFmt.format(new Date(`${dayKey}T12:00:00Z`));

  const pdfDoc = await PDFDocument.create();
  pdfDoc.setTitle(t("report.title"));
  pdfDoc.setProducer("Glu");
  pdfDoc.setCreationDate(window.now);
  const fonts = await embedFonts(pdfDoc, locale);
  const doc = new Doc(pdfDoc, fonts, t, t("report.generatedOn", {
    date: dateFmt.long(window.now),
  }));

  const ctx: Ctx = {
    doc,
    t,
    dateFmt,
    num,
    window,
    records,
    profile,
    monthLabelFor,
    na: t("common.na"),
  };

  const features: {
    key: StringKey;
    hasData: boolean;
    render: (ctx: Ctx) => void;
  }[] = [
    { key: "feature.weight", hasData: records.weight.length > 0, render: renderWeightPage },
    { key: "feature.medication", hasData: records.doses.length > 0, render: renderMedicationPage },
    { key: "feature.symptoms", hasData: records.symptoms.length > 0, render: renderSymptomsPage },
    { key: "feature.cravings", hasData: records.cravings.length > 0, render: renderCravingsPage },
    { key: "feature.mood", hasData: records.mood.length > 0, render: renderMoodPage },
    { key: "feature.nutrition", hasData: records.meals.length > 0, render: renderNutritionPage },
    { key: "feature.hydration", hasData: records.water.length > 0, render: renderHydrationPage },
    { key: "feature.exercise", hasData: records.exercise.length > 0, render: renderExercisePage },
  ];

  renderSummaryPage(ctx, features.filter((f) => !f.hasData).map((f) => t(f.key)));

  for (const feature of features) {
    if (!feature.hasData) continue;
    doc.newPage();
    doc.pageHeader(t(feature.key), windowSubtitle(ctx));
    feature.render(ctx);
  }

  doc.finishFooters();
  return await pdfDoc.save();
}

function windowSubtitle(ctx: Ctx): string {
  const startKey = ctx.window.dayKeys[0];
  const start = new Date(`${startKey}T12:00:00Z`);
  return ctx.t("report.window", {
    start: ctx.dateFmt.short(start),
    end: ctx.dateFmt.short(ctx.window.now),
  });
}

// --- Display helpers ---

function kgToDisplay(kg: number, unit: "kg" | "lb"): number {
  return unit === "lb" ? kg * LB_PER_KG : kg;
}

function weightLabel(ctx: Ctx, kg: number, decimals: 0 | 1 = 1): string {
  const unit = ctx.profile.displayWeightUnit;
  const value = kgToDisplay(kg, unit);
  return `${decimals === 0 ? ctx.num.n0(value) : ctx.num.n1(value)} ${unit}`;
}

function doseLabel(ctx: Ctx, doseMg: number): string {
  const value = Number.isInteger(doseMg)
    ? ctx.num.n0(doseMg)
    : String(doseMg).replace(".", decimalSeparator(ctx));
  return `${value} mg`;
}

function decimalSeparator(ctx: Ctx): string {
  return ctx.num.n1(1.1).replace(/1/g, "");
}

// --- Summary page ---

function renderSummaryPage(ctx: Ctx, untrackedFeatures: string[]): void {
  const { doc, t, records, profile, num } = ctx;

  // Brand header band.
  doc.page.drawRectangle({
    x: 0,
    y: PAGE.height - 76,
    width: PAGE.width,
    height: 76,
    color: INK.primary,
  });
  doc.textAt(t("report.title"), PAGE.margin, PAGE.height - 38, {
    size: 20,
    bold: true,
    color: INK.white,
  });
  doc.textAt(
    `${t("report.generatedOn", { date: ctx.dateFmt.long(ctx.window.now) })} · ${windowSubtitle(ctx)}`,
    PAGE.margin,
    PAGE.height - 58,
    { size: 8.5, color: rgb(0.85, 0.91, 0.98) },
  );
  doc.y = PAGE.height - 96;

  // Patient block: two-column key/value grid.
  doc.sectionTitle(t("summary.patient"));
  const leftRows: [string, string][] = [
    [t("summary.name"), profile.preferredName ?? ctx.na],
    [
      t("summary.age"),
      profile.age != null ? t("summary.years", { n: num.n0(profile.age) }) : ctx.na,
    ],
    [t("summary.gender"), profile.gender ?? ctx.na],
    [
      t("summary.height"),
      profile.heightCm != null ? `${num.n0(profile.heightCm)} cm` : ctx.na,
    ],
    [
      t("summary.startWeight"),
      profile.medicationStartWeightKg != null
        ? weightLabel(ctx, profile.medicationStartWeightKg)
        : ctx.na,
    ],
  ];
  const rightRows: [string, string][] = [
    [t("summary.medication"), profile.medicationName ?? ctx.na],
    [
      t("summary.currentDose"),
      profile.currentDoseMg != null ? doseLabel(ctx, profile.currentDoseMg) : ctx.na,
    ],
    [
      t("summary.method"),
      profile.medicationMethod === "pill"
        ? t("med.pill")
        : profile.medicationMethod === "injection"
        ? t("med.injection")
        : ctx.na,
    ],
    [
      t("summary.frequency"),
      profile.daysBetweenDoses != null
        ? t("med.everyNDays", { n: num.n0(profile.daysBetweenDoses) })
        : profile.medicationFrequency ?? ctx.na,
    ],
    [
      t("summary.startedOn"),
      profile.medicationStartedAt != null
        ? ctx.dateFmt.long(profile.medicationStartedAt)
        : ctx.na,
    ],
  ];
  const columnWidth = CONTENT_WIDTH / 2;
  const startY = doc.y;
  for (const [index, [label, value]] of leftRows.entries()) {
    const y = startY - index * 14 - 9;
    doc.textAt(label, PAGE.margin, y, { size: 9, color: INK.muted });
    doc.textAt(value, PAGE.margin + 92, y, { size: 9, bold: true });
  }
  for (const [index, [label, value]] of rightRows.entries()) {
    const y = startY - index * 14 - 9;
    doc.textAt(label, PAGE.margin + columnWidth, y, { size: 9, color: INK.muted });
    doc.textAt(value, PAGE.margin + columnWidth + 105, y, { size: 9, bold: true });
  }
  doc.y = startY - leftRows.length * 14 - 8;

  // Key metric tiles.
  const summary = weightSummary(records.weight, profile.heightCm);
  const level = buildMedicationLevelSeries(
    records.dosesForLevelCurve,
    profile.medicationName,
    ctx.window,
  );
  const adherence = computeAdherence(records.doses, profile, ctx.window);
  const topSymptoms = symptomFrequency(records.symptoms)
    .filter((s) => s.symptom !== "no_symptoms")
    .slice(0, 3);
  const moods = records.mood;
  const avgMood = moods.length > 0
    ? moods.reduce((sum, entry) => sum + moodScore(entry.feeling), 0) / moods.length
    : null;
  const consistency = loggingConsistency(records, ctx.window);

  doc.sectionTitle(t("summary.keyMetrics"));
  const tiles: StatTile[] = [
    {
      caption: t("summary.weightChange"),
      value: summary.deltaKg != null
        ? `${num.signed1(kgToDisplay(summary.deltaKg, profile.displayWeightUnit))} ${profile.displayWeightUnit}`
        : ctx.na,
      subCaption: summary.deltaPct != null
        ? `${num.signed1(summary.deltaPct)}%`
        : undefined,
    },
    {
      caption: t("summary.estLevel"),
      value: level ? `${num.n1(level.currentMg)} mg` : ctx.na,
      subCaption: level
        ? t("summary.ofPeak", { pct: level.currentPercentOfPeak })
        : undefined,
    },
    {
      caption: t("summary.adherence"),
      value: adherence.adherencePct != null ? num.pct(adherence.adherencePct) : ctx.na,
      subCaption: adherence.expectedCount != null
        ? t("summary.dosesTaken", {
          taken: adherence.actualCount,
          expected: adherence.expectedCount,
        })
        : undefined,
    },
    {
      caption: t("summary.topSymptoms"),
      value: topSymptoms.length > 0
        ? topSymptoms.map((s) => symptomLabel(ctx, s.symptom)).join(", ")
        : t("common.none"),
    },
    {
      caption: t("summary.avgMood"),
      value: avgMood != null ? moodLabelForScore(ctx, avgMood) : ctx.na,
      subCaption: avgMood != null ? `${num.n1(avgMood)} / 4` : undefined,
    },
    {
      caption: t("summary.consistency"),
      value: num.pct(consistency.pctOfDays),
      subCaption: t("summary.daysLogged", {
        n: consistency.daysWithAnyLog,
        total: consistency.totalDays,
      }),
    },
  ];
  // Shrink long symptom lists to fit the tile.
  statTiles(doc, tiles.map((tile) => ({
    ...tile,
    value: tile.value.length > 34 ? tile.value.slice(0, 33) + "…" : tile.value,
  })));

  // Weight sparkline.
  if (records.weight.length > 0) {
    doc.gap(6);
    doc.text(t("summary.weightTrend"), { size: 9, bold: true, color: INK.muted });
    const rect = doc.reserve(CHART.sparklineHeight);
    const kgSeries = latestPerDay(records.weight, ctx.window, (e) => e.kg);
    const displaySeries = kgSeries.map((v) =>
      v == null ? null : kgToDisplay(v, profile.displayWeightUnit)
    );
    sparkline(doc, rect, displaySeries, (v) => num.n1(v));
  }

  // Logging calendar.
  doc.gap(10);
  doc.text(t("summary.activityCalendar"), { size: 9, bold: true, color: INK.muted });
  const calendarRect = doc.reserve(7 * 11.6 + 18);
  dotGridCalendar(doc, calendarRect, {
    dayKeys: ctx.window.dayKeys,
    marked: consistency.loggedDayIndexes,
    monthLabelFor: ctx.monthLabelFor,
  });

  if (untrackedFeatures.length > 0) {
    doc.gap(8);
    doc.text(
      t("summary.notTracked", { features: untrackedFeatures.join(", ") }),
      { size: 8.5, color: INK.muted },
    );
  }
}

function symptomLabel(ctx: Ctx, symptom: string): string {
  const key = `symptom.${symptom}` as StringKey;
  const label = ctx.t(key);
  // Unknown symptom values fall through as the raw slug.
  return label === key ? symptom.replaceAll("_", " ") : label;
}

function moodLabelForScore(ctx: Ctx, score: number): string {
  if (score < 1.5) return ctx.t("mood.bad");
  if (score < 2.5) return ctx.t("mood.okay");
  if (score < 3.5) return ctx.t("mood.good");
  return ctx.t("mood.great");
}

// --- Weight page ---

function renderWeightPage(ctx: Ctx): void {
  const { doc, t, records, profile, num } = ctx;
  const unit = profile.displayWeightUnit;
  const kgSeries = latestPerDay(records.weight, ctx.window, (e) => e.kg);
  const displaySeries = kgSeries.map((v) => (v == null ? null : kgToDisplay(v, unit)));
  const trend = movingAverageSparse(displaySeries, 7);
  const goal = profile.goals.weightTargetKg != null
    ? kgToDisplay(profile.goals.weightTargetKg, unit)
    : null;
  // Only draw the goal line when it's near the data; a far-away target would
  // compress the trend into a flat band. The goal always shows as a tile.
  const present = displaySeries.filter((v): v is number => v != null);
  const dataMin = present.length > 0 ? Math.min(...present) : 0;
  const dataMax = present.length > 0 ? Math.max(...present) : 0;
  const pad = Math.max((dataMax - dataMin) * 0.15, dataMax * 0.02);
  const chartGoal = goal != null && goal >= dataMin - pad && goal <= dataMax + pad
    ? goal
    : null;

  doc.text(t("weight.chartTitle"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  lineChart(doc, rect, {
    values: displaySeries,
    trend,
    goal: chartGoal,
    goalLabel: chartGoal != null
      ? `${t("common.goal")} ${num.n1(chartGoal)} ${unit}`
      : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => num.n1(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    firstLastLabels: true,
  });

  const summary = weightSummary(records.weight, profile.heightCm);
  doc.gap(10);
  statTiles(doc, [
    {
      caption: t("weight.start"),
      value: summary.firstKg != null ? weightLabel(ctx, summary.firstKg) : ctx.na,
    },
    {
      caption: t("weight.current"),
      value: summary.lastKg != null ? weightLabel(ctx, summary.lastKg) : ctx.na,
    },
    {
      caption: t("weight.change"),
      value: summary.deltaKg != null
        ? `${num.signed1(kgToDisplay(summary.deltaKg, unit))} ${unit}`
        : ctx.na,
      subCaption: summary.deltaPct != null ? `${num.signed1(summary.deltaPct)}%` : undefined,
    },
    {
      caption: t("weight.goal"),
      value: goal != null ? `${num.n1(goal)} ${unit}` : ctx.na,
    },
  ], 4);

  // BMI trajectory.
  if (profile.heightCm != null) {
    const bmi = bmiSeries(kgSeries, profile.heightCm);
    if (bmi.some((v) => v != null)) {
      doc.gap(8);
      doc.text(
        `${t("weight.bmiTrajectory")}${
          summary.currentBmi != null
            ? ` · ${t("weight.bmi")} ${num.n1(summary.currentBmi)}`
            : ""
        }`,
        { size: 9.5, bold: true, color: INK.muted },
      );
      const bmiRect = doc.reserve(CHART.miniHeight);
      lineChart(doc, bmiRect, {
        values: bmi,
        dayKeys: ctx.window.dayKeys,
        yFormat: (v) => num.n1(v),
        monthLabelFor: ctx.monthLabelFor,
        todayLabel: t("common.today"),
        color: COLORS.bmi,
      });
    }
  }
}

// --- Medication page ---

function renderMedicationPage(ctx: Ctx): void {
  const { doc, t, records, profile, num } = ctx;

  const level = buildMedicationLevelSeries(
    records.dosesForLevelCurve,
    profile.medicationName,
    ctx.window,
  );
  if (level) {
    doc.text(`${t("med.levelCurve")} — ${level.medication}`, {
      size: 9.5,
      bold: true,
      color: INK.muted,
    });
    const rect = doc.reserve(CHART.height);
    // Label a dose dot only when the dose changed from the previous one.
    const markers = new Map<number, string>();
    let previousDose: number | null = null;
    for (const [index, doseMg] of [...level.doseDayIndexes.entries()].sort((a, b) => a[0] - b[0])) {
      markers.set(index, doseMg !== previousDose ? doseLabel(ctx, doseMg) : "");
      previousDose = doseMg;
    }
    lineChart(doc, rect, {
      values: level.values,
      dayKeys: ctx.window.dayKeys,
      yFormat: (v) => num.n1(v),
      monthLabelFor: ctx.monthLabelFor,
      todayLabel: t("common.today"),
      zeroBased: true,
      fillUnder: true,
      markers,
    });
    doc.text(t("med.levelCaption", { hours: level.halfLifeHours }), {
      size: 7.5,
      color: INK.faint,
    });
    doc.gap(8);
  }

  // Adherence tiles.
  const adherence = computeAdherence(records.doses, profile, ctx.window);
  statTiles(doc, [
    {
      caption: t("med.adherence"),
      value: adherence.adherencePct != null ? num.pct(adherence.adherencePct) : ctx.na,
      subCaption: adherence.expectedIntervalDays != null
        ? t("med.everyNDays", { n: num.n0(adherence.expectedIntervalDays) })
        : undefined,
    },
    {
      caption: `${t("med.taken")} / ${t("med.expected")}`,
      value: adherence.expectedCount != null
        ? `${adherence.actualCount} / ${adherence.expectedCount}`
        : String(adherence.actualCount),
      subCaption: adherence.missedCount != null
        ? `${t("med.missed")}: ${adherence.missedCount}`
        : undefined,
    },
    {
      caption: t("med.medianInterval"),
      value: adherence.medianActualIntervalDays != null
        ? t("med.nDays", { n: num.n1(adherence.medianActualIntervalDays) })
        : ctx.na,
    },
  ]);

  // Dose-day calendar.
  doc.gap(6);
  doc.text(t("med.doseDays"), { size: 9, bold: true, color: INK.muted });
  const calendarRect = doc.reserve(7 * 11.6 + 18);
  const doseDayIndexes = new Set<number>(
    level ? [...level.doseDayIndexes.keys()] : [],
  );
  dotGridCalendar(doc, calendarRect, {
    dayKeys: ctx.window.dayKeys,
    marked: doseDayIndexes,
    monthLabelFor: ctx.monthLabelFor,
  });

  // Injection site rotation.
  const usage = injectionSiteUsage(records.doses);
  if (usage.length > 0) {
    doc.gap(4);
    doc.sectionTitle(t("med.siteRotation"));
    doc.ensure(14);
    const columns = [PAGE.margin + 8, PAGE.margin + 230, PAGE.margin + 300];
    doc.textAt(t("med.site"), columns[0], doc.y - 9, { size: 8, bold: true, color: INK.muted });
    doc.textAt(t("med.uses"), columns[1], doc.y - 9, { size: 8, bold: true, color: INK.muted });
    doc.textAt(t("med.lastUsed"), columns[2], doc.y - 9, { size: 8, bold: true, color: INK.muted });
    doc.y -= 13;
    doc.hRule();
    for (const site of usage) {
      doc.ensure(13);
      const groupKey = `siteGroup.${site.group}` as StringKey;
      const siteKey = `site.${site.site}` as StringKey;
      const label = ctx.t(siteKey) === siteKey
        ? `${ctx.t(groupKey)} — ${site.site}`
        : ctx.t(siteKey);
      doc.textAt(label, columns[0], doc.y - 9, { size: 8.5 });
      doc.textAt(String(site.count), columns[1], doc.y - 9, { size: 8.5, bold: true });
      doc.textAt(
        site.lastUsedAt ? ctx.dateFmt.short(site.lastUsedAt) : ctx.na,
        columns[2],
        doc.y - 9,
        { size: 8.5, color: INK.muted },
      );
      doc.y -= 13;
    }
  }

  // Dose log (most recent first, capped).
  doc.gap(4);
  doc.sectionTitle(t("med.doseLog"));
  const columns = [
    PAGE.margin + 8,
    PAGE.margin + 80,
    PAGE.margin + 210,
    PAGE.margin + 265,
    PAGE.margin + 330,
  ];
  doc.ensure(14);
  doc.textAt(t("med.date"), columns[0], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("med.medication"), columns[1], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("med.dose"), columns[2], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("med.method"), columns[3], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("med.site"), columns[4], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.y -= 13;
  doc.hRule();
  const MAX_ROWS = 20;
  const recent = [...records.doses].reverse();
  for (const dose of recent.slice(0, MAX_ROWS)) {
    doc.ensure(13);
    const siteKey = `site.${dose.injectionSite}` as StringKey;
    doc.textAt(ctx.dateFmt.short(dose.loggedAt), columns[0], doc.y - 9, { size: 8.5 });
    doc.textAt(dose.medication, columns[1], doc.y - 9, { size: 8.5 });
    doc.textAt(doseLabel(ctx, dose.doseMg), columns[2], doc.y - 9, { size: 8.5, bold: true });
    doc.textAt(
      dose.method === "pill" ? t("med.pill") : t("med.injection"),
      columns[3],
      doc.y - 9,
      { size: 8.5 },
    );
    doc.textAt(
      dose.injectionSite
        ? (ctx.t(siteKey) === siteKey ? dose.injectionSite : ctx.t(siteKey))
        : ctx.na,
      columns[4],
      doc.y - 9,
      { size: 8.5, color: INK.muted },
    );
    doc.y -= 13;
  }
  if (recent.length > MAX_ROWS) {
    doc.text(t("common.more", { n: recent.length - MAX_ROWS }), {
      size: 8.5,
      color: INK.muted,
      x: PAGE.margin + 8,
    });
  }

  renderNotes(doc, t("common.notes"), doseNotes(ctx));
}

function doseNotes(ctx: Ctx): NoteItem[] {
  return [...ctx.records.doses]
    .reverse()
    .filter((d) => d.notes)
    .map((d) => ({ date: ctx.dateFmt.short(d.loggedAt), text: d.notes! }));
}

// --- Symptoms page ---

function renderSymptomsPage(ctx: Ctx): void {
  const { doc, t, records } = ctx;

  doc.text(t("symptoms.dailyChart"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  severityStackChart(doc, rect, {
    perDay: severityStackPerDay(records.symptoms, ctx.window),
    dayKeys: ctx.window.dayKeys,
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    legend: {
      mild: t("severity.mild"),
      moderate: t("severity.moderate"),
      severe: t("severity.severe"),
    },
  });

  doc.gap(10);
  doc.sectionTitle(
    `${t("symptoms.topSymptoms")} · ${t("symptoms.entries", { n: records.symptoms.length })}`,
  );
  const ranked = symptomFrequency(records.symptoms)
    .filter((s) => s.symptom !== "no_symptoms")
    .slice(0, 10)
    .map((s) => ({ label: symptomLabel(ctx, s.symptom), value: s.count }));
  hBarList(doc, ranked);

  renderNotes(
    doc,
    t("common.notes"),
    [...records.symptoms]
      .reverse()
      .filter((s) => s.notes)
      .map((s) => ({
        date: ctx.dateFmt.short(s.loggedAt),
        text: `${s.symptoms.map((v) => symptomLabel(ctx, v)).join(", ")} (${
          t(`severity.${s.severity}` as StringKey)
        }): ${s.notes!}`,
      })),
  );
}

// --- Cravings page ---

function cravingTypeLabel(ctx: Ctx, type: string): string {
  const key = `craving.${type}` as StringKey;
  const label = ctx.t(key);
  // Unknown type values fall through as the raw slug.
  return label === key ? type.replaceAll("_", " ") : label;
}

function renderCravingsPage(ctx: Ctx): void {
  const { doc, t, records } = ctx;

  doc.text(t("cravings.dailyChart"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  severityStackChart(doc, rect, {
    perDay: cravingIntensityStackPerDay(records.cravings, ctx.window),
    dayKeys: ctx.window.dayKeys,
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    legend: {
      mild: t("cravingIntensity.mild"),
      moderate: t("cravingIntensity.moderate"),
      severe: t("cravingIntensity.strong"),
    },
  });

  doc.gap(10);
  doc.sectionTitle(
    `${t("cravings.topTypes")} · ${t("cravings.entries", { n: records.cravings.length })}`,
  );
  const ranked = cravingTypeFrequency(records.cravings)
    .map((c) => ({ label: cravingTypeLabel(ctx, c.type), value: c.count }));
  hBarList(doc, ranked);

  doc.gap(10);
  const outcome = cravingOutcomeDistribution(records.cravings);
  statTiles(doc, [
    { caption: t("cravings.resisted"), value: String(outcome.resisted) },
    { caption: t("cravings.gaveIn"), value: String(outcome.gaveIn) },
    { caption: t("cravings.unspecified"), value: String(outcome.unspecified) },
  ], 3);

  renderNotes(
    doc,
    t("common.notes"),
    [...records.cravings]
      .reverse()
      .filter((c) => c.notes)
      .map((c) => ({
        date: ctx.dateFmt.short(c.loggedAt),
        text: `${cravingTypeLabel(ctx, c.type)}${
          c.intensity ? ` (${t(`cravingIntensity.${c.intensity}` as StringKey)})` : ""
        }${c.outcome ? ` — ${t(`outcome.${c.outcome}` as StringKey)}` : ""}: ${c.notes!}`,
      })),
  );
}

// --- Mood page ---

function renderMoodPage(ctx: Ctx): void {
  const { doc, t, records, num } = ctx;

  const series = averagePerDay(records.mood, ctx.window, (e) => moodScore(e.feeling));
  doc.text(t("mood.dailyAvg"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  const moodTickLabels: Record<number, string> = {
    1: t("mood.bad"),
    2: t("mood.okay"),
    3: t("mood.good"),
    4: t("mood.great"),
  };
  lineChart(doc, rect, {
    values: series,
    trend: movingAverageSparse(series, 7),
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => moodTickLabels[Math.round(v)] ?? num.n0(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    domain: { min: 1, max: 4 },
    pointsOnly: true,
  });

  doc.gap(10);
  const distribution = moodDistribution(records.mood);
  statTiles(doc, [
    { caption: t("mood.great"), value: String(distribution.great) },
    { caption: t("mood.good"), value: String(distribution.good) },
    { caption: t("mood.okay"), value: String(distribution.okay) },
    { caption: t("mood.bad"), value: String(distribution.bad) },
  ], 4);

  renderNotes(
    doc,
    t("common.notes"),
    [...records.mood]
      .reverse()
      .filter((m) => m.notes)
      .map((m) => ({
        date: ctx.dateFmt.short(m.loggedAt),
        text: `${t(`mood.${m.feeling}` as StringKey)}: ${m.notes!}`,
      })),
  );
}

// --- Nutrition page ---

function renderNutritionPage(ctx: Ctx): void {
  const { doc, t, records, profile, num } = ctx;

  const calories = sumPerDay(records.meals, ctx.window, effectiveCalories);
  const caloriesGoal = profile.goals.mealsGoalMode === "calories"
    ? profile.goals.mealsGoalDailyValue
    : null;
  doc.text(t("nutrition.caloriesChart"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height - 30);
  barChart(doc, rect, {
    values: calories,
    goal: caloriesGoal,
    goalLabel: caloriesGoal != null
      ? `${t("common.goal")} ${num.n0(caloriesGoal)}`
      : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => num.n0(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
  });

  const protein = sumPerDay(records.meals, ctx.window, effectiveProtein);
  doc.gap(8);
  doc.text(t("nutrition.proteinChart"), { size: 9, bold: true, color: INK.muted });
  const proteinRect = doc.reserve(CHART.miniHeight);
  barChart(doc, proteinRect, {
    values: protein,
    goal: profile.goals.proteinTargetGramsDaily,
    goalLabel: profile.goals.proteinTargetGramsDaily != null
      ? `${t("common.goal")} ${num.n0(profile.goals.proteinTargetGramsDaily)} g`
      : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => num.n0(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    color: COLORS.series2,
  });

  const fiber = sumPerDay(records.meals, ctx.window, effectiveFiber);
  doc.gap(8);
  doc.text(t("nutrition.fiberChart"), { size: 9, bold: true, color: INK.muted });
  const fiberRect = doc.reserve(CHART.miniHeight);
  barChart(doc, fiberRect, {
    values: fiber,
    goal: profile.goals.fiberTargetGramsDaily,
    goalLabel: profile.goals.fiberTargetGramsDaily != null
      ? `${t("common.goal")} ${num.n0(profile.goals.fiberTargetGramsDaily)} g`
      : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => num.n0(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
    color: COLORS.series3,
  });

  doc.gap(10);
  const avgCalories = averageOf(calories);
  const avgProtein = averageOf(protein);
  const avgFiber = averageOf(fiber);
  statTiles(doc, [
    {
      caption: t("nutrition.avgCalories"),
      value: avgCalories != null ? num.n0(avgCalories) : ctx.na,
      subCaption: t("nutrition.mealsLogged") + `: ${records.meals.length}`,
    },
    {
      caption: t("nutrition.avgProtein"),
      value: avgProtein != null ? `${num.n0(avgProtein)} g` : ctx.na,
    },
    {
      caption: t("nutrition.avgFiber"),
      value: avgFiber != null ? `${num.n0(avgFiber)} g` : ctx.na,
    },
  ]);

  renderNotes(
    doc,
    t("common.notes"),
    [...records.meals]
      .reverse()
      .filter((m) => m.notes)
      .map((m) => ({
        date: ctx.dateFmt.short(m.loggedAt),
        text: m.name ? `${m.name} — ${m.notes!}` : m.notes!,
      })),
  );
}

// --- Hydration page ---

function renderHydrationPage(ctx: Ctx): void {
  const { doc, t, records, profile, num } = ctx;

  const water = sumPerDay(records.water, ctx.window, (e) => e.ml);
  const goal = profile.goals.waterTargetMlDaily;
  doc.text(t("hydration.chart"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  barChart(doc, rect, {
    values: water,
    goal,
    goalLabel: goal != null ? `${t("common.goal")} ${formatMl(num, goal)}` : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => formatMl(num, v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
  });

  doc.gap(10);
  const average = averageOf(water);
  const goalDays = daysMeetingGoal(water, goal);
  statTiles(doc, [
    {
      caption: t("hydration.avgDaily"),
      value: average != null ? formatMl(num, average) : ctx.na,
    },
    {
      caption: t("hydration.goalMet"),
      value: goalDays != null
        ? t("summary.daysLogged", { n: goalDays, total: ctx.window.dayKeys.length })
        : ctx.na,
    },
  ], 2);
}

function formatMl(num: NumberFormatters, ml: number): string {
  return ml >= 1000 ? `${num.n1(ml / 1000)} L` : `${num.n0(ml)} ml`;
}

// --- Exercise page ---

function renderExercisePage(ctx: Ctx): void {
  const { doc, t, records, profile, num } = ctx;

  const minutes = sumPerDay(records.exercise, ctx.window, (e) => e.durationMinutes);
  const goal = profile.goals.exerciseTargetMinutesDaily;
  doc.text(t("exercise.chart"), { size: 9.5, bold: true, color: INK.muted });
  const rect = doc.reserve(CHART.height);
  barChart(doc, rect, {
    values: minutes,
    goal,
    goalLabel: goal != null ? `${t("common.goal")} ${num.n0(goal)}` : undefined,
    dayKeys: ctx.window.dayKeys,
    yFormat: (v) => num.n0(v),
    monthLabelFor: ctx.monthLabelFor,
    todayLabel: t("common.today"),
  });

  doc.gap(10);
  doc.sectionTitle(t("exercise.byActivity"));
  const byActivity = exerciseByActivity(records.exercise);
  const columns = [PAGE.margin + 8, PAGE.margin + 190, PAGE.margin + 260, PAGE.margin + 340];
  doc.ensure(14);
  doc.textAt(t("exercise.activity"), columns[0], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("exercise.sessions"), columns[1], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("exercise.totalMin"), columns[2], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.textAt(t("exercise.intensity"), columns[3], doc.y - 9, { size: 8, bold: true, color: INK.muted });
  doc.y -= 13;
  doc.hRule();
  for (const activity of byActivity.slice(0, 15)) {
    doc.ensure(13);
    doc.textAt(activity.activityType, columns[0], doc.y - 9, { size: 8.5 });
    doc.textAt(String(activity.sessions), columns[1], doc.y - 9, { size: 8.5 });
    doc.textAt(num.n0(activity.totalMinutes), columns[2], doc.y - 9, { size: 8.5, bold: true });
    doc.textAt(
      t(`intensity.${activity.dominantIntensity}` as StringKey),
      columns[3],
      doc.y - 9,
      { size: 8.5, color: INK.muted },
    );
    doc.y -= 13;
  }

  renderNotes(
    doc,
    t("common.notes"),
    [...records.exercise]
      .reverse()
      .filter((e) => e.notes)
      .map((e) => ({
        date: ctx.dateFmt.short(e.loggedAt),
        text: `${e.activityType}: ${e.notes!}`,
      })),
  );
}
