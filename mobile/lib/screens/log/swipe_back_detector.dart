import 'package:flutter/material.dart';

class SwipeBackDetector extends StatefulWidget {
  const SwipeBackDetector({required this.child, super.key});

  final Widget child;

  @override
  State<SwipeBackDetector> createState() => _SwipeBackDetectorState();
}

class _SwipeBackDetectorState extends State<SwipeBackDetector> {
  static const _edgeWidth = 36.0;
  static const _minVelocity = 350.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: _edgeWidth,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) {
                if ((details.primaryVelocity ?? 0) > _minVelocity) {
                  Navigator.of(context).maybePop();
                }
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: _edgeWidth,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) {
                if ((details.primaryVelocity ?? 0) < -_minVelocity) {
                  Navigator.of(context).maybePop();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
