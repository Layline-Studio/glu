// Font loading and embedding. Latin/Cyrillic locales use Noto Sans
// Regular + Bold; zh uses Noto Sans SC (Regular only — headings are styled
// by size/color instead of weight). The SC font is a TTF pre-subsetted to
// GB2312 hanzi + Latin (fontkit can only subset glyf outlines, and the full
// font is 17 MB). Fonts are bundled as static files (see
// [functions.create-report] in supabase/config.toml) and read lazily so
// non-zh requests never touch the CJK file.

import { PDFDocument, PDFFont } from "pdf-lib";
import fontkit from "@pdf-lib/fontkit";
import type { ReportLocale } from "./i18n.ts";

export type FontSet = {
  regular: PDFFont;
  bold: PDFFont;
  /** Codepoints the embedded fonts can render; used to sanitize user notes. */
  supportedCodepoints: Set<number>;
};

async function readFont(fileName: string): Promise<Uint8Array> {
  return await Deno.readFile(new URL(`./fonts/${fileName}`, import.meta.url));
}

export async function embedFonts(
  pdfDoc: PDFDocument,
  locale: ReportLocale,
): Promise<FontSet> {
  pdfDoc.registerFontkit(fontkit);

  if (locale === "zh") {
    // No runtime subsetting: fontkit mangles glyph IDs when subsetting this
    // CJK font. The file is already pre-subsetted to GB2312 + Latin (~2.3 MB)
    // and compresses well inside the PDF.
    const bytes = await readFont("NotoSansSC-Regular.ttf");
    const font = await pdfDoc.embedFont(bytes, { subset: false });
    return {
      regular: font,
      bold: font,
      supportedCodepoints: new Set(font.getCharacterSet()),
    };
  }

  const [regularBytes, boldBytes] = await Promise.all([
    readFont("NotoSans-Regular.ttf"),
    readFont("NotoSans-Bold.ttf"),
  ]);
  const [regular, bold] = await Promise.all([
    pdfDoc.embedFont(regularBytes, { subset: true }),
    pdfDoc.embedFont(boldBytes, { subset: true }),
  ]);
  return {
    regular,
    bold,
    supportedCodepoints: new Set(regular.getCharacterSet()),
  };
}

/**
 * Replaces characters the embedded font cannot render (emoji, unsupported
 * scripts in user notes) so drawText never throws.
 */
export function sanitizeForFont(text: string, fonts: FontSet): string {
  let sanitized = "";
  for (const char of text) {
    const codepoint = char.codePointAt(0)!;
    // Strip variation selectors and zero-width joiners entirely.
    if (
      (codepoint >= 0xfe00 && codepoint <= 0xfe0f) ||
      codepoint === 0x200d
    ) {
      continue;
    }
    sanitized += fonts.supportedCodepoints.has(codepoint) ? char : "?";
  }
  return sanitized;
}
