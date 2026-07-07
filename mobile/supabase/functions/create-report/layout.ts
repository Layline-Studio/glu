// Reusable page layout engine: cursor-based flow with automatic page breaks,
// wrapped text, key/value rows, section titles and per-page footers.

import { PDFDocument, PDFFont, PDFPage, rgb } from "pdf-lib";
import type { FontSet } from "./fonts.ts";
import { sanitizeForFont } from "./fonts.ts";
import type { Translate } from "./i18n.ts";

export const PAGE = {
  width: 595.28, // A4
  height: 841.89,
  margin: 48,
  footerHeight: 40,
} as const;

export const CONTENT_WIDTH = PAGE.width - PAGE.margin * 2;

export const INK = {
  text: rgb(0.06, 0.06, 0.06),
  muted: rgb(0.42, 0.42, 0.42),
  faint: rgb(0.62, 0.62, 0.62),
  line: rgb(0.85, 0.85, 0.85),
  primary: rgb(0.165, 0.471, 0.839), // #2a78d6
  headerBg: rgb(0.93, 0.95, 0.98),
  white: rgb(1, 1, 1),
} as const;

type TextOptions = {
  size?: number;
  bold?: boolean;
  color?: ReturnType<typeof rgb>;
  x?: number;
  maxWidth?: number;
  lineHeight?: number;
};

export class Doc {
  readonly pdfDoc: PDFDocument;
  readonly fonts: FontSet;
  readonly t: Translate;
  page!: PDFPage;
  y = 0;
  private footerNote: string;

  constructor(pdfDoc: PDFDocument, fonts: FontSet, t: Translate, footerNote: string) {
    this.pdfDoc = pdfDoc;
    this.fonts = fonts;
    this.t = t;
    this.footerNote = footerNote;
    this.newPage();
  }

  newPage(): void {
    this.page = this.pdfDoc.addPage([PAGE.width, PAGE.height]);
    this.y = PAGE.height - PAGE.margin;
  }

  /** Ensures `height` points fit above the footer; breaks the page if not. */
  ensure(height: number): boolean {
    if (this.y - height < PAGE.margin + PAGE.footerHeight) {
      this.newPage();
      return true;
    }
    return false;
  }

  font(bold: boolean): PDFFont {
    return bold ? this.fonts.bold : this.fonts.regular;
  }

  clean(text: string): string {
    return sanitizeForFont(text, this.fonts);
  }

  widthOf(text: string, size: number, bold = false): number {
    return this.font(bold).widthOfTextAtSize(this.clean(text), size);
  }

  wrapText(text: string, size: number, maxWidth: number, bold = false): string[] {
    const font = this.font(bold);
    const clean = this.clean(text).replace(/\s+/g, " ").trim();
    if (!clean) return [];
    const words = clean.split(" ");
    const lines: string[] = [];
    let current = "";
    for (const word of words) {
      const candidate = current ? `${current} ${word}` : word;
      if (font.widthOfTextAtSize(candidate, size) <= maxWidth) {
        current = candidate;
        continue;
      }
      if (current) lines.push(current);
      // Hard-break tokens wider than the column.
      if (font.widthOfTextAtSize(word, size) > maxWidth) {
        let chunk = "";
        for (const char of word) {
          if (font.widthOfTextAtSize(chunk + char, size) > maxWidth) {
            lines.push(chunk);
            chunk = char;
          } else {
            chunk += char;
          }
        }
        current = chunk;
      } else {
        current = word;
      }
    }
    if (current) lines.push(current);
    return lines;
  }

  /** Draws wrapped text at the cursor; advances y; returns height used. */
  text(value: string, opts: TextOptions = {}): number {
    const size = opts.size ?? 9;
    const lineHeight = opts.lineHeight ?? size + 3.5;
    const x = opts.x ?? PAGE.margin;
    const maxWidth = opts.maxWidth ?? PAGE.width - PAGE.margin - x;
    const lines = this.wrapText(value, size, maxWidth, opts.bold ?? false);
    for (const line of lines) {
      this.ensure(lineHeight);
      this.page.drawText(line, {
        x,
        y: this.y - size,
        size,
        font: this.font(opts.bold ?? false),
        color: opts.color ?? INK.text,
      });
      this.y -= lineHeight;
    }
    return lines.length * lineHeight;
  }

  /** Single-line text at an absolute position (no cursor movement, no wrap). */
  textAt(
    value: string,
    x: number,
    y: number,
    opts: { size?: number; bold?: boolean; color?: ReturnType<typeof rgb> } = {},
  ): void {
    this.page.drawText(this.clean(value), {
      x,
      y,
      size: opts.size ?? 9,
      font: this.font(opts.bold ?? false),
      color: opts.color ?? INK.text,
    });
  }

  keyValueRow(label: string, value: string, labelWidth = 150): void {
    this.ensure(14);
    this.textAt(label, PAGE.margin, this.y - 9, { size: 9, color: INK.muted });
    this.textAt(value, PAGE.margin + labelWidth, this.y - 9, {
      size: 9,
      bold: true,
    });
    this.y -= 14;
  }

  sectionTitle(title: string): void {
    this.ensure(30);
    this.y -= 4;
    this.page.drawRectangle({
      x: PAGE.margin,
      y: this.y - 16,
      width: CONTENT_WIDTH,
      height: 18,
      color: INK.headerBg,
    });
    this.textAt(title, PAGE.margin + 6, this.y - 12, {
      size: 10.5,
      bold: true,
      color: INK.primary,
    });
    this.y -= 24;
  }

  hRule(): void {
    this.ensure(10);
    this.page.drawLine({
      start: { x: PAGE.margin, y: this.y - 4 },
      end: { x: PAGE.width - PAGE.margin, y: this.y - 4 },
      thickness: 0.5,
      color: INK.line,
    });
    this.y -= 10;
  }

  gap(points: number): void {
    this.y -= points;
  }

  /** Reserves a rect of the given height at the cursor and advances past it. */
  reserve(height: number): { x: number; y: number; width: number; height: number } {
    this.ensure(height);
    const rect = {
      x: PAGE.margin,
      y: this.y - height,
      width: CONTENT_WIDTH,
      height,
    };
    this.y -= height;
    return rect;
  }

  /** Feature-page header band (title over brand color). */
  pageHeader(title: string, subtitle: string): void {
    this.page.drawRectangle({
      x: 0,
      y: PAGE.height - 64,
      width: PAGE.width,
      height: 64,
      color: INK.primary,
    });
    this.textAt(title, PAGE.margin, PAGE.height - 36, {
      size: 17,
      bold: true,
      color: INK.white,
    });
    this.textAt(subtitle, PAGE.margin, PAGE.height - 52, {
      size: 8.5,
      color: rgb(0.85, 0.91, 0.98),
    });
    this.y = PAGE.height - 84;
  }

  /** Truncates a string with an ellipsis so it fits within maxWidth. */
  private fitToWidth(text: string, size: number, maxWidth: number): string {
    let value = this.clean(text);
    if (this.fonts.regular.widthOfTextAtSize(value, size) <= maxWidth) {
      return value;
    }
    while (
      value.length > 1 &&
      this.fonts.regular.widthOfTextAtSize(value + "…", size) > maxWidth
    ) {
      value = value.slice(0, -1);
    }
    return value + "…";
  }

  /** Draws footers (disclaimer + page numbers) on every page. Call once at the end. */
  finishFooters(): void {
    const pages = this.pdfDoc.getPages();
    const total = pages.length;
    // Keep the disclaimer clear of the right-aligned page label.
    const disclaimerMaxWidth = PAGE.width - PAGE.margin * 2 - 110;
    pages.forEach((page, index) => {
      page.drawLine({
        start: { x: PAGE.margin, y: PAGE.margin + 24 },
        end: { x: PAGE.width - PAGE.margin, y: PAGE.margin + 24 },
        thickness: 0.5,
        color: INK.line,
      });
      page.drawText(
        this.fitToWidth(this.t("report.disclaimer1"), 6.5, disclaimerMaxWidth),
        {
          x: PAGE.margin,
          y: PAGE.margin + 13,
          size: 6.5,
          font: this.fonts.regular,
          color: INK.faint,
        },
      );
      page.drawText(
        this.fitToWidth(this.t("report.disclaimer2"), 6.5, disclaimerMaxWidth),
        {
          x: PAGE.margin,
          y: PAGE.margin + 4,
          size: 6.5,
          font: this.fonts.regular,
          color: INK.faint,
        },
      );
      const pageLabel = this.clean(
        this.t("report.page", { n: index + 1, total }),
      );
      const labelWidth = this.fonts.regular.widthOfTextAtSize(pageLabel, 7.5);
      page.drawText(pageLabel, {
        x: PAGE.width - PAGE.margin - labelWidth,
        y: PAGE.margin + 13,
        size: 7.5,
        font: this.fonts.regular,
        color: INK.muted,
      });
      if (this.footerNote) {
        const noteWidth = this.fonts.regular.widthOfTextAtSize(
          this.clean(this.footerNote),
          7.5,
        );
        page.drawText(this.clean(this.footerNote), {
          x: PAGE.width - PAGE.margin - noteWidth,
          y: PAGE.margin + 4,
          size: 7.5,
          font: this.fonts.regular,
          color: INK.faint,
        });
      }
    });
  }
}

export type NoteItem = { date: string; text: string };

/**
 * Renders a "Notes" block: newest-first `date — note` lines, each clamped to
 * 3 wrapped lines with ellipsis, capped at 20 notes with a "+N more" line.
 */
export function renderNotes(doc: Doc, title: string, notes: NoteItem[]): void {
  if (notes.length === 0) return;
  const MAX_NOTES = 20;
  const shown = notes.slice(0, MAX_NOTES);
  doc.sectionTitle(title);
  for (const note of shown) {
    const prefix = `${note.date} — `;
    const lines = doc.wrapText(
      prefix + note.text,
      8.5,
      CONTENT_WIDTH - 8,
    );
    const clamped = lines.slice(0, 3);
    if (lines.length > 3) {
      clamped[2] = clamped[2].replace(/.{3}$/, "") + "…";
    }
    doc.ensure(clamped.length * 12 + 4);
    for (const [index, line] of clamped.entries()) {
      doc.textAt(line, PAGE.margin + 8, doc.y - 8.5, {
        size: 8.5,
        color: index === 0 ? INK.text : INK.muted,
      });
      doc.y -= 12;
    }
    doc.y -= 4;
  }
  if (notes.length > MAX_NOTES) {
    doc.text(doc.t("common.more", { n: notes.length - MAX_NOTES }), {
      size: 8.5,
      color: INK.muted,
      x: PAGE.margin + 8,
    });
  }
}
