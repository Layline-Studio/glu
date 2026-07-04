import { defaultLocale, locales, type Locale } from '../i18n/config';
import { enUS } from '../i18n/en-US';
import { ptBR } from '../i18n/pt-BR';
import { esES } from '../i18n/es-ES';
import { zhCN } from '../i18n/zh-CN';
import { frFR } from '../i18n/fr-FR';
import { itIT } from '../i18n/it-IT';

const dictionaries = {
  'en-US': enUS,
  'pt-BR': ptBR,
  'es-ES': esES,
  'zh-CN': zhCN,
  'fr-FR': frFR,
  'it-IT': itIT,
} as const;

export function isLocale(value: string): value is Locale {
  return locales.includes(value as Locale);
}

export function getDictionary(locale: Locale) {
  return dictionaries[locale];
}

export function getLocaleOrDefault(value?: string): Locale {
  return value && isLocale(value) ? value : defaultLocale;
}
