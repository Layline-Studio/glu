import { join } from 'node:path';
import { stat } from 'node:fs/promises';

export const prerender = true;

const pages = [
  { loc: '/', source: join(process.cwd(), 'src/pages/index.astro') },
  { loc: '/about', source: join(process.cwd(), 'src/pages/about.astro') },
  { loc: '/delete-account', source: join(process.cwd(), 'src/pages/delete-account.astro') },
  { loc: '/privacy', source: join(process.cwd(), 'src/pages/privacy.astro') },
  { loc: '/support', source: join(process.cwd(), 'src/pages/support.astro') },
  { loc: '/terms', source: join(process.cwd(), 'src/pages/terms.astro') },
];

const formatLastMod = async (source: string) => {
  const pageStat = await stat(source);
  return pageStat.mtime.toISOString().slice(0, 10);
};

export async function GET() {
  const urls = await Promise.all(
    pages.map(async (page) => ({
      loc: page.loc,
      lastmod: await formatLastMod(page.source),
    })),
  );

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
