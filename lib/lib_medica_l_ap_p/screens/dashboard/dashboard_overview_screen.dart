// lib/screens/dashboard/dashboard_overview_screen.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';
import 'package:provider/provider.dart';
// import 'package:royal_med/providers/dashboard_provider.dart';
// import 'package:royal_med/screens/dashboard/components/stat_card.dart'; // We'll create this next
import 'package:intl/intl.dart';

class DashboardOverviewScreen extends StatelessWidget {
  const DashboardOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    // return Scaffold(
    // appBar: AppBar(
    //   title: const Text('Dashboard'),
    //   automaticallyImplyLeading: false,
    // ),
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back, User!', // Replace with actual user name
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Here's a summary of your active cover.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: [
                  StatCard(
                    title: 'Active Cover Plan',
                    value: provider.activeCover.coverType,
                    icon: Icons.shield_outlined,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: 'Cover Amount',
                    value:
                        currencyFormat.format(provider.activeCover.coverAmount),
                    icon: Icons.health_and_safety_outlined,
                    color: Colors.green,
                  ),
                  StatCard(
                    title: 'Total Balance Due',
                    value: currencyFormat.format(provider.totalBalance),
                    icon: Icons.account_balance_wallet_outlined,
                    color: Colors.orange,
                  ),
                  StatCard(
                    title: 'Next Renewal Date',
                    value: DateFormat('dd MMM, yyyy').format(
                      provider.activeCover.quoteDate
                          .add(const Duration(days: 365)),
                    ),
                    icon: Icons.event_repeat_outlined,
                    color: Colors.purple,
                  ),
                ],
              );
            },
          ),
          // You can add more sections here like recent payments or alerts
        ],
      ),
    );

    return UniversalPageLayout(
      // slivers: [],
      slivers: [],
      child: content,
      // you can pass onScrollToRegister or other params here if needed
    );

    // );
  }
}

// // lib/screens/dashboard/dashboard_overview_screen.dart
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:royal_med/providers/dashboard_provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';

// class DashboardOverviewScreen extends StatelessWidget {
//   const DashboardOverviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DashboardProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: GridView.count(
//         crossAxisCount: 2, // Make this adaptive!
//         children: [
//           StatCard(
//               title: 'Active Cover', value: provider.activeCover.coverType),
//           StatCard(
//               title: 'Total Balance Due',
//               value: '\$${provider.totalBalance.toStringAsFixed(2)}'),
//           // ... more stat cards
//         ],
//       ),
//     );
//   }
// }
