import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../l10n/l10n.dart';
import '../../theme/app_colors.dart';

class FeedbackSheet extends StatefulWidget {
  const FeedbackSheet({super.key, this.name, this.email, this.userId});

  final String? name;
  final String? email;
  final String? userId;

  @override
  State<FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<FeedbackSheet> {
  final _controller = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _sending = true;
      _error = null;
    });

    try {
      final name = widget.name ?? widget.email ?? 'User';
      final response = await http.post(
        Uri.parse('https://formfy.layline.ventures/contact@layline.ventures'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'name': name,
          'email': widget.email ?? '',
          'category': 'feedback',
          'message': message,
          if (widget.userId != null) 'user_id': widget.userId!,
          '_subject': 'Glu Feedback from $name',
        },
      );

      if (!mounted) return;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error = context.l10n.feedbackSheetError);
      }
    } catch (_) {
      if (mounted) setState(() => _error = context.l10n.feedbackSheetError);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 28 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.lineSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.feedbackSheetTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: TextField(
              controller: _controller,
              minLines: 4,
              maxLines: 8,
              maxLength: 10000,
              autofocus: true,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: context.l10n.feedbackSheetHint,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
                counterStyle: TextStyle(color: colors.textSecondary),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _sending ? null : () => Navigator.of(context).pop(),
                child: Text(context.l10n.commonCancel),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _sending || _controller.text.trim().isEmpty
                    ? null
                    : _send,
                child: _sending
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.canvas,
                        ),
                      )
                    : Text(context.l10n.feedbackSheetSend),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
