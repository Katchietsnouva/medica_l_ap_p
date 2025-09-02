// lib/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

// Import the actual page widgets that will be displayed
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/dashboard_overview_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/my_cover_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/payment_history_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/contact_screen.dart';

class DashboardScreen extends StatefulWidget {
  // CHANGE: This widget no longer takes a child. It manages its own content.
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // The selected index is now the source of truth for which page is shown.
  int _selectedIndex = 0;

  // A list of the widgets to display for each navigation item.
  static const List<Widget> _pages = <Widget>[
    DashboardOverviewScreen(),
    MyCoverScreen(),
    PaymentHistoryScreen(),
    ContactScreen(),
  ];

  // REMOVE the old _calculateSelectedIndex function. It's no longer needed.

  // CHANGE: This function now simply updates the state.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Navigation destinations are the same
  final List<NavigationRailDestination> _navRailDestinations = const [
    NavigationRailDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: Text('Dashboard')),
    NavigationRailDestination(
        icon: Icon(Icons.shield_outlined),
        selectedIcon: Icon(Icons.shield),
        label: Text('My Cover')),
    NavigationRailDestination(
        icon: Icon(Icons.history_outlined),
        selectedIcon: Icon(Icons.history),
        label: Text('Payments')),
    NavigationRailDestination(
        icon: Icon(Icons.contact_support_outlined),
        selectedIcon: Icon(Icons.contact_support),
        label: Text('Contact Us')),
  ];

  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shield_outlined), label: 'My Cover'),
    BottomNavigationBarItem(
        icon: Icon(Icons.history_outlined), label: 'Payments'),
    BottomNavigationBarItem(
        icon: Icon(Icons.contact_support_outlined), label: 'Contact Us'),
  ];

  @override
  Widget build(BuildContext context) {
    // The selectedIndex directly uses our state variable.
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 640) {
        // Mobile View
        return Scaffold(
          // The body now dynamically swaps based on the selected index.
          body: _pages.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped, // Call our stateful method
            items: _bottomNavItems,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: AppTheme.subtleTextColor,
          ),
        );
      } else {
        // Desktop/Tablet View
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected:
                    _onItemTapped, // Call our stateful method
                labelType: NavigationRailLabelType.all,
                destinations: _navRailDestinations,
                indicatorColor: AppTheme.primaryColor.withOpacity(0.2),
                selectedIconTheme:
                    const IconThemeData(color: AppTheme.primaryColor),
                selectedLabelTextStyle:
                    const TextStyle(color: AppTheme.primaryColor),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // The body now dynamically swaps based on the selected index.
              Expanded(child: _pages.elementAt(_selectedIndex)),
            ],
          ),
        );
      }
    });
  }
}

// // lib/screens/dashboard/dashboard_screen.dart
// import 'package:flutter/material.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// import 'package:go_router/go_router.dart';
// // import 'package:royal_med/utils/app_theme.dart';

// class DashboardScreen extends StatefulWidget {
//   final Widget child;
//   const DashboardScreen({super.key, required this.child});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).uri.toString();
//     if (location.startsWith('/my-cover')) return 1;
//     if (location.startsWith('/payment-history')) return 2;
//     if (location.startsWith('/contact')) return 3;
//     return 0; // Default to dashboard
//   }

//   void _onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         context.go('/dashboard');
//         break;
//       case 1:
//         context.go('/my-cover');
//         break;
//       case 2:
//         context.go('/payment-history');
//         break;
//       case 3:
//         context.go('/contact');
//         break;
//     }
//   }

//   final List<NavigationRailDestination> _navRailDestinations = const [
//     NavigationRailDestination(
//         icon: Icon(Icons.dashboard_outlined),
//         selectedIcon: Icon(Icons.dashboard),
//         label: Text('Dashboard')),
//     NavigationRailDestination(
//         icon: Icon(Icons.shield_outlined),
//         selectedIcon: Icon(Icons.shield),
//         label: Text('My Cover')),
//     NavigationRailDestination(
//         icon: Icon(Icons.history_outlined),
//         selectedIcon: Icon(Icons.history),
//         label: Text('Payments')),
//     NavigationRailDestination(
//         icon: Icon(Icons.contact_support_outlined),
//         selectedIcon: Icon(Icons.contact_support),
//         label: Text('Contact Us')),
//   ];

//   final List<BottomNavigationBarItem> _bottomNavItems = const [
//     BottomNavigationBarItem(
//         icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.shield_outlined), label: 'My Cover'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.history_outlined), label: 'Payments'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.contact_support_outlined), label: 'Contact Us'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final selectedIndex = _calculateSelectedIndex(context);

//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth < 640) {
//         // Mobile View
//         return Scaffold(
//           body: widget.child,
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: selectedIndex,
//             onTap: (index) => _onItemTapped(index, context),
//             items: _bottomNavItems,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: AppTheme.primaryColor,
//             unselectedItemColor: AppTheme.subtleTextColor,
//           ),
//         );
//       } else {
//         // Desktop/Tablet View
//         return Scaffold(
//           body: Row(
//             children: [
//               NavigationRail(
//                 selectedIndex: selectedIndex,
//                 onDestinationSelected: (index) => _onItemTapped(index, context),
//                 labelType: NavigationRailLabelType.all,
//                 destinations: _navRailDestinations,
//                 indicatorColor: AppTheme.primaryColor.withOpacity(0.2),
//                 selectedIconTheme:
//                     const IconThemeData(color: AppTheme.primaryColor),
//                 selectedLabelTextStyle:
//                     const TextStyle(color: AppTheme.primaryColor),
//               ),
//               const VerticalDivider(thickness: 1, width: 1),
//               Expanded(child: widget.child),
//             ],
//           ),
//         );
//       }
//     });
//   }
// }

// // // lib/screens/dashboard/dashboard_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';

// // class DashboardScreen extends StatefulWidget {
// //   final Widget child;
// //   const DashboardScreen({super.key, required this.child});

// //   @override
// //   State<DashboardScreen> createState() => _DashboardScreenState();
// // }

// // class _DashboardScreenState extends State<DashboardScreen> {
// //   int _selectedIndex = 0;

// //   final List<String> _routes = [
// //     '/dashboard/home',
// //     '/dashboard/payments',
// //     '/dashboard/profile',
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //     context.go(_routes[index]); // navigate with go_router
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(builder: (context, constraints) {
// //       if (constraints.maxWidth < 600) {
// //         // Mobile View with BottomNavigationBar
// //         return Scaffold(
// //           body: widget.child,
// //           bottomNavigationBar: BottomNavigationBar(
// //             currentIndex: _selectedIndex,
// //             onTap: _onItemTapped,
// //             items: const [
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.home_outlined),
// //                 label: 'Home',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.payment_outlined),
// //                 label: 'Payments',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.person_outline),
// //                 label: 'Profile',
// //               ),
// //             ],
// //           ),
// //         );
// //       } else {
// //         // Desktop/Tablet View with NavigationRail
// //         return Scaffold(
// //           body: Row(
// //             children: [
// //               NavigationRail(
// //                 selectedIndex: _selectedIndex,
// //                 onDestinationSelected: _onItemTapped,
// //                 labelType: NavigationRailLabelType.all,
// //                 destinations: const [
// //                   NavigationRailDestination(
// //                     icon: Icon(Icons.home_outlined),
// //                     label: Text('Home'),
// //                   ),
// //                   NavigationRailDestination(
// //                     icon: Icon(Icons.payment_outlined),
// //                     label: Text('Payments'),
// //                   ),
// //                   NavigationRailDestination(
// //                     icon: Icon(Icons.person_outline),
// //                     label: Text('Profile'),
// //                   ),
// //                 ],
// //               ),
// //               const VerticalDivider(thickness: 1, width: 1),
// //               Expanded(child: widget.child),
// //             ],
// //           ),
// //         );
// //       }
// //     });
// //   }
// // }

// // // // lib/screens/dashboard/dashboard_screen.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:go_router/go_router.dart';

// // // class DashboardScreen extends StatefulWidget {
// // //   final Widget child;
// // //   const DashboardScreen({super.key, required this.child});

// // //   @override
// // //   State<DashboardScreen> createState() => _DashboardScreenState();
// // // }

// // // class _DashboardScreenState extends State<DashboardScreen> {
// // //   int _selectedIndex = 0;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return LayoutBuilder(builder: (context, constraints) {
// // //       if (constraints.maxWidth < 600) {
// // //         // Mobile View with BottomNavigationBar
// // //         return Scaffold(
// // //           body: widget.child,
// // //           bottomNavigationBar: BottomNavigationBar(
// // //               // ... items and onTap logic
// // //               ),
// // //         );
// // //       } else {
// // //         // Desktop/Tablet View with NavigationRail
// // //         return Scaffold(
// // //           body: Row(
// // //             children: [
// // //               NavigationRail(
// // //                   // ... destinations and onDestinationSelected logic
// // //                   ),
// // //               const VerticalDivider(thickness: 1, width: 1),
// // //               Expanded(child: widget.child),
// // //             ],
// // //           ),
// // //         );
// // //       }
// // //     });
// // //   }
// // //   // ... _onItemTapped method to handle navigation
// // // }
