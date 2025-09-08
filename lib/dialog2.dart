import 'dart:ui';
import 'package:flutter/material.dart';

Future<void> showDialog2(
  BuildContext context, {
  required String title,
  required String description,
  Color backgroundColor = Colors.white,
  double backgroundOpacity = 0.95,
  Color glowColor = Colors.blueAccent,
  double glowSpread = 20,
  Duration animationDuration = const Duration(milliseconds: 600),
  bool repeatGlow = true,
  List<Widget> actions = const [],
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "GlowDialog",
    transitionDuration: animationDuration,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      final curvedValue = Curves.elasticOut.transform(anim1.value);

      return Opacity(
        opacity: anim1.value,
        child: Transform.scale(
          scale: curvedValue,
          child: _PulseGlowDialog(
            title: title,
            description: description,
            backgroundColor: backgroundColor,
            backgroundOpacity: backgroundOpacity,
            glowColor: glowColor,
            glowSpread: glowSpread,
            repeatGlow: repeatGlow,
            actions: actions,
          ),
        ),
      );
    },
  );
}

class _PulseGlowDialog extends StatefulWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final double backgroundOpacity;
  final Color glowColor;
  final double glowSpread;
  final bool repeatGlow;
  final List<Widget> actions;

  const _PulseGlowDialog({
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.backgroundOpacity,
    required this.glowColor,
    required this.glowSpread,
    required this.repeatGlow,
    required this.actions,
  });

  @override
  State<_PulseGlowDialog> createState() => _PulseGlowDialogState();
}

class _PulseGlowDialogState extends State<_PulseGlowDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final glow = widget.repeatGlow ? _controller.value : 1.0;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.backgroundColor.withOpacity(widget.backgroundOpacity),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.glowColor.withOpacity(0.6),
                  blurRadius: widget.glowSpread * glow,
                  spreadRadius: glow * (widget.glowSpread / 2),
                ),
              ],
              border: Border.all(color: widget.glowColor.withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.glowColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: widget.actions,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
