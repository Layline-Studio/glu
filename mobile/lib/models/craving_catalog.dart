import 'package:flutter/widgets.dart';

import '../l10n/l10n.dart';

class CravingTypeOption {
  const CravingTypeOption({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class CravingCatalog {
  static const general = 'general';
  static const sweetSugary = 'sweet_sugary';
  static const saltySavory = 'salty_savory';

  static const values = <String>{
    general,
    sweetSugary,
    saltySavory,
  };

  static List<CravingTypeOption> typeOptions(BuildContext context) => [
        CravingTypeOption(
          value: general,
          label: context.l10n.cravingsTypeGeneral,
        ),
        CravingTypeOption(
          value: sweetSugary,
          label: context.l10n.cravingsTypeSweet,
        ),
        CravingTypeOption(
          value: saltySavory,
          label: context.l10n.cravingsTypeSalty,
        ),
      ];

  static String typeLabelFor(BuildContext context, String value) {
    return switch (value) {
      general => context.l10n.cravingsTypeGeneral,
      sweetSugary => context.l10n.cravingsTypeSweet,
      saltySavory => context.l10n.cravingsTypeSalty,
      _ => value,
    };
  }
}
