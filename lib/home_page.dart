import 'package:dialog/grid_background/grid_background.dart';
import 'package:dialog/no_internet_dialogs/no_internet_dialog.dart';
import 'package:dialog/rating_dialogs/rating_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"title": "Rating Dialogs", "icon": Icons.star_rate_outlined},
      {"title": "Update Dialogs", "icon": Icons.system_update_outlined},
      {"title": "No Internet", "icon": Icons.wifi_off_outlined},
      {"title": "No Data", "icon": Icons.inbox_outlined},
      {"title": "Pin Dialogs", "icon": Icons.lock_outline},
      {"title": "Alert Dialogs", "icon": Icons.warning_amber_outlined},
      {"title": "Success & Error", "icon": Icons.check_circle_outline},
      {"title": "Loading & Progress", "icon": Icons.hourglass_bottom_outlined},
      {"title": "Form Dialogs", "icon": Icons.edit_note_outlined},
      {"title": "Choice Dialogs", "icon": Icons.list_alt_outlined},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      drawer: _buildDrawer(categories, context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        title: const Text(
          'Dialog Kit',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white70),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: "Dialog Kit",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.chat_bubble_outline),
                children: const [
                  Text(
                    "A showcase of beautiful dialog designs.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GridBackground(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return GestureDetector(
                  onTap: () {
                    if (cat['title'] == "No Internet") {
                      NoInternetDialog.showNoInternetDialog(context);
                    }
                    if (cat['title'] == 'Rating Dialogs') {
                      RatingDialog.showRatingDialog(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          cat["icon"] as IconData,
                          size: 38,
                          color: Colors.grey.shade100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          cat["title"] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(
    List<Map<String, Object>> categories,
    BuildContext context,
  ) {
    return Row(
      children: [
        Drawer(
          backgroundColor: const Color(0xFF1E1E1E),
          child: SafeArea(
            child: Column(
              children: [
                const DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/images/dialog_kit_logo.png',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return ListTile(
                        leading: Icon(
                          cat["icon"] as IconData,
                          color: Colors.grey.shade100,
                        ),
                        title: Text(
                          cat["title"] as String,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          size: 12,
                          color: Colors.white54,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 7),
        Container(
          width: 5,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
