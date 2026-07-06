// @ts-check
import { defineConfig } from 'astro/config';

import astroLlmsTxt from '@4hse/astro-llms-txt';
import react from '@astrojs/react';
import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  site: 'https://myglu.health',
  integrations: [
    react(),
    astroLlmsTxt({
      title: 'Glu',
      description:
        'Glu is a GLP-1 tracking app for reminders, dose history, meals, progress, and daily habits.',
      details:
        'Use these pages for product overview, support, privacy, terms, account deletion, and company information.',
      optionalLinks: [
        {
          label: 'Home',
          url: 'https://myglu.health/',
          description: 'Main landing page for the app',
        },
        {
          label: 'About',
          url: 'https://myglu.health/about',
          description: 'Company and product overview',
        },
        {
          label: 'Support',
          url: 'https://myglu.health/support',
          description: 'Support and contact page',
        },
        {
          label: 'Privacy Policy',
          url: 'https://myglu.health/privacy',
          description: 'Privacy and data handling policy',
        },
        {
          label: 'Terms of Service',
          url: 'https://myglu.health/terms',
          description: 'Terms, subscriptions, and legal terms',
        },
        {
          label: 'Delete Account',
          url: 'https://myglu.health/delete-account',
          description: 'Account deletion instructions',
        },
        {
          label: 'GLP-1 Guides',
          url: 'https://myglu.health/guides',
          description: 'Practical, evidence-based guides for life on GLP-1 medications',
        },
        {
          label: 'GLP-1 Glossary',
          url: 'https://myglu.health/glossary',
          description: 'Plain-language definitions of GLP-1 treatment terms',
        },
        {
          label: 'GLP-1 Injection Tracker',
          url: 'https://myglu.health/glp-1-injection-tracker',
          description: 'How Glu tracks doses, injection sites, weight, and side effects',
        },
      ],
      docSet: [
        {
          title: 'Glu site index',
          description: 'Compact index of the key public pages on myglu.health.',
          url: '/llms-small.txt',
          include: ['about/', 'delete-account/', 'guides/**', 'glossary/**', 'glp-1-injection-tracker/', 'printable-glp-1-tracker/', 'privacy/', 'support/', 'terms/'],
          onlyStructure: true,
          promote: ['about/'],
        },
        {
          title: 'Glu full site content',
          description: 'Full content for the key public pages on myglu.health.',
          url: '/llms-full.txt',
          include: ['about/', 'delete-account/', 'guides/**', 'glossary/**', 'glp-1-injection-tracker/', 'printable-glp-1-tracker/', 'privacy/', 'support/', 'terms/'],
          promote: ['about/'],
        },
      ],
    }),
  ],

  vite: {
    plugins: [tailwindcss()]
  }
});
