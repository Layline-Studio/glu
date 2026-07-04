import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class LogNoteIndicator extends StatelessWidget {
  const LogNoteIndicator({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Tooltip(
      message: l10n.logNoteIndicatorHasNote,
      child: Semantics(
        label: l10n.logNoteIndicatorHasNote,
        child: Icon(
          Icons.edit_note_rounded,
          size: 16,
          color: color,
        ),
      ),
    );
  }
}
