import 'package:flutter/material.dart';

class NoInternetLayout3 extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subtitle;
  final String buttonText;
  final double dialogHeight;
  final double imageHeight;
  final Color buttonColor;
  final bool isDark;
  final VoidCallback onPressed;

  const NoInternetLayout3({
    super.key,
    this.assetPath = 'assets/no_internet/no_internet_2.png',
    this.title = 'Lost Connection',
    this.subtitle =
        'Whoops... no internet connection found. Check your connection.',
    this.buttonText = 'Try Again',
    this.dialogHeight = 400,
    this.imageHeight = 110,
    this.buttonColor = Colors.blue,
    this.isDark = false,
    this.onPressed = _defaultOnPressed,
  });

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    // Handle dark/light styles
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
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
                fontSize: 20,
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

            // Button
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
