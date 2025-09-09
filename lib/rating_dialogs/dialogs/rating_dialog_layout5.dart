import 'package:flutter/material.dart';

class RatingDialogLayout5 extends StatefulWidget {
  const RatingDialogLayout5({super.key});

  @override
  State<RatingDialogLayout5> createState() => _RatingDialogLayout5State();
}

class _RatingDialogLayout5State extends State<RatingDialogLayout5> {
  int rating = 0;
  String? selectedReason;
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // handle keyboard
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Step 1 → User has not rated yet
            if (rating == 0) ...[
              Image.asset(
                "assets/placeholder.png", // replace with your dummy asset
                height: 100,
              ),
              const SizedBox(height: 12),
              const Text(
                "Rate your experience with us!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      size: 32,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  );
                }),
              ),
            ],

            // 🔹 Step 2 → Low rating flow
            if (rating > 0 && rating <= 3) ...[
              const Text(
                "Okay",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Text(
                "Where can we improve?",
                style: TextStyle(fontSize: 14),
              ),
              Wrap(
                spacing: 8,
                children:
                    [
                      "App UI",
                      "Slow Speed",
                      "Customer Care",
                      "Bugs",
                      "Other",
                    ].map((reason) {
                      return ChoiceChip(
                        label: Text(reason),
                        selected: selectedReason == reason,
                        onSelected: (selected) {
                          setState(() {
                            selectedReason = selected ? reason : null;
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: feedbackController,
                decoration: const InputDecoration(
                  hintText: "Any other suggestions?",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // handle submit
                },
                child: const Text("Submit"),
              ),
            ],

            // 🔹 Step 3 → High rating flow
            if (rating >= 4) ...[
              const Text(
                "Excellent!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Text(
                "Thanks for loving us!\nSpread the word by rating us on PlayStore",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // open store link
                },
                child: const Text("Rate Us"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
