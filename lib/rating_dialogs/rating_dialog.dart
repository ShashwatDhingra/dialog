import 'package:dialog/rating_dialogs/dialogs/sliding_rating_dialog.dart';
import 'package:flutter/material.dart';

class RatingDialog {
  static showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SlideRatingDialog(onRatingChanged: (r) {}, buttonOnTap: (r) {}),
    );
  }
}
