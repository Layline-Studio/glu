import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';

class InlineNotesTrigger extends StatelessWidget {
  const InlineNotesTrigger({
    super.key,
    required this.value,
    required this.isExpanded,
    required this.onTap,
    this.maxWidth = 220,
  });

  final String value;
  final bool isExpanded;
  final VoidCallback onTap;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final label = isExpanded
        ? l10n.noteTriggerCancelNote
        : (value.isEmpty ? l10n.noteTriggerAddNote : value);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: value.isEmpty || isExpanded
                    ? colors.textSecondary.withValues(alpha: 0.75)
                    : colors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedNotesField extends StatelessWidget {
  const ExpandedNotesField({
    super.key,
    required this.controller,
    required this.hintText,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.padding = const EdgeInsets.fromLTRB(14, 10, 14, 10),
    this.borderRadius = 18,
    this.maxLines = 5,
    this.minLines = 3,
  });

  final TextEditingController controller;
  final String hintText;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final int maxLines;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.softSurface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        textCapitalization: TextCapitalization.sentences,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          isCollapsed: true,
          filled: false,
          hintText: hintText,
          hintStyle: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: colors.textSecondary,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
