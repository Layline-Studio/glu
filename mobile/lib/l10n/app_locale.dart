import 'dart:ui';

const supportedAppLocales = <Locale>[
  Locale('en'),
  Locale('pt'),
  Locale('fi'),
  Locale('hi'),
  Locale('nl'),
  Locale('es'),
  Locale('fr'),
  Locale('da'),
  Locale('de'),
  Locale('it'),
  Locale('ru'),
  Locale('sv'),
  Locale('ar'),
  Locale('zh'),
  Locale('no'),
];

const _supportedLocaleCodes = {
  'en',
  'pt',
  'fi',
  'hi',
  'nl',
  'es',
  'fr',
  'da',
  'de',
  'it',
  'ru',
  'sv',
  'ar',
  'zh',
  'no',
};

const _languageNames = {
  'en': 'English',
  'pt': 'Português',
  'fi': 'Suomi',
  'hi': 'हिन्दी',
  'nl': 'Nederlands',
  'es': 'Español',
  'fr': 'Français',
  'da': 'Dansk',
  'de': 'Deutsch',
  'it': 'Italiano',
  'ru': 'Русский',
  'sv': 'Svenska',
  'ar': 'العربية',
  'zh': '中文',
  'no': 'Norsk',
};

String? normalizeLocaleCode(String? raw) {
  final value = raw?.trim();
  if (value == null || value.isEmpty) {
    return null;
  }

  final languageCode = value.replaceAll('_', '-').split('-').first.toLowerCase();
  if (_supportedLocaleCodes.contains(languageCode)) {
    return languageCode;
  }
  return null;
}

Locale resolveAppLocale(Locale deviceLocale, String? storedLocaleCode) {
  final storedCode = normalizeLocaleCode(storedLocaleCode);
  if (storedCode != null) {
    return Locale(storedCode);
  }

  final deviceCode = deviceLocale.languageCode.toLowerCase();
  if (_supportedLocaleCodes.contains(deviceCode)) {
    return Locale(deviceCode);
  }

  return const Locale('en');
}

String languageNameForCode(String code) {
  return _languageNames[code.toLowerCase()] ?? code.toUpperCase();
}

String languageNameForLocale(Locale locale) {
  return languageNameForCode(locale.languageCode);
}
