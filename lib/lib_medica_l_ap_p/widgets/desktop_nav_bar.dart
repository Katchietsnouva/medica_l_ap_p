// lib/lib_medica_l_ap_p/widgets/desktop_nav_bar.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/data/models/navigation_item.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/data/navigation_data.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/models/royal_project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/settings_dialog.dart';

// import '../../data/navigation_data.dart';
// lib/lib_Royal_app/models/navigation_item.dart
// import '../../models/Royal_project_model.dart';
// import '../../widgets/settings_dialog.dart';

class DesktopNavBar extends StatelessWidget {
  final VoidCallback onScrollToRegister;
  // final VoidCallback onLogout;
  // final RoyalPersonalDetailsType currentUser;

  const DesktopNavBar({
    super.key,
    required this.onScrollToRegister,
    // required this.onLogout,
    // required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? "";
    // final currentRoute = GoRouterState.of(context).uri.toString();

    final desktopNavItems = navigationItems
        .where((item) => !item.onlyMobile && !item.isMisc && item.showInProject)
        .toList();
    final miscNavItems = navigationItems
        .where((item) => item.isMisc && item.showInProject)
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left (optional logo or empty space)
        const SizedBox(width: 20),

        // Center - nav items
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...desktopNavItems.map((item) {
                final isActive = currentRoute == item.url;

                return _navButton(
                  context,
                  item.title,
                  () {
                    if (item.url == "/user-dashboard") {
                      onScrollToRegister();
                    } else {
                      Navigator.pushNamed(context, item.url);
                      // }
                      // replaces current route (like pushReplacement)
                      // context.go(item.url);
                      // or
                      //// pushes on top of current route
                      // context.push(item.url);
                    }
                  },
                  isActive: isActive,
                );
              }),
              PopupMenuButton<String>(
                tooltip: "More",
                onSelected: (url) {
                  final selectedItem = navigationItems.firstWhere(
                    (item) => item.url == url,
                    // orElse: () => NavigationItem(id: "", title: "", url: ""),
                  );
                  if (selectedItem.isLogoutTrigger) {
                    // onLogout();
                  } else {
                    Navigator.pushNamed(context, url);
                    // replaces current route (like pushReplacement)
                    // context.go(url);
                    // or
                    //// pushes on top of current route
                    // context.push(url);
                  }
                },
                itemBuilder: (BuildContext context) {
                  print(
                      "Misc items in menu: ${miscNavItems.map((e) => e.title).toList()}");
                  return miscNavItems.isEmpty
                      ? [
                          const PopupMenuItem<String>(
                            value: "",
                            enabled: false,
                            child: Text("No items available"),
                          ),
                        ]
                      : miscNavItems.map((item) {
                          final isActive = currentRoute == item.url;
                          return PopupMenuItem<String>(
                            value: item.url,
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isActive ? Colors.blue : null,
                              ),
                            ),
                          );
                        }).toList();
                },
                child: _navButton(
                    context, "More", null), // Pass null for onPressed
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              tooltip: 'Display Settings',
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const SettingsDialog(),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue[300],
                  // backgroundImage: currentUser.profilePictureUrl != null &&
                  //         currentUser.profilePictureUrl!.isNotEmpty
                  //     ? NetworkImage(currentUser.profilePictureUrl!)
                  //     : null,
                  // child: (currentUser.profilePictureUrl == null ||
                  //         currentUser.profilePictureUrl!.isEmpty)
                  //     ? Text(
                  //         currentUser.fullName.isNotEmpty
                  //             ? currentUser.fullName[0].toUpperCase()
                  //             : 'U',
                  //         style: const TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )
                  //     : null,
                ),
                const SizedBox(width: 8),
                // Text(
                //   currentUser.fullName,
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Logout',
              icon: const Icon(Icons.logout),
              onPressed: () {},
              // onPressed: onLogout,
            ),
          ],
        ),
      ],
    );
  }

  Widget _navButton(
    BuildContext context,
    String text,
    VoidCallback? onPressed, {
    bool isActive = false,
  }) {
    final baseColor =
        isActive ? Colors.blue : Theme.of(context).textTheme.bodyLarge?.color;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        children: [
          // Text(text),
          Text(
            text,
            style: TextStyle(
              color: baseColor,

              fontWeight: FontWeight.w600, // Optional: make text bolder
            ),
          ),
          if (text == "More") const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }
}
