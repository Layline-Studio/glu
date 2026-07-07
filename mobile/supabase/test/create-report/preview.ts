// Generates sample doctor-report PDFs from synthetic data so the result can
// be inspected without a running Supabase stack.
//
// Usage (from mobile/):
//   ./scripts/preview_report.sh [locale ...]
// or directly:
//   cd supabase/functions && deno run --allow-read --allow-write \
//     ../test/create-report/preview.ts [outDir] [locale ...]
//
// Defaults: outDir = ../../build/report-preview, locales = en.

import { generateReportPdf } from "../../functions/create-report/render.ts";
import { fullFixture } from "./fixture.ts";

const [outDirArg, ...localeArgs] = Deno.args;
const outDir = outDirArg ?? "../../build/report-preview";
const locales = localeArgs.length > 0 ? localeArgs : ["en"];
const now = new Date();

await Deno.mkdir(outDir, { recursive: true });

for (const locale of locales) {
  const fixture = fullFixture(locale, now);
  const bytes = await generateReportPdf({ ...fixture, now });
  const path = `${outDir}/glu-report-sample-${locale}.pdf`;
  await Deno.writeFile(path, bytes);
  console.log(`${path} (${(bytes.length / 1024).toFixed(0)} KB)`);
}
