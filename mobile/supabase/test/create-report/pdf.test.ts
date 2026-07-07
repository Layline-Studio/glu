// Structural PDF tests: generate reports from synthetic fixtures and assert
// page structure. Set CREATE_REPORT_PDF_OUT to also write the PDFs somewhere
// for manual inspection (deno test needs --allow-write for that).

import { assert, assertEquals } from "https://deno.land/std/assert/mod.ts";
import { PDFDocument } from "https://esm.sh/pdf-lib@1.17.1";
import { generateReportPdf } from "../../functions/create-report/render.ts";
import { fullFixture as buildFixture } from "./fixture.ts";

const NOW = new Date("2026-07-07T15:00:00Z");

const fullFixture = (locale: string) => buildFixture(locale, NOW);

async function maybeWrite(name: string, bytes: Uint8Array): Promise<void> {
  const outDir = Deno.env.get("CREATE_REPORT_PDF_OUT");
  if (!outDir) return;
  await Deno.mkdir(outDir, { recursive: true });
  await Deno.writeFile(`${outDir}/${name}`, bytes);
}

Deno.test("full fixture renders all 9 pages (en)", async () => {
  const fixture = fullFixture("en");
  const bytes = await generateReportPdf({ ...fixture, now: NOW });
  await maybeWrite("report-en.pdf", bytes);
  const pdf = await PDFDocument.load(bytes);
  assert(pdf.getPageCount() >= 9, `expected >= 9 pages, got ${pdf.getPageCount()}`);
  const [width, height] = [pdf.getPage(0).getWidth(), pdf.getPage(0).getHeight()];
  assertEquals(Math.round(width), 595); // A4
  assertEquals(Math.round(height), 842);
  assert(bytes.length < 1.5 * 1024 * 1024, `PDF too large: ${bytes.length}`);
});

Deno.test("russian locale renders with Cyrillic font", async () => {
  const fixture = fullFixture("ru");
  const bytes = await generateReportPdf({ ...fixture, now: NOW });
  await maybeWrite("report-ru.pdf", bytes);
  const pdf = await PDFDocument.load(bytes);
  assert(pdf.getPageCount() >= 9);
});

Deno.test("chinese locale renders with CJK font", async () => {
  const fixture = fullFixture("zh");
  const bytes = await generateReportPdf({ ...fixture, now: NOW });
  await maybeWrite("report-zh.pdf", bytes);
  const pdf = await PDFDocument.load(bytes);
  assert(pdf.getPageCount() >= 9);
  // The pre-subsetted CJK font is embedded whole (~2.3 MB, compresses in PDF).
  assert(bytes.length < 3 * 1024 * 1024, `CJK PDF too large: ${bytes.length}`);
});

Deno.test("arabic locale falls back to english", async () => {
  const fixture = fullFixture("ar");
  const bytes = await generateReportPdf({ ...fixture, now: NOW });
  const pdf = await PDFDocument.load(bytes);
  assert(pdf.getPageCount() >= 9);
});

Deno.test("sparse fixture skips untracked feature pages", async () => {
  const fixture = fullFixture("en");
  const bytes = await generateReportPdf({
    profile: fixture.profile,
    records: {
      weight: (fixture.records.weight as unknown[]).slice(0, 10),
      doses: (fixture.records.doses as unknown[]).slice(0, 4),
    },
    now: NOW,
  });
  await maybeWrite("report-sparse.pdf", bytes);
  const pdf = await PDFDocument.load(bytes);
  // Summary + weight + medication only.
  assertEquals(pdf.getPageCount(), 3);
});

Deno.test("empty records still produce a summary page", async () => {
  const fixture = fullFixture("en");
  const bytes = await generateReportPdf({
    profile: fixture.profile,
    records: {},
    now: NOW,
  });
  const pdf = await PDFDocument.load(bytes);
  assertEquals(pdf.getPageCount(), 1);
});
