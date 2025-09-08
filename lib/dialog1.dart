import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable custom dialog with animated border and configurable options.
Future<void> showDialog1({
  required BuildContext context,
  required String title,
  String? description,
  List<DialogAction>? actions,
  bool repeatAnimation = true,
  Duration animationDuration = const Duration(seconds: 2),
  Color borderColor = Colors.white,
  double borderWidth = 2.0,
  double backgroundTransparency = 0.15,
  Color backgroundColor = Colors.black,
  double borderRadius = 24,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "CustomAnimatedDialog",
    barrierColor: Colors.black54, // dim behind
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      final curvedValue = Curves.easeOut.transform(anim1.value);
      return Opacity(
        opacity: anim1.value,
        child: Transform.scale(
          scale: curvedValue,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: _RevolvingBorderContainer(
                  repeat: repeatAnimation,
                  duration: animationDuration,
                  borderColor: borderColor,
                  borderWidth: borderWidth,
                  borderRadius: borderRadius,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(
                        backgroundTransparency,
                      ),
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: borderColor.withOpacity(0.3),
                        width: borderWidth,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: borderColor,
                          ),
                        ),
                        if (description != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: borderColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                        if (actions != null && actions.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: actions
                                .map(
                                  (a) => Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            a.color ??
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        a.onPressed?.call();
                                      },
                                      child: Text(
                                        a.label,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Configurable dialog action button
class DialogAction {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  DialogAction({required this.label, this.onPressed, this.color});
}

/// Revolving border painter container
class _RevolvingBorderContainer extends StatefulWidget {
  final Widget child;
  final bool repeat;
  final Duration duration;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const _RevolvingBorderContainer({
    required this.child,
    this.repeat = true,
    required this.duration,
    required this.borderColor,
    this.borderWidth = 2,
    this.borderRadius = 24,
  });

  @override
  State<_RevolvingBorderContainer> createState() =>
      _RevolvingBorderContainerState();
}

class _RevolvingBorderContainerState extends State<_RevolvingBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.repeat) {
      _controller.repeat();
    } else {
      _controller.forward();
    }

    _opacityAnim = Tween(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _RevolvingBorderPainter(
            _controller.value,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            borderRadius: widget.borderRadius,
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Painter for revolving border
class _RevolvingBorderPainter extends CustomPainter {
  final double progress;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  _RevolvingBorderPainter(
    this.progress, {
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLength = metrics.length;

    final drawLength = totalLength * 0.25;
    double start = totalLength * progress;
    double end = start + drawLength;

    if (end <= totalLength) {
      canvas.drawPath(metrics.extractPath(start, end), paint);
    } else {
      canvas.drawPath(metrics.extractPath(start, totalLength), paint);
      canvas.drawPath(metrics.extractPath(0, end - totalLength), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RevolvingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth;
  }
}
