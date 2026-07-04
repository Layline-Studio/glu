import 'package:flutter/widgets.dart';

import '../l10n/l10n.dart';

class InjectionSiteOption {
  const InjectionSiteOption({
    required this.value,
    required this.label,
    required this.groupLabel,
  });

  final String value;
  final String label;
  final String groupLabel;
}

class InjectionSiteCatalog {
  const InjectionSiteCatalog._();

  static const abdomenUpperLeft = 'abdomen_upper_left';
  static const abdomenUpperRight = 'abdomen_upper_right';
  static const abdomenLowerRight = 'abdomen_lower_right';
  static const abdomenLowerLeft = 'abdomen_lower_left';

  static const thighUpperLeft = 'thigh_upper_left';
  static const thighUpperRight = 'thigh_upper_right';
  static const thighLowerRight = 'thigh_lower_right';
  static const thighLowerLeft = 'thigh_lower_left';

  static const armUpperLeft = 'arm_upper_left';
  static const armUpperRight = 'arm_upper_right';

  static const buttocksUpperLeft = 'buttocks_upper_left';
  static const buttocksUpperRight = 'buttocks_upper_right';

  static List<InjectionSiteOption> _englishOptions() => const [
        InjectionSiteOption(
          value: abdomenUpperLeft,
          label: 'Abdomen, upper left',
          groupLabel: 'Abdomen',
        ),
        InjectionSiteOption(
          value: abdomenUpperRight,
          label: 'Abdomen, upper right',
          groupLabel: 'Abdomen',
        ),
        InjectionSiteOption(
          value: abdomenLowerRight,
          label: 'Abdomen, lower right',
          groupLabel: 'Abdomen',
        ),
        InjectionSiteOption(
          value: abdomenLowerLeft,
          label: 'Abdomen, lower left',
          groupLabel: 'Abdomen',
        ),
        InjectionSiteOption(
          value: thighUpperLeft,
          label: 'Thigh, upper left',
          groupLabel: 'Thigh',
        ),
        InjectionSiteOption(
          value: thighUpperRight,
          label: 'Thigh, upper right',
          groupLabel: 'Thigh',
        ),
        InjectionSiteOption(
          value: thighLowerRight,
          label: 'Thigh, lower right',
          groupLabel: 'Thigh',
        ),
        InjectionSiteOption(
          value: thighLowerLeft,
          label: 'Thigh, lower left',
          groupLabel: 'Thigh',
        ),
        InjectionSiteOption(
          value: armUpperLeft,
          label: 'Upper arm, left',
          groupLabel: 'Upper arm',
        ),
        InjectionSiteOption(
          value: armUpperRight,
          label: 'Upper arm, right',
          groupLabel: 'Upper arm',
        ),
        InjectionSiteOption(
          value: buttocksUpperLeft,
          label: 'Buttocks, upper left',
          groupLabel: 'Buttocks',
        ),
        InjectionSiteOption(
          value: buttocksUpperRight,
          label: 'Buttocks, upper right',
          groupLabel: 'Buttocks',
        ),
      ];

  static List<InjectionSiteOption> options(BuildContext context) => [
        InjectionSiteOption(
          value: abdomenUpperLeft,
          label: context.l10n.injectionSiteAbdomenUpperLeft,
          groupLabel: context.l10n.injectionSiteAbdomen,
        ),
        InjectionSiteOption(
          value: abdomenUpperRight,
          label: context.l10n.injectionSiteAbdomenUpperRight,
          groupLabel: context.l10n.injectionSiteAbdomen,
        ),
        InjectionSiteOption(
          value: abdomenLowerRight,
          label: context.l10n.injectionSiteAbdomenLowerRight,
          groupLabel: context.l10n.injectionSiteAbdomen,
        ),
        InjectionSiteOption(
          value: abdomenLowerLeft,
          label: context.l10n.injectionSiteAbdomenLowerLeft,
          groupLabel: context.l10n.injectionSiteAbdomen,
        ),
        InjectionSiteOption(
          value: thighUpperLeft,
          label: context.l10n.injectionSiteThighUpperLeft,
          groupLabel: context.l10n.injectionSiteThigh,
        ),
        InjectionSiteOption(
          value: thighUpperRight,
          label: context.l10n.injectionSiteThighUpperRight,
          groupLabel: context.l10n.injectionSiteThigh,
        ),
        InjectionSiteOption(
          value: thighLowerRight,
          label: context.l10n.injectionSiteThighLowerRight,
          groupLabel: context.l10n.injectionSiteThigh,
        ),
        InjectionSiteOption(
          value: thighLowerLeft,
          label: context.l10n.injectionSiteThighLowerLeft,
          groupLabel: context.l10n.injectionSiteThigh,
        ),
        InjectionSiteOption(
          value: armUpperLeft,
          label: context.l10n.injectionSiteUpperArmLeft,
          groupLabel: context.l10n.injectionSiteUpperArm,
        ),
        InjectionSiteOption(
          value: armUpperRight,
          label: context.l10n.injectionSiteUpperArmRight,
          groupLabel: context.l10n.injectionSiteUpperArm,
        ),
        InjectionSiteOption(
          value: buttocksUpperLeft,
          label: context.l10n.injectionSiteButtocksUpperLeft,
          groupLabel: context.l10n.injectionSiteButtocks,
        ),
        InjectionSiteOption(
          value: buttocksUpperRight,
          label: context.l10n.injectionSiteButtocksUpperRight,
          groupLabel: context.l10n.injectionSiteButtocks,
        ),
      ];

  static final values = <String>[
    abdomenUpperLeft,
    abdomenUpperRight,
    abdomenLowerRight,
    abdomenLowerLeft,
    thighUpperLeft,
    thighUpperRight,
    thighLowerRight,
    thighLowerLeft,
    armUpperLeft,
    armUpperRight,
    buttocksUpperLeft,
    buttocksUpperRight,
  ];

  static const Map<String, List<String>> _rotationOrderByRegion = {
    'abdomen': [
      abdomenUpperLeft,
      abdomenUpperRight,
      abdomenLowerRight,
      abdomenLowerLeft,
    ],
    'thigh': [
      thighUpperLeft,
      thighUpperRight,
      thighLowerRight,
      thighLowerLeft,
    ],
    'arm': [
      armUpperLeft,
      armUpperRight,
    ],
    'buttocks': [
      buttocksUpperLeft,
      buttocksUpperRight,
    ],
  };

  static String labelFor(dynamic first, [String? second]) {
    final BuildContext? context = first is BuildContext ? first : null;
    final String value = first is BuildContext ? second ?? '' : first as String;
    if (context == null) {
      for (final option in _englishOptions()) {
        if (option.value == value) {
          return option.label;
        }
      }
      return value;
    }
    for (final option in options(context)) {
      if (option.value == value) {
        return option.label;
      }
    }
    return value;
  }

  static List<InjectionSiteOption> optionsForValues(
    dynamic first, [
    List<String>? second,
  ]) {
    final BuildContext? context = first is BuildContext ? first : null;
    final List<String> values = first is BuildContext
        ? (second ?? const <String>[])
        : first as List<String>;
    final valueSet = values.toSet();
    return (context == null ? _englishOptions() : options(context))
        .where((option) => valueSet.contains(option.value))
        .toList();
  }

  static String? nextValueAfter(String? currentValue) {
    if (currentValue == null) {
      return _englishOptions().isEmpty ? null : _englishOptions().first.value;
    }
    final region = _regionForValue(currentValue);
    final regionOrder = region == null ? null : _rotationOrderByRegion[region];
    if (regionOrder == null || regionOrder.isEmpty) {
      return _englishOptions().isEmpty ? null : _englishOptions().first.value;
    }
    final currentIndex = regionOrder.indexOf(currentValue);
    if (currentIndex == -1) {
      return regionOrder.first;
    }
    return regionOrder[(currentIndex + 1) % regionOrder.length];
  }

  static String? _regionForValue(String value) {
    return switch (value) {
      abdomenUpperLeft ||
      abdomenUpperRight ||
      abdomenLowerRight ||
      abdomenLowerLeft => 'abdomen',
      thighUpperLeft || thighUpperRight || thighLowerRight || thighLowerLeft =>
        'thigh',
      armUpperLeft || armUpperRight => 'arm',
      buttocksUpperLeft || buttocksUpperRight => 'buttocks',
      _ => null,
    };
  }
}
