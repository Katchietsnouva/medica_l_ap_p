// lib/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/dashboard_overview_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/dashboard_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/my_cover_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/payment_history_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/home_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/payment/payment_screen.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/screens/dashboard/contact_screen.dart'; // Add this import

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    // This ShellRoute creates the persistent navigation for the dashboard
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      // builder: (context, state, child) {
      //   return DashboardScreen(child: child); // The shell UI
      // },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardOverviewScreen(),
        ),
        GoRoute(
          path: '/my-cover',
          builder: (context, state) => const MyCoverScreen(),
        ),
        GoRoute(
          path: '/payment-history',
          builder: (context, state) => const PaymentHistoryScreen(),
        ),
        // FIX: Add the missing contact route
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactScreen(),
        ),
      ],
    ),
  ],
);
