import 'package:flutter/material.dart';

class RatingDialogLayout4 extends StatefulWidget {
  final String title;
  final String description;
  final String cancelText;
  final String submitText;
  final List<Color> gradientColors;
  final double borderRadius;
  final int initialRating;
  final Function(int rating, String comment) onSubmit;
  final VoidCallback onCancel;

  const RatingDialogLayout4({
    super.key,
    this.title = "App rating",
    this.description = "Please write your feedback.",
    this.cancelText = "CANCEL",
    this.submitText = "SEND REVIEW",
    this.gradientColors = const [
      Color.fromARGB(255, 54, 164, 255),
      Color.fromARGB(255, 0, 0, 0),
    ],
    this.initialRating = 3,
    this.borderRadius = 16,
    required this.onSubmit,
    required this.onCancel,
  }) : assert(
         initialRating >= 0 && initialRating <= 5,
         "initialRating must be between 0 and maxRating",
       );

  @override
  State<RatingDialogLayout4> createState() => _RatingDialogLayout4State();
}

class _RatingDialogLayout4State extends State<RatingDialogLayout4> {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    selectedRating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Title
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // 🔹 Description
            Text(
              widget.description,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // 🔹 Stars row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
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
            const SizedBox(height: 12),

            // 🔹 Feedback text field
            TextField(
              controller: commentController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Write your feedback...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withAlpha(27),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 0.3,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 0.3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                TextButton(
                  onPressed: widget.onCancel,
                  child: Text(
                    widget.cancelText,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),

                // Submit button
                TextButton(
                  onPressed: () {
                    widget.onSubmit(
                      selectedRating,
                      commentController.text.trim(),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.submitText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
