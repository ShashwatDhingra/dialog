import 'package:flutter/material.dart';

class NoInternetLayout2 extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subtitle;
  final String buttonText;
  final double dialogHeight;
  final double imageHeight;
  final Color buttonColor;
  final bool isDark;
  final VoidCallback onPressed;

  const NoInternetLayout2({
    super.key,
    this.assetPath = 'assets/no_internet/no_internet_1.png',
    this.title = "Whoops",
    this.subtitle =
        "It looks like you’re offline.\nPlease check your internet connection and try again.",
    this.buttonText = "Retry",
    this.dialogHeight = 400,
    this.imageHeight = 120,
    this.buttonColor = const Color(0xFFE57373),
    this.isDark = false,
    this.onPressed = _defaultOnPressed,
  });

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    // Dark / light mode overrides
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(assetPath, height: imageHeight, fit: BoxFit.contain),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: subtitleColor, height: 1.4),
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
                    fontWeight: FontWeight.w600,
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
