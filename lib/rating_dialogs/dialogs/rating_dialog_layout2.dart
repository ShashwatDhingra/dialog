import 'package:flutter/material.dart';

class RatingDialogLayout2 extends StatefulWidget {
  final String title;
  final String description;
  final String submitText;
  final bool isDark;
  final Color buttonTextColor;
  final List<Color> colors;
  final Function(int rating, String comment) onSubmit;

  const RatingDialogLayout2({
    super.key,
    this.title = "How are you feeling?",
    this.description =
        "Your input is valuable in helping us better understand your needs and tailor our service accordingly.",
    this.submitText = "Submit Now",
    this.isDark = false,
    this.buttonTextColor = Colors.white,
    this.colors = const [Colors.blue, Colors.green],
    required this.onSubmit,
  });

  @override
  State<RatingDialogLayout2> createState() => _RatingDialogLayout2State();
}

class _RatingDialogLayout2State extends State<RatingDialogLayout2> {
  int selectedMood = 2; // Default (Medium)
  final TextEditingController commentController = TextEditingController();

  final List<IconData> moodIcons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  final List<String> moodLabels = [
    "Very Bad",
    "Bad",
    "Medium",
    "Good",
    "Excellent",
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final titleColor = widget.isDark ? Colors.white : Colors.black87;
    final subtitleColor = widget.isDark ? Colors.white70 : Colors.black54;
    final dividerColor = widget.isDark ? Colors.white12 : Colors.black12;
    final borderColor = widget.isDark ? Colors.white24 : Colors.grey.shade400;
    final moodHighlightColor = widget.isDark
        ? Colors.greenAccent.withOpacity(0.3)
        : Colors.green.withOpacity(0.2);

    return Dialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Feedback Row
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: widget.isDark
                      ? Colors.white24
                      : Colors.black,
                  child: Icon(
                    Icons.message_outlined,
                    color: widget.isDark ? Colors.white : Colors.white,
                    size: 10,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "Feedback",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: subtitleColor, size: 17),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            Divider(height: 20, color: dividerColor),

            // 🔹 Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Description
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: subtitleColor, height: 1.4),
            ),
            const SizedBox(height: 20),

            // 🔹 Emoji Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(moodIcons.length, (index) {
                final isSelected = selectedMood == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? moodHighlightColor
                          : Colors.transparent,
                    ),
                    child: Icon(
                      moodIcons[index],
                      size: isSelected ? 50 : 40,
                      color: isSelected ? Colors.greenAccent : subtitleColor,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),

            // 🔹 Mood label
            Text(
              moodLabels[selectedMood],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Comment Box
            TextField(
              controller: commentController,
              maxLines: 3,
              cursorHeight: 14,
              decoration: InputDecoration(
                hintText: "Add a Comment...",
                hintStyle: TextStyle(color: subtitleColor, fontSize: 12),
                filled: true,
                fillColor: widget.isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: borderColor, width: 0.3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: borderColor, width: 0.3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: borderColor, width: 0.5),
                ),
              ),
              style: TextStyle(color: titleColor),
            ),
            const SizedBox(height: 20),

            // 🔹 Submit button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  widget.onSubmit(selectedMood, commentController.text.trim());
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      colors: widget.colors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.submitText,
                      style: TextStyle(
                        color: widget.buttonTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
