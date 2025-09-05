// components/footer_header/desktop_nav_bar.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/ui/beno_ui_components.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/models/navigation_item.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/widgets/hoverable_menu_button.dart';
import 'package:flutter/material.dart';
import '../../data/navigation_data.dart';
import '../../models/beno_project_model.dart';
import '../../widgets/settings_dialog.dart';

class DesktopNavBar extends StatelessWidget {
  final VoidCallback onScrollToRegister;
  final VoidCallback onLogout;
  // final BenoPersonalDetailsType currentUser;
  final SectionA currentUser;

  const DesktopNavBar({
    super.key,
    required this.onScrollToRegister,
    required this.onLogout,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? "";

    final desktopNavItems = navigationItems
        .where((item) => !item.onlyMobile && !item.isMisc && item.showInProject)
        .toList();
    final miscNavItems = navigationItems
        .where((item) => item.isMisc && item.showInProject)
        .toList();

    // return Row(
    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     ...desktopNavItems.map((item) => _navButton(context, item.title, () {
    //           if (item.url == "/user-dashboard") {
    //             onScrollToRegister();
    //           } else {
    //             Navigator.pushNamed(context, item.url);
    //           }
    //         })),
    //     PopupMenuButton<String>(
    //       tooltip: "More",
    //       onSelected: (url) => Navigator.pushNamed(context, url),
    //       itemBuilder: (BuildContext context) {
    //         return miscNavItems.map((item) {
    //           return PopupMenuItem<String>(
    //             value: item.url,
    //             child: Text(item.title),
    //           );
    //         }).toList();
    //       },
    //       child: _navButton(context, "More", () {}),
    //     ),
    //     const SizedBox(width: 24),
    //     IconButton(
    //       tooltip: 'Display Settings',
    //       icon: const Icon(Icons.settings_outlined),
    //       onPressed: () => showDialog(
    //         context: context,
    //         builder: (context) => const SettingsDialog(),
    //       ),
    //     ),
    //     const SizedBox(width: 8),
    //     // Stack(alignment: Alignment.center, children: [
    //     //   CircleAvatar(
    //     //     backgroundColor: primaryColor,
    //     //     // child: Text(
    //     //     //     currentUser.fullName.isNotEmpty ? currentUser.fullName[0] : 'U',
    //     //     //     style: const TextStyle(color: Colors.white)),
    //     //     backgroundImage: currentUser.profilePictureUrl != null &&
    //     //             currentUser.profilePictureUrl!.isNotEmpty
    //     //         ? NetworkImage(currentUser.profilePictureUrl!)
    //     //         : null,
    //     //   ),
    //     //   if (currentUser.profilePictureUrl == null ||
    //     //       currentUser.profilePictureUrl!.isEmpty)
    //     //     Text(
    //     //       currentUser.fullName.isNotEmpty
    //     //           ? currentUser.fullName.toUpperCase()
    //     //           : "currentUser.fullName[0].toUpperCase()",
    //     //       // : 'U',
    //     //       style: const TextStyle(
    //     //         fontSize: 18,
    //     //         color: Colors.white,
    //     //         fontWeight: FontWeight.bold,
    //     //       ),
    //     //     ),
    //     // ]),
    //     Row(
    //       children: [
    //         CircleAvatar(
    //           radius: 20,
    //           backgroundColor: primaryColorGrey[100],
    //           backgroundImage: currentUser.profilePictureUrl != null &&
    //                   currentUser.profilePictureUrl!.isNotEmpty
    //               ? NetworkImage(currentUser.profilePictureUrl!)
    //               : null,
    //           child: (currentUser.profilePictureUrl == null ||
    //                   currentUser.profilePictureUrl!.isEmpty)
    //               ? Text(
    //                   currentUser.fullName.isNotEmpty
    //                       ? currentUser.fullName[0].toUpperCase()
    //                       : 'U',
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 )
    //               : null,
    //         ),
    //         const SizedBox(width: 8),
    //         Text(
    //           currentUser.fullName,
    //           style: const TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //       ],
    //     ),

    //     const SizedBox(width: 8),
    //     IconButton(
    //       tooltip: 'Logout',
    //       icon: const Icon(Icons.logout),
    //       onPressed: onLogout,
    //     ),
    //   ],
    // );

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
              // ...desktopNavItems
              //     .map((item) => _navButton(context, item.title, () {
              //           if (item.url == "/user-dashboard") {
              //             onScrollToRegister();
              //           } else {
              //             Navigator.pushNamed(context, item.url);
              //           }
              //         })),

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
                    }
                  },
                  isActive: isActive, // ✅ Highlight current item
                );
              }),

              // PopupMenuButton<String>(
              //   tooltip: "More",
              //   onSelected: (url) => Navigator.pushNamed(context, url),
              //   itemBuilder: (BuildContext context) {
              //     print(
              //         "Misc items in menu: ${miscNavItems.map((e) => e.title).toList()}"); // Add this
              //     return miscNavItems.map((item) {
              //       return PopupMenuItem<String>(
              //         value: item.url,
              //         child: Text(item.title),
              //       );
              //     }).toList();
              //   },
              //   child: _navButton(context, "More", () {}),
              // ),

              // PopupMenuButton<String>(
              //   tooltip: "More",
              //   onSelected: (url) => Navigator.pushNamed(context, url),
              //   itemBuilder: (BuildContext context) {
              //     return [
              //       const PopupMenuItem<String>(
              //           value: "/test1", child: Text("Test Item 1")),
              //       const PopupMenuItem<String>(
              //           value: "/test2", child: Text("Test Item 2")),
              //       const PopupMenuItem<String>(
              //           value: "/test3", child: Text("Test Item 3")),
              //       const PopupMenuItem<String>(
              //           value: "/test4", child: Text("Test Item 4")),
              //       const PopupMenuItem<String>(
              //           value: "/test5", child: Text("Test Item 5")),
              //       const PopupMenuItem<String>(
              //           value: "/test6", child: Text("Test Item 6")),
              //       const PopupMenuItem<String>(
              //           value: "/test7", child: Text("Test Item 7")),
              //       const PopupMenuItem<String>(
              //           value: "/test8", child: Text("Test Item 8")),
              //       const PopupMenuItem<String>(
              //           value: "/test9", child: Text("Test Item 9")),
              //       const PopupMenuItem<String>(
              //           value: "/test10", child: Text("Test Item 10")),
              //       const PopupMenuItem<String>(
              //           value: "/test11", child: Text("Test Item 11")),
              //     ];
              //   },
              //   child: _navButton(context, "More", () {}),
              // ),

              PopupMenuButton<String>(
                tooltip: "More",
                onSelected: (url) {
                  final selectedItem = navigationItems.firstWhere(
                    (item) => item.url == url,
                    orElse: () => NavigationItem(id: "", title: "", url: ""),
                  );
                  if (selectedItem.isLogoutTrigger) {
                    onLogout();
                  } else {
                    Navigator.pushNamed(context, url);
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
                                color: isActive ? primaryColor : null,
                              ),
                            ),
                          );
                        }).toList();
                },
                child: _navButton(
                    context, "More", null), // Pass null for onPressed
              ),

              // HoverableMenuButton(
              //   items: miscNavItems,
              //   currentRoute: currentRoute,
              //   onSelected: (url) {
              //     final selectedItem = navigationItems.firstWhere(
              //       (item) => item.url == url,
              //       orElse: () => NavigationItem(id: "", title: "", url: ""),
              //     );
              //     if (selectedItem.isLogoutTrigger) {
              //       onLogout();
              //     } else {
              //       Navigator.pushNamed(context, url);
              //     }
              //   },
              // ),
            ],
          ),
        ),

        // Right - settings, profile, logout
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
                  backgroundColor: primaryColor[300],
                  backgroundImage: currentUser.profilePictureUrl != null &&
                          currentUser.profilePictureUrl!.isNotEmpty
                      ? NetworkImage(currentUser.profilePictureUrl!)
                      : null,
                  child: (currentUser.profilePictureUrl == null ||
                          currentUser.profilePictureUrl!.isEmpty)
                      ? Text(
                          currentUser.memberFullName.isNotEmpty
                              ? currentUser.memberFullName[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  currentUser.memberFullName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Logout',
              icon: const Icon(Icons.logout),
              onPressed: onLogout,
            ),
          ],
        ),
      ],
    );
  }

  // Widget _navButton(
  //     BuildContext context, String text, VoidCallback? onPressed) {
  //   return TextButton(
  //     onPressed: onPressed, // Allow null to avoid overriding PopupMenuButton
  //     style: TextButton.styleFrom(
  //       foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //     ),
  //     child: Row(
  //       children: [
  //         Text(text),
  //         if (text == "More") const Icon(Icons.arrow_drop_down, size: 20),
  //       ],
  //     ),
  //   );
  // }

  Widget _navButton(
    BuildContext context,
    String text,
    VoidCallback? onPressed, {
    bool isActive = false,
  }) {
    final baseColor = isActive
        ? primaryColor // ✅ Highlight if active
        : Theme.of(context).textTheme.bodyLarge?.color;

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
              // color: Theme.of(context).primaryColor, // Ensure text is vibrant
              // color: Theme.of(context).textTheme.bodyLarge?.color,
              // color: Theme.of(context).textTheme.titleMedium?.color,
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

// // components/footer_header/desktop_nav_bar.dart
// import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/models/beno_project_model.dart';
// import 'package:flutter/material.dart';
// import '../../data/navigation_data.dart';
// import '../../widgets/settings_dialog.dart';

// class DesktopNavBar extends StatelessWidget {
//   final VoidCallback onScrollToRegister;
//   final VoidCallback onLogout;
//   final BenoPersonalDetailsType currentUser;
//   const DesktopNavBar(
//       {super.key,
//       required this.onScrollToRegister,
//       required this.onLogout,
//       required this.currentUser});

//   @override
//   Widget build(BuildContext context) {
//     final desktopNavItems = navigationItems
//         .where((item) => !item.onlyMobile && !item.isMisc)
//         .toList();
//     final miscNavItems = navigationItems.where((item) => item.isMisc).toList();

//     return Row(
//       children: [
//         ...desktopNavItems.map((item) => _navButton(context, item.title, () {
//               if (item.url == "/user-dashboard") {
//                 onScrollToRegister();
//               } else {
//                 Navigator.pushNamed(context, item.url);
//               }
//             })),
//         PopupMenuButton<String>(
//           child: _navButton(context, "More", () {}),
//           onSelected: (url) => Navigator.pushNamed(context, url),
//           itemBuilder: (BuildContext context) {
//             return miscNavItems.map((item) {
//               return PopupMenuItem<String>(
//                 value: item.url,
//                 child: Text(item.title),
//               );
//             }).toList();
//           },
//         ),
//         const SizedBox(width: 24),
//         IconButton(
//           tooltip: 'Display Settings',
//           icon: const Icon(Icons.settings_outlined),
//           onPressed: () => showDialog(
//             context: context,
//             builder: (context) => const SettingsDialog(),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _navButton(BuildContext context, String text, VoidCallback onPressed) {
//     return TextButton(
//       onPressed: onPressed,
//       style: TextButton.styleFrom(
//         foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Row(
//         children: [
//           Text(text),
//           if (text == "More") const Icon(Icons.arrow_drop_down, size: 20),
//         ],
//       ),
//     );
//   }
// }
