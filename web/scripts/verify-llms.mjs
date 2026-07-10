import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

const requiredFiles = ['llms.txt', 'llms-small.txt', 'llms-full.txt'];
const distDir = join(process.cwd(), 'dist');

const readGeneratedFile = async (fileName) => {
  const filePath = join(distDir, fileName);

  try {
    const content = await readFile(filePath, 'utf8');
    const trimmed = content.trim();

    if (trimmed.length === 0) {
      throw new Error(`${fileName} is empty`);
    }

    return trimmed;
  } catch (error) {
    throw new Error(`Missing or invalid ${fileName}: ${error.message}`);
  }
};

const files = await Promise.all(requiredFiles.map(readGeneratedFile));
const [index, small, full] = files;

const requiredIndexLinks = [
  'https://myglu.health/llms-small.txt',
  'https://myglu.health/llms-full.txt',
  'https://apps.apple.com/us/app/glu-glp-1-weight-loss-tracker/id6761419458',
  'https://play.google.com/store/apps/details?id=ventures.layline.glu',
];

const requiredContentMarkers = [
  'Glu',
  'GLP-1 tracking app',
  'shot reminders',
  'injection sites',
  'weight trends',
  'support',
  'privacy',
  'terms',
  'delete account',
  'GLP-1 Guides',
  'GLP-1 Glossary',
  'The GLP-1 shot tracker, on one printable page',
];

for (const link of requiredIndexLinks) {
  if (!index.includes(link)) {
    throw new Error(`llms.txt is missing ${link}`);
  }
}

for (const marker of requiredContentMarkers) {
  if (!index.includes(marker) && !small.includes(marker) && !full.includes(marker)) {
    throw new Error(`Generated LLM docs are missing expected marker: ${marker}`);
  }
}

console.log('llms.txt files verified');
