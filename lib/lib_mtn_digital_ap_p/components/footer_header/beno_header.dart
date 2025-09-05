// // components/footer_header/beno_header.dart
// import 'package:flutter/material.dart';
// import '../../models/beno_project_model.dart';
// import 'mobile_nav_panel.dart';
// import 'desktop_nav_bar.dart';

// class BenoHeader extends StatefulWidget {
//   final VoidCallback onLogout;
//   final BenoPersonalDetailsType currentUser;
//   final VoidCallback onScrollToRegister;

//   const BenoHeader({
//     super.key,
//     required this.onLogout,
//     required this.currentUser,
//     required this.onScrollToRegister,
//   });

//   @override
//   State<BenoHeader> createState() => _BenoHeaderState();
// }

// class _BenoHeaderState extends State<BenoHeader> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     // We use a Builder to get the context of the Scaffold for the endDrawer
//     return Scaffold(
//       key: _scaffoldKey,
//       // The endDrawer is our new animated side panel
//       endDrawer: MobileNavPanel(
//         currentUser: widget.currentUser,
//         onLogout: widget.onLogout,
//       ),
//       // The body is transparent so the main CustomScrollView shows through
//       backgroundColor: Colors.transparent,
//       body: SliverAppBar(
//         floating: true,
//         pinned: true,
//         snap: false,
//         backgroundColor:
//             Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.85),
//         elevation: 0,
//         flexibleSpace: FlexibleSpaceBar(
//           background: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                   bottom: BorderSide(
//                       color: Colors.grey.withOpacity(0.2), width: 1)),
//             ),
//           ),
//         ),
//         title: Row(
//           children: const [
//             Icon(Icons.church, color: primaryColor, size: 28),
//             SizedBox(width: 12),
//             Text('Deliverance Church',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         actions: [
//           // Use LayoutBuilder to switch between desktop and mobile actions
//           LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth > 800) {
//                 return DesktopNavBar(
//                     onScrollToRegister: widget.onScrollToRegister);
//               } else {
//                 return IconButton(
//                   icon: const Icon(Icons.menu),
//                   onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
//                   tooltip: 'Open menu',
//                 );
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// components/footer_header/beno_header.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/sections/beno_hero_section.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/steps/beno_form_stepper.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/steps/beno_personal_details_step.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/ui/beno_ui_components.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import '../../models/beno_project_model.dart';
import 'desktop_nav_bar.dart';

class BenoHeader extends StatelessWidget {
  final VoidCallback onLogout;
  final SectionA currentUser;
  final VoidCallback onScrollToRegister;
  // final BuildContext parentContext; // 👈 Add this

  const BenoHeader({
    super.key,
    required this.onLogout,
    required this.currentUser,
    required this.onScrollToRegister,
    // required this.parentContext, // 👈 Add this
  });

  // @override
  // Widget build(BuildContext context) {
  //   // This widget is now just a SliverAppBar, which is a valid child for CustomScrollView.
  //   return SliverAppBar(
  //     floating: true,
  //     pinned: true,
  //     snap: false,
  //     backgroundColor:
  //         Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
  //     elevation: 0,
  //     flexibleSpace: FlexibleSpaceBar(
  //       background: Container(
  //         decoration: BoxDecoration(
  //           border: Border(
  //               bottom:
  //                   BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
  //         ),
  //       ),
  //     ),
  //     title: Row(
  //       children: const [
  //         Icon(Icons.church, color: primaryColor, size: 28),
  //         SizedBox(width: 12),
  //         Text('Deliverance Church',
  //             style: TextStyle(fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //     actions: [
  //       // Use LayoutBuilder to switch between desktop and mobile actions
  //       LayoutBuilder(
  //         builder: (context, constraints) {
  //           // A common breakpoint for switching to a mobile layout.
  //           if (MediaQuery.of(context).size.width > 800) {
  //             return DesktopNavBar(
  //               onScrollToRegister: onScrollToRegister,
  //               onLogout: onLogout,
  //               currentUser: currentUser,
  //             );
  //           } else {
  //             // On mobile, show a menu icon that opens the drawer.
  //             return IconButton(
  //               icon: const Icon(Icons.menu),
  //               // Scaffold.of(context) finds the parent Scaffold and opens its drawer.
  //               onPressed: () => Scaffold.of(context).openEndDrawer(),
  //               tooltip: 'Open menu',
  //             );
  //           }
  //         },
  //       ),
  //       const SizedBox(width: 8), // Add some spacing
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      elevation: 0,
      toolbarHeight: 80, // Adjust height as needed
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
            ),
          ),
        ),
      ),
      title: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Logo
                  Row(
                    children: const [
                      // Icon(Icons.church, color: primaryColor, size: 28),
                      // SizedBox(width: 12),
                      Image(
                        image: AssetImage('assets/mtn_digital/images/logo.png'),
                        height: 64,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Jubilee Insurance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Center: Navigation bar
                  Expanded(
                    child: Center(
                      child: DesktopNavBar(
                        onScrollToRegister: onScrollToRegister,
                        onLogout: onLogout,
                        currentUser: currentUser,
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
                      children: const [
                        // Icon(Icons.church, color: primaryColor, size: 28),
                        Image(
                          image:
                              AssetImage('assets/mtn_digital/images/logo.png'),
                          height: 48,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Jubilee Insurance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        // SizedBox(width: 12),
                        // Text(
                        //   'Deliverance Church',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Display Settings',
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const SettingsDialog(),
                  ),
                )
                // IconButton(
                //   icon: const Icon(Icons.menu),
                //   // onPressed: () => Scaffold.of(context).openEndDrawer(),
                //   onPressed: () {
                //     final scaffoldState = Scaffold.maybeOf(context);
                //     if (scaffoldState?.hasEndDrawer ?? false) {
                //       scaffoldState?.openEndDrawer();
                //     } else {
                //       debugPrint('No endDrawer found in Scaffold');
                //     }
                //   },
                // )
              ],
            );
          }
        },
      ),
    );
  }
}
// // components/footer_header/beno_header.dart
// import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/helpers/responsive_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../logic/theme_provider.dart';
// import '../../models/beno_project_model.dart';
// import '../../widgets/settings_dialog.dart';

// class BenoHeader extends StatelessWidget {
//   final VoidCallback onLogout;
//   final BenoPersonalDetailsType currentUser;
//   final VoidCallback onScrollToRegister;

//   const BenoHeader({
//     super.key,
//     required this.onLogout,
//     required this.currentUser,
//     required this.onScrollToRegister,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
//     final bgColor = isDarkMode
//         ? const Color(0xFF1A1D21).withOpacity(0.85)
//         : Colors.white.withOpacity(0.85);

//     final isSmallScreen = MediaQuery.of(context).size.width < 450;
//     return SliverAppBar(
//       floating: true,
//       pinned: true,
//       snap: false,
//       backgroundColor: bgColor,
//       elevation: 0,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: BoxDecoration(
//             border: Border(
//                 bottom:
//                     BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
//           ),
//         ),
//       ),
//       title: Row(
//         children: [
//           Icon(Icons.church, color: primaryColor, size: 28),
//           SizedBox(width: 12),
//           // Text('Deliverance Church', style: TextStyle(fontWeight: FontWeight.bold)),
//           Text(
//             "Deliverance Church",
//             style: TextStyle(
//               fontSize: responsiveFontSize(context, baseSize: 20),
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       actions: [
//         if (MediaQuery.of(context).size.width > 800) ...[
//           _navButton(context, 'Home', () => Navigator.pushNamed(context, '/')),
//           _navButton(context, 'Register/Update', onScrollToRegister),
//           _navButton(
//               context, 'About', () => Navigator.pushNamed(context, '/about')),
//           _navButton(context, 'Contact',
//               () => Navigator.pushNamed(context, '/contact')),
//         ],
//         // isSmallScreen
//         // if (!isSmallScreen) (sz)

//         const SizedBox(width: 100),
//         IconButton(
//           tooltip: 'Display Settings',
//           icon: const Icon(Icons.settings_outlined),
//           onPressed: () => showDialog(
//             context: context,
//             builder: (context) => const SettingsDialog(),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0),
//           child: CircleAvatar(
//             backgroundColor: primaryColor,
//             child: Text(
//                 currentUser.fullName.isNotEmpty ? currentUser.fullName[0] : 'U',
//                 style: const TextStyle(color: Colors.white)),
//           ),
//         ),
//         IconButton(
//           tooltip: 'Logout',
//           icon: const Icon(Icons.logout),
//           onPressed: onLogout,
//         ),
//         const SizedBox(width: 8),
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
//       child: Text(text),
//     );
//   }
// }

// // components/footer_header/beno_header.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../logic/theme_provider.dart';
// import '../../models/beno_project_model.dart';

// class BenoHeader extends StatelessWidget {
//   final VoidCallback onLogout;
//   final BenoPersonalDetailsType currentUser;
//   final VoidCallback onScrollToRegister;

//   const BenoHeader({
//     super.key,
//     required this.onLogout,
//     required this.currentUser,
//     required this.onScrollToRegister,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
//     final bgColor = isDarkMode
//         ? const Color(0xFF1A1D21).withOpacity(0.85)
//         : Colors.white.withOpacity(0.85);

//     return SliverAppBar(
//       floating: true,
//       pinned: true,
//       snap: false,
//       backgroundColor: bgColor,
//       // backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white.withOpacity(0.85),
//       elevation: 0.5,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: BoxDecoration(
//             border: Border(
//                 bottom:
//                     BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
//           ),
//         ),
//       ),
//       title: Row(
//         children: const [
//           Icon(Icons.church, color: primaryColor, size: 28),
//           SizedBox(width: 12),
//           Text('Deliverance Church'),
//         ],
//       ),
//       actions: [
//         if (MediaQuery.of(context).size.width > 720) ...[
//           //   TextButton(onPressed: () {}, child: const Text('Home')),
//           //   TextButton(onPressed: () {}, child: const Text('Register/Update')),
//           //   TextButton(onPressed: () {}, child: const Text('Contact')),
//           //   TextButton(onPressed: () {}, child: const Text('About')),
//           // ],
//           _navButton(context, 'Home', () => Navigator.pushNamed(context, '/')),
//           _navButton(context, 'Register/Update', onScrollToRegister),
//           _navButton(
//               context, 'About', () => Navigator.pushNamed(context, '/about')),
//           _navButton(context, 'Contact',
//               () => Navigator.pushNamed(context, '/contact')),
//         ],
//         IconButton(
//           icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
//           onPressed: () => themeProvider.toggleTheme(),
//         ),
//         if (MediaQuery.of(context).size.width > 600)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Center(
//               child: Text(
//                 'Welcome, ${currentUser.fullName.split(' ')[0]}',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ),
//           ),
//         IconButton(
//           icon: const Icon(Icons.logout),
//           onPressed: onLogout,
//         ),
//       ],
//     );
//   }
// }

// Widget _navButton(BuildContext context, String text, VoidCallback onPressed) {
//   return TextButton(
//     onPressed: onPressed,
//     style: TextButton.styleFrom(
//       foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     ),
//     child: Text(text),
//   );
// }
