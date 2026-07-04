import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _AppLocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => WidgetsBinding.instance.platformDispatcher.locale;

  void setLocale(Locale locale) {
    state = locale;
  }
}

final appLocaleControllerProvider =
    NotifierProvider<_AppLocaleNotifier, Locale>(_AppLocaleNotifier.new);

