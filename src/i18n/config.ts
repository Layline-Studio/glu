export const defaultLocale = 'en-US';

export const locales = ['en-US', 'pt-BR', 'es-ES', 'zh-CN', 'fr-FR', 'it-IT'] as const;

export type Locale = (typeof locales)[number];

export const localizedLocales = locales.filter(
  (locale) => locale !== defaultLocale,
) as Locale[];

export const localeLabels: Record<Locale, string> = {
  'en-US': 'English',
  'pt-BR': 'Português (Brasil)',
  'es-ES': 'Español',
  'zh-CN': '中文',
  'fr-FR': 'Français',
  'it-IT': 'Italiano',
};

export function getLocalePath(locale: Locale) {
  return locale === defaultLocale ? '/' : `/${locale}/`;
}
