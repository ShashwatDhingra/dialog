import 'package:dialog/rating_dialogs/dialogs/rating_dialog_layout1.dart';
import 'package:dialog/rating_dialogs/dialogs/rating_dialog_layout2.dart';
import 'package:dialog/rating_dialogs/dialogs/rating_dialog_layout3.dart';
import 'package:dialog/rating_dialogs/dialogs/rating_dialog_layout4.dart';
import 'package:dialog/rating_dialogs/dialogs/rating_dialog_layout5.dart';
import 'package:dialog/rating_dialogs/dialogs/sliding_rating_dialog.dart';
import 'package:flutter/material.dart';

class RatingDialog {
  static showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SlideRatingDialog(onRatingChanged: (r) {}, buttonOnTap: (r) {}),
    );
    showDialog(
      context: context,
      builder: (context) => RatingDialogLayout1(
        onRateNow: (rating) {},
        onLater: () {},
        initialRating: 3,
      ),
    );
    showDialog(
      context: context,
      builder: (context) =>
          RatingDialogLayout2(onSubmit: (rating, comment) {}, isDark: true),
    );
    showDialog(
      context: context,
      builder: (context) =>
          RatingDialogLayout3(onSubmit: (rating) {}, isDark: true),
    );
    showDialog(
      context: context,
      builder: (context) => RatingDialogLayout4(
        initialRating: 4,
        onSubmit: (rating, comment) {
          print(rating);
          print(comment);
        },
        onCancel: () {
          print('here');
        },
      ),
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // makes corners visible
      builder: (context) => const RatingDialogLayout5(),
    );
  }
}
