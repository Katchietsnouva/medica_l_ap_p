// lib/lib_medica_l_ap_p/widgets/system_header.dart
import 'dart:ui';

import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import '../models/royal_project_model.dart';
import 'desktop_nav_bar.dart';

class RoyalHeader extends StatelessWidget {
  // final VoidCallback onLogout;
  // final RoyalPersonalDetailsType currentUser;
  final VoidCallback onScrollToRegister;
  // final BuildContext parentContext;

  const RoyalHeader({
    super.key,
    // required this.onLogout,
    // required this.currentUser,
    required this.onScrollToRegister,
    // required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // return SliverAppBar(
      // floating: true,
      // pinned: true,
      // snap: false,
      // backgroundColor:
      //     Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      // elevation: 0,
      // toolbarHeight: 80, // Adjust height as needed
      // flexibleSpace: FlexibleSpaceBar(
      //   background: Container(
      //     decoration: BoxDecoration(
      //       border: Border(
      //         bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      //       ),
      //     ),
      //   ),
      // ),
      // title: LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        if (constraints.maxWidth > 1100) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left: Logo
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 10), // mt
                      padding: const EdgeInsets.only(left: 0, right: 10), // pt
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20), // rounded corners
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: !isDarkMode
                                  ? Colors.black.withOpacity(0.25)
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.2,
                              ),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(
                              'assets/medica_l_ap_p/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Center: Navigation bar
                Expanded(
                  child: Center(
                    child: DesktopNavBar(
                      onScrollToRegister: onScrollToRegister,
                      // onLogout: onLogout,
                      // currentUser: currentUser,
                    ),
                  ),
                ),
                // Right: Empty space or optional buttons
                const SizedBox(width: 48), // Keeps alignment balanced
              ],
            ),
          );
        } else {
          // Mobile: just show menu
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const Text('Deliverance Church',
              //     style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 0, right: 10), // mt
                        padding:
                            const EdgeInsets.only(left: 0, right: 10), // pt
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20), // rounded corners
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              height: 35,
                              width: 160,
                              decoration: BoxDecoration(
                                color: !isDarkMode
                                    ? Colors.black.withOpacity(0.25)
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.2,
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Image.asset(
                                'assets/medica_l_ap_p/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  // Builder(
                  //   builder: (context) {
                  //     return IconButton(
                  //       tooltip: 'Open Menu',
                  //       icon: const Icon(Icons.menu),
                  //       onPressed: () {
                  //         Scaffold.of(context).openEndDrawer();
                  //       },
                  //     );
                  //   },
                  // ),
                  // IconButton(
                  //   tooltip: 'Open Menu',
                  //   icon: const Icon(Icons.menu),
                  //   onPressed: () {
                  //     Scaffold.of(context).openEndDrawer();
                  //   },
                  // ),
                ],
              )
            ],
          );
        }
      },
    );
    // );
  }
}
