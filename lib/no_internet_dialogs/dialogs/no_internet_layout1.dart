import 'package:flutter/material.dart';

class NoInternetLayout1 extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final double dialogHeight;
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;
  final Gradient backgroundGradient;
  final bool isDark;
  final VoidCallback onPressed;

  const NoInternetLayout1({
    super.key,
    this.title = "No internet connection",
    this.subtitle = "Please check your internet connection and try again",
    this.buttonText = "Retry",
    this.dialogHeight = 400,
    this.iconSize = 24,
    this.icon = Icons.wifi_off,
    this.iconColor = const Color(0xFFE57373),
    this.buttonColor = const Color(0xFFE57373),
    this.backgroundGradient = const LinearGradient(
      colors: [Color(0xFFFDE2E4), Color(0xFFFAD2CF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.isDark = false,
    this.onPressed = _defaultOnPressed,
  });

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    // Override styles based on isDark
    final bgGradient = isDark
        ? const LinearGradient(
            colors: [Color(0xFF2C2C2C), Color(0xFF1E1E1E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : backgroundGradient;

    final iconBgColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF1F1F1);

    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Dialog(
      backgroundColor: Colors.transparent, // to let gradient show
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: bgGradient,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(47),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: subtitleColor,
              ),
            ),
            const SizedBox(height: 24),

            // Retry button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
