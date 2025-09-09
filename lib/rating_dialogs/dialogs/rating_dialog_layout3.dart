import 'package:flutter/material.dart';

class RatingDialogLayout3 extends StatefulWidget {
  final String title;
  final String description;
  final String submitText;
  final String? image;
  final double imageSize;
  final bool isDark;
  final int initialRating;
  final Function(int rating) onSubmit;

  const RatingDialogLayout3({
    super.key,
    this.title = "The Rating Dialog",
    this.description =
        "Tap a star to set your rating. Add more description here if you want.",
    this.submitText = "SUBMIT",
    this.image,
    this.imageSize = 60,
    this.initialRating = 3,
    this.isDark = false,
    required this.onSubmit,
  }) : assert(
         initialRating >= 0 && initialRating <= 5,
         "initialRating must be between 0 and maxRating",
       );

  @override
  State<RatingDialogLayout3> createState() => _RatingDialogLayout3State();
}

class _RatingDialogLayout3State extends State<RatingDialogLayout3> {
  int selectedRating = 0;

  @override
  void initState() {
    selectedRating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final titleColor = widget.isDark ? Colors.white : Colors.black87;
    final subtitleColor = widget.isDark ? Colors.white70 : Colors.black54;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Image (default app icon if not provided)
            Image.asset(
              widget.image ?? 'assets/images/dialog_kit_logo2.png',
              width: widget.imageSize,
              height: widget.imageSize,
            ),
            const SizedBox(height: 16),

            // 🔹 Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // 🔹 Description
            Text(
              widget.description,
              style: TextStyle(fontSize: 14, color: subtitleColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 🔹 Stars row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.blue,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            // 🔹 Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  if (selectedRating > 0) {
                    widget.onSubmit(selectedRating);
                  }
                },
                child: Text(
                  widget.submitText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.black : Colors.white,
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
