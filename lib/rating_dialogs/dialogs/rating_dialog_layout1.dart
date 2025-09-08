import 'package:flutter/material.dart';

class RatingDialogLayout1 extends StatefulWidget {
  final String title;
  final String description;
  final String laterText;
  final String rateNowText;
  final int maxRating;
  final Color headerColor;
  final Color starColor;
  final Color buttonColor;
  final bool isDark;
  final int initialRating;
  final void Function(int rating) onRateNow;
  final VoidCallback onLater;

  const RatingDialogLayout1({
    super.key,
    this.title = "Rate Our App",
    this.description =
        "If you enjoy using our app, would you mind rating us on the App Store?",
    this.laterText = "Maybe Later",
    this.rateNowText = "Rate Now",
    this.maxRating = 5,
    this.headerColor = Colors.amber,
    this.starColor = Colors.amber,
    this.buttonColor = Colors.blue,
    this.isDark = false,
    this.initialRating = 3,
    required this.onRateNow,
    required this.onLater,
  }) : assert(
         initialRating >= 0 && initialRating <= maxRating,
         "initialRating must be between 0 and maxRating",
       );

  @override
  State<RatingDialogLayout1> createState() => _RatingDialogLayout1State();
}

class _RatingDialogLayout1State extends State<RatingDialogLayout1> {
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
      insetPadding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background split into two
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 110, color: widget.headerColor),
                Container(
                  height: 310,
                  color: bgColor,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
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

                      // Description
                      Text(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: subtitleColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Star Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.maxRating, (index) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                selectedRating = index + 1;
                              });
                            },
                            icon: Icon(
                              index < selectedRating
                                  ? Icons.star
                                  : Icons.star_border_rounded,
                              size: 32,
                              color: widget.starColor,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onLater,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: subtitleColor.withOpacity(0.4),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                widget.laterText,
                                style: TextStyle(
                                  color: subtitleColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => widget.onRateNow(selectedRating),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                widget.rateNowText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Circle Icon overlapping
            Positioned(
              top: 65,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: widget.headerColor,
                  child: Icon(
                    Icons.sentiment_satisfied_alt,
                    size: 60,
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
