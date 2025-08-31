// components/footer_header/mobile_nav_panel.dart
import 'package:broka/lib_medica_l_ap_p/data/navigation_data.dart';
import 'package:broka/lib_medica_l_ap_p/models/royal_project_model.dart';
import 'package:flutter/material.dart';
import 'package:broka/lib_medica_l_ap_p/widgets/settings_dialog.dart';

class MobileNavPanel extends StatelessWidget {
  // final RoyalPersonalDetailsType currentUser;
  // final VoidCallback onLogout;

  const MobileNavPanel({
    super.key,
    // required this.currentUser,
    // required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? "";

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(context),
            ...navigationItems
                .where((item) => item.showInProject)
                // .map((item) => ListTile(
                //       title: Text(item.title,
                //           textAlign: TextAlign.center,
                //           style: const TextStyle(
                //               fontSize: 18, fontWeight: FontWeight.bold)),
                //       onTap: () {
                //         Navigator.pop(context); // Close the drawer
                //         // Navigator.pushNamed(context, item.url);
                //         if (item.isLogoutTrigger) {
                //           onLogout();
                //         } else {
                //           Navigator.pushNamed(context, item.url);
                //         }
                //       },
                //     )),
                .map((item) {
              final isActive = currentRoute == item.url;

              return ListTile(
                title: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.blue : null, // Blue if active
                  ),
                ),
                tileColor: isActive
                    ? Colors.blue.withOpacity(0.1)
                    : null, // Light blue background
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  if (item.isLogoutTrigger) {
                    // onLogout();
                  } else {
                    Navigator.pushNamed(context, item.url);
                  }
                },
              );
            }).toList(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => const SettingsDialog());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              // onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            // In a real app, you'd use an Image.network with the user's profile picture URL
            // child: Text(
            //   currentUser.fullName.isNotEmpty ? currentUser.fullName[0] : 'U',
            //   style: const TextStyle(fontSize: 40, color: Colors.white),
            // ),
          ),
          const SizedBox(height: 16),
          // Text(
          //   currentUser.fullName,
          //   style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   currentUser.email,
          //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          // ),
        ],
      ),
    );
  }
}
