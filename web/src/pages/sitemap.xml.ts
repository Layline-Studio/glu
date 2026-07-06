import { join } from 'node:path';
import { stat } from 'node:fs/promises';
import { getCollection } from 'astro:content';
import { getLocalePath, localizedLocales } from '../i18n/config';

export const prerender = true;

const GUIDES_PAGE_SIZE = 9;

const homeSource = join(process.cwd(), 'src/pages/index.astro');
const localeHomeSource = join(process.cwd(), 'src/pages/[locale]/index.astro');

const pages = [
  { loc: '/', source: homeSource },
  ...localizedLocales.map((locale) => ({ loc: getLocalePath(locale), source: localeHomeSource })),
  { loc: '/about', source: join(process.cwd(), 'src/pages/about.astro') },
  { loc: '/delete-account', source: join(process.cwd(), 'src/pages/delete-account.astro') },
  { loc: '/glp-1-injection-tracker', source: join(process.cwd(), 'src/pages/glp-1-injection-tracker.astro') },
  { loc: '/printable-glp-1-tracker', source: join(process.cwd(), 'src/pages/printable-glp-1-tracker.astro') },
  { loc: '/privacy', source: join(process.cwd(), 'src/pages/privacy.astro') },
  { loc: '/support', source: join(process.cwd(), 'src/pages/support.astro') },
  { loc: '/terms', source: join(process.cwd(), 'src/pages/terms.astro') },
];

const formatLastMod = async (source: string) => {
  const pageStat = await stat(source);
  return pageStat.mtime.toISOString().slice(0, 10);
};

export async function GET() {
  const guides = await getCollection('guides', ({ data }) => !data.draft);
  const glossary = await getCollection('glossary');
  const guideLastMod =
    guides
      .map((guide) => (guide.data.updatedDate ?? guide.data.pubDate).toISOString().slice(0, 10))
      .sort()
      .at(-1) ?? new Date().toISOString().slice(0, 10);
  const guidePageCount = Math.max(1, Math.ceil(guides.length / GUIDES_PAGE_SIZE));

  const urls = [
    ...(await Promise.all(
      pages.map(async (page) => ({
        loc: page.loc,
        lastmod: await formatLastMod(page.source),
      })),
    )),
    ...Array.from({ length: guidePageCount }, (_, index) => ({
      loc: index === 0 ? '/guides' : `/guides/${index + 1}`,
      lastmod: guideLastMod,
    })),
    ...guides.map((guide) => ({
      loc: `/guides/${guide.id}`,
      lastmod: (guide.data.updatedDate ?? guide.data.pubDate).toISOString().slice(0, 10),
    })),
    {
      loc: '/glossary',
      lastmod: glossary
        .map((entry) => entry.data.pubDate.toISOString().slice(0, 10))
        .sort()
        .at(-1) ?? new Date().toISOString().slice(0, 10),
    },
    ...glossary.map((entry) => ({
      loc: `/glossary/${entry.id}`,
      lastmod: entry.data.pubDate.toISOString().slice(0, 10),
    })),
  ];

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls
  .map(
    (page) => `  <url>
    <loc>https://myglu.health${page.loc}</loc>
    <lastmod>${page.lastmod}</lastmod>
  </url>`,
  )
  .join('\n')}
</urlset>`;

  return new Response(xml, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
    },
  });
}
