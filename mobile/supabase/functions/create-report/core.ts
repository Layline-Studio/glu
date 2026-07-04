import { PDFDocument, rgb, StandardFonts } from "https://esm.sh/pdf-lib@1.17.1";

type Profile = {
  settings: Record<string, unknown>;
  goals: Record<string, unknown> | null;
};

type Records = {
  weight: Array<Record<string, unknown>> | null;
  doses: Array<Record<string, unknown>> | null;
};

export async function generateReportPdf(
  profile: Profile,
  records: Records,
): Promise<Uint8Array> {
  const pdfDoc = await PDFDocument.create();
  const font = await pdfDoc.embedFont(StandardFonts.Helvetica);
  const fontBold = await pdfDoc.embedFont(StandardFonts.HelveticaBold);

  const pageWidth = 595.28; // A4
  const pageHeight = 841.89;
  const margin = 50;
  const contentWidth = pageWidth - margin * 2;

  const colorPrimary = rgb(0.18, 0.35, 0.62);
  const colorText = rgb(0.1, 0.1, 0.1);
  const colorMuted = rgb(0.45, 0.45, 0.45);
  const colorLine = rgb(0.85, 0.85, 0.85);

  let page = pdfDoc.addPage([pageWidth, pageHeight]);
  let y = pageHeight - margin;

  const newPage = () => {
    page = pdfDoc.addPage([pageWidth, pageHeight]);
    y = pageHeight - margin;
  };

  const checkSpace = (needed: number) => {
    if (y - needed < margin + 40) newPage();
  };

  const drawLine = () => {
    page.drawLine({
      start: { x: margin, y },
      end: { x: pageWidth - margin, y },
      thickness: 0.5,
      color: colorLine,
    });
    y -= 12;
  };

  const drawText = (
    text: string,
    opts: {
      size?: number;
      bold?: boolean;
      color?: ReturnType<typeof rgb>;
      indent?: number;
    } = {},
  ) => {
    const size = opts.size ?? 10;
    const f = opts.bold ? fontBold : font;
    const color = opts.color ?? colorText;
    const x = margin + (opts.indent ?? 0);
    page.drawText(text, { x, y, size, font: f, color });
    y -= size + 4;
  };

  const drawSectionHeader = (title: string) => {
    checkSpace(30);
    y -= 6;
    page.drawRectangle({
      x: margin,
      y: y - 2,
      width: contentWidth,
      height: 18,
      color: rgb(0.93, 0.95, 0.98),
    });
    drawText(title, { size: 11, bold: true, color: colorPrimary });
    y -= 4;
  };

  const drawRow = (label: string, value: string) => {
    checkSpace(16);
    page.drawText(label, { x: margin, y, size: 9, font, color: colorMuted });
    page.drawText(value, { x: margin + 160, y, size: 9, font: fontBold, color: colorText });
    y -= 14;
  };

  // --- Header ---
  page.drawRectangle({
    x: 0,
    y: pageHeight - 70,
    width: pageWidth,
    height: 70,
    color: colorPrimary,
  });
  page.drawText("Glu Health Report", {
    x: margin,
    y: pageHeight - 38,
    size: 20,
    font: fontBold,
    color: rgb(1, 1, 1),
  });
  const generatedDate = new Date().toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
  page.drawText(`Generated: ${generatedDate}`, {
    x: margin,
    y: pageHeight - 58,
    size: 9,
    font,
    color: rgb(0.8, 0.87, 0.97),
  });
  y = pageHeight - 90;

  // --- Profile Section ---
  const settings = profile.settings ?? {};
  const preferredName = (settings["preferred_name"] as string | undefined)?.trim() ?? "—";
  const age = settings["age"] as number | undefined;
  const heightVal = settings["height"] as Record<string, unknown> | undefined;
  const weightVal = settings["weight"] as Record<string, unknown> | undefined;
  const medicationName = (settings["medication_name"] as string | undefined)?.trim() ?? "—";
  const currentDoseMg = settings["current_dose_mg"] as number | undefined;

  const formatHeight = (h: Record<string, unknown> | undefined): string => {
    if (!h) return "—";
    const unit = h["unit"] as string | undefined;
    const primary = h["primary"] as number | undefined;
    if (unit === "metric" && primary != null) return `${primary} cm`;
    if (unit === "imperial" && primary != null) {
      const feet = Math.floor(primary);
      const inches = Math.round((primary - feet) * 12);
      return `${feet}'${inches}"`;
    }
    return "—";
  };

  const formatWeight = (w: Record<string, unknown> | undefined): string => {
    if (!w) return "—";
    const unit = w["unit"] as string | undefined;
    const primary = w["primary"] as number | undefined;
    if (primary == null) return "—";
    return `${primary} ${unit ?? "kg"}`;
  };

  drawSectionHeader("Patient Profile");
  drawRow("Name", preferredName);
  drawRow("Age", age != null ? `${age} years` : "—");
  drawRow("Height", formatHeight(heightVal));
  drawRow("Weight (on file)", formatWeight(weightVal));
  drawRow("Medication", medicationName);
  drawRow("Current dose", currentDoseMg != null ? `${currentDoseMg} mg` : "—");
  y -= 6;

  // --- Goals Section ---
  const goals = profile.goals as Record<string, unknown> | null;
  const weightGoal = goals?.["weight"] as Record<string, unknown> | undefined;
  const weightGoalEntries = weightGoal?.["entries"] as Array<Record<string, unknown>> | undefined;
  const latestGoalEntry = weightGoalEntries?.slice(-1)[0];
  const targetKg = latestGoalEntry?.["target_kg"] as number | undefined;
  const targetUnit = (latestGoalEntry?.["target_unit"] as string | undefined) ?? "kg";
  const timeframe = latestGoalEntry?.["timeframe"] as string | undefined;

  drawSectionHeader("Goals");
  if (targetKg != null) {
    const displayTarget = targetUnit === "lb"
      ? `${(targetKg * 2.20462).toFixed(1)} lb`
      : `${targetKg.toFixed(1)} kg`;
    drawRow("Target weight", displayTarget);
  } else {
    drawRow("Target weight", "Not set");
  }
  drawRow("Timeframe", timeframe ?? "—");
  y -= 6;

  // --- Weight History Section ---
  const weightEntries = (records.weight ?? []).slice(-30);
  drawSectionHeader(`Weight History (last ${weightEntries.length} entries)`);

  if (weightEntries.length === 0) {
    drawText("No weight entries recorded.", { color: colorMuted, indent: 8 });
  } else {
    // Column headers
    checkSpace(14);
    page.drawText("Date", { x: margin + 8, y, size: 9, font: fontBold, color: colorMuted });
    page.drawText("Weight", { x: margin + 160, y, size: 9, font: fontBold, color: colorMuted });
    y -= 14;
    drawLine();

    for (const entry of weightEntries) {
      checkSpace(14);
      const recordedAt = entry["recorded_at"] as string | undefined;
      const quantity = entry["quantity"] as number | undefined;
      const unit = (entry["unit"] as string | undefined) ?? "kg";
      const dateStr = recordedAt
        ? new Date(recordedAt).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })
        : "—";
      const weightStr = quantity != null ? `${quantity} ${unit}` : "—";
      page.drawText(dateStr, { x: margin + 8, y, size: 9, font, color: colorText });
      page.drawText(weightStr, { x: margin + 160, y, size: 9, font, color: colorText });
      y -= 14;
    }
  }
  y -= 6;

  // --- Medication Log Section ---
  const doseEntries = (records.doses ?? []).slice(-30);
  drawSectionHeader(`Medication Log (last ${doseEntries.length} entries)`);

  if (doseEntries.length === 0) {
    drawText("No dose entries recorded.", { color: colorMuted, indent: 8 });
  } else {
    checkSpace(14);
    page.drawText("Date", { x: margin + 8, y, size: 9, font: fontBold, color: colorMuted });
    page.drawText("Dose (mg)", { x: margin + 160, y, size: 9, font: fontBold, color: colorMuted });
    page.drawText("Notes", { x: margin + 260, y, size: 9, font: fontBold, color: colorMuted });
    y -= 14;
    drawLine();

    for (const entry of doseEntries) {
      checkSpace(14);
      const recordedAt = entry["recorded_at"] as string | undefined;
      const quantity = entry["quantity"] as number | undefined;
      const note = (entry["note"] as string | undefined)?.trim() ?? "";
      const dateStr = recordedAt
        ? new Date(recordedAt).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })
        : "—";
      const doseStr = quantity != null ? `${quantity}` : "—";
      page.drawText(dateStr, { x: margin + 8, y, size: 9, font, color: colorText });
      page.drawText(doseStr, { x: margin + 160, y, size: 9, font, color: colorText });
      if (note) {
        page.drawText(note.substring(0, 40), { x: margin + 260, y, size: 9, font, color: colorMuted });
      }
      y -= 14;
    }
  }
  y -= 6;

  // --- Footer disclaimer ---
  checkSpace(40);
  y = margin + 30;
  drawLine();
  page.drawText(
    "Glu is a tracking tool, not a medical device. This report does not constitute medical advice.",
    { x: margin, y, size: 7, font, color: colorMuted },
  );
  y -= 10;
  page.drawText(
    "Always consult your healthcare provider about your medication and health decisions.",
    { x: margin, y, size: 7, font, color: colorMuted },
  );

  return pdfDoc.save();
}
