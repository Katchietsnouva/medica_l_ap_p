import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardOverviewScreen extends StatefulWidget {
  final bool isSidebarExpandedMobile;
  final bool isSidebarExpandedWide;

  const DashboardOverviewScreen({
    super.key,
    this.isSidebarExpandedMobile = false, // Default: minimized on mobile
    this.isSidebarExpandedWide = true, // Default: expanded on wide screens
  });

  @override
  State<DashboardOverviewScreen> createState() =>
      _DashboardOverviewScreenState();
}

class _DashboardOverviewScreenState extends State<DashboardOverviewScreen> {
  late bool isSidebarExpanded;

  @override
  void initState() {
    super.initState();
    // Initialize isSidebarExpanded to a default value; actual value set in didChangeDependencies
    isSidebarExpanded = widget.isSidebarExpandedWide;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set sidebar state based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    isSidebarExpanded = screenWidth < 600
        ? widget.isSidebarExpandedMobile
        : widget.isSidebarExpandedWide;
  }

  void _showDetailPopup(
    BuildContext context,
    String title,
    List<Map<String, String>> details,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: details
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildDetailRow(
                      context,
                      label: entry.value['label']!,
                      value: entry.value['value']!,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final currencyFormat = NumberFormat.currency(
      locale: 'en_KE',
      symbol: 'Ksh ',
    );

    return CardAnimationLayout(
      index: 6,
      bounce: false, // Subtle entrance for the sidebar
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isSidebarExpanded ? 200 : 60,
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  isSidebarExpanded ? Icons.menu_open : Icons.menu,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    isSidebarExpanded = !isSidebarExpanded;
                  });
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CardAnimationLayout(
                    index: 7,
                    bounce: true,
                    child: _buildSidebarButton(
                      context,
                      icon: Icons.person_outline,
                      label: 'Profile',
                      onTap: () =>
                          _showDetailPopup(context, 'Profile Details', [
                            {
                              'label': 'Name',
                              'value': appProvider.spouseName.isNotEmpty
                                  ? appProvider.spouseName
                                  : 'N/A',
                            },
                            {
                              'label': 'DOB',
                              'value': appProvider.myDob != null
                                  ? DateFormat(
                                      'dd MMM, yyyy',
                                    ).format(appProvider.myDob!)
                                  : 'N/A',
                            },
                            {
                              'label': 'Email',
                              'value': appProvider.email ?? 'N/A',
                            },
                            {
                              'label': 'Phone',
                              'value': appProvider.phone ?? 'N/A',
                            },
                            {
                              'label': 'KRA PIN',
                              'value': appProvider.kraPin ?? 'N/A',
                            },
                            {
                              'label': 'ID Number',
                              'value': appProvider.idNumber ?? 'N/A',
                            },
                          ]),
                      isExpanded: isSidebarExpanded,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CardAnimationLayout(
                    index: 8,
                    bounce: true,
                    child: _buildSidebarButton(
                      context,
                      icon: Icons.shield_outlined,
                      label: 'Cover Details',
                      onTap: () => _showDetailPopup(context, 'Cover Details', [
                        {
                          'label': 'Plan',
                          'value': appProvider.selectedPlanType
                              .toString()
                              .split('.')
                              .last,
                        },
                        {
                          'label': 'Cover Amount',
                          'value': currencyFormat.format(
                            appProvider.selectedCoverAmount ?? 0,
                          ),
                        },
                        {
                          'label': 'Premium',
                          'value': currencyFormat.format(appProvider.premium),
                        },
                        {
                          'label': 'Start Date',
                          'value': appProvider.coverStartDate != null
                              ? DateFormat(
                                  'dd MMM, yyyy',
                                ).format(appProvider.coverStartDate!)
                              : 'N/A',
                        },
                        {
                          'label': 'End Date',
                          'value': appProvider.coverStartDate != null
                              ? DateFormat('dd MMM, yyyy').format(
                                  DateTime(
                                    appProvider.coverStartDate!.year + 1,
                                    appProvider.coverStartDate!.month,
                                    appProvider.coverStartDate!.day - 1,
                                  ),
                                )
                              : 'N/A',
                        },
                        {
                          'label': 'Insurer',
                          'value': appProvider.selectedInsurer ?? 'N/A',
                        },
                      ]),
                      isExpanded: isSidebarExpanded,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CardAnimationLayout(
                    index: 9,
                    bounce: true,
                    child: _buildSidebarButton(
                      context,
                      icon: Icons.family_restroom_outlined,
                      label: 'Dependants',
                      onTap: () => _showDetailPopup(context, 'Dependants', [
                        if (appProvider.spouseName.isNotEmpty)
                          {
                            'label': 'Spouse',
                            'value':
                                '${appProvider.spouseName} (${appProvider.spouseDob != null ? DateFormat('dd MMM, yyyy').format(appProvider.spouseDob!) : 'N/A'})',
                          },
                        if (appProvider.children.isNotEmpty)
                          ...appProvider.children.asMap().entries.map(
                            (entry) => {
                              'label': 'Child ${entry.key + 1}',
                              'value':
                                  '${entry.value.name} (${entry.value.dob != null ? DateFormat('dd MMM, yyyy').format(entry.value.dob!) : 'N/A'})',
                            },
                          ),
                        if (appProvider.spouseName.isEmpty &&
                            appProvider.children.isEmpty)
                          {
                            'label': 'Dependants',
                            'value': 'No dependants added.',
                          },
                      ]),
                      isExpanded: isSidebarExpanded,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CardAnimationLayout(
                    index: 10,
                    bounce: true,
                    child: _buildSidebarButton(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Payments',
                      onTap: () =>
                          _showDetailPopup(context, 'Payment Details', [
                            {
                              'label': 'Total Payable',
                              'value': currencyFormat.format(
                                appProvider.totalPayable,
                              ),
                            },
                            ...appProvider.calculatedTaxes.map(
                              (tax) => {
                                'label': tax.name,
                                'value': currencyFormat.format(tax.amount),
                              },
                            ),
                            {
                              'label': 'Last Payment',
                              'value': appProvider.lastPaymentAmount != null
                                  ? currencyFormat.format(
                                      appProvider.lastPaymentAmount!,
                                    )
                                  : 'N/A',
                            },
                            {
                              'label': 'Remaining Balance',
                              'value': currencyFormat.format(
                                (appProvider.totalPayable -
                                    (appProvider.lastPaymentAmount ?? 0)),
                              ),
                            },
                          ]),
                      isExpanded: isSidebarExpanded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isExpanded,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: isExpanded
          ? Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Theme.of(context).cardColor.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minLeadingWidth: isExpanded ? 30 : 0,
      dense: !isExpanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final currencyFormat = NumberFormat.currency(
      locale: 'en_KE',
      symbol: 'Ksh ',
    );

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebar(context),
        const SizedBox(width: 16),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardAnimationLayout(
                  index: 0,
                  bounce: true,
                  child: Text(
                    'Welcome Back, ${appProvider.spouseName.isNotEmpty ? appProvider.spouseName : 'User'}!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                CardAnimationLayout(
                  index: 1,
                  bounce: true,
                  child: Text(
                    "Here's a summary of your active cover.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 800
                        ? 4
                        : constraints.maxWidth > 400
                        ? 2
                        : 1;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.5,
                      children: [
                        CardAnimationLayout(
                          index: 2,
                          bounce: true,
                          child: StatCard(
                            title: 'Active Cover Plan',
                            value: appProvider.selectedPlanType
                                .toString()
                                .split('.')
                                .last,
                            subtitle:
                                'Insurer: ${appProvider.selectedInsurer ?? 'N/A'}',
                            icon: Icons.shield_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        CardAnimationLayout(
                          index: 3,
                          bounce: true,
                          child: StatCard(
                            title: 'Cover Amount',
                            value: currencyFormat.format(
                              appProvider.selectedCoverAmount ?? 0,
                            ),
                            subtitle:
                                'Premium: ${currencyFormat.format(appProvider.premium)}',
                            icon: Icons.health_and_safety_outlined,
                            color: Colors.green,
                          ),
                        ),
                        CardAnimationLayout(
                          index: 4,
                          bounce: true,
                          child: StatCard(
                            title: 'Total Balance Due',
                            value: currencyFormat.format(
                              (appProvider.totalPayable -
                                  (appProvider.lastPaymentAmount ?? 0)),
                            ),
                            subtitle:
                                'Last Payment: ${appProvider.lastPaymentAmount != null ? currencyFormat.format(appProvider.lastPaymentAmount!) : 'N/A'}',
                            icon: Icons.account_balance_wallet_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        CardAnimationLayout(
                          index: 5,
                          bounce: true,
                          child: StatCard(
                            title: 'Next Renewal Date',
                            value: appProvider.coverStartDate != null
                                ? DateFormat('dd MMM, yyyy').format(
                                    DateTime(
                                      appProvider.coverStartDate!.year + 1,
                                      appProvider.coverStartDate!.month,
                                      appProvider.coverStartDate!.day - 1,
                                    ),
                                  )
                                : 'N/A',
                            subtitle:
                                'Start Date: ${appProvider.coverStartDate != null ? DateFormat('dd MMM, yyyy').format(appProvider.coverStartDate!) : 'N/A'}',
                            icon: Icons.event_repeat_outlined,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return UniversalPageLayout(slivers: [], child: content);
  }
}

// import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

// class DashboardOverviewScreen extends StatelessWidget {
//   const DashboardOverviewScreen({super.key});

//   void _showDetailPopup(
//       BuildContext context, String title, List<Map<String, String>> details) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: details
//                 .asMap()
//                 .entries
//                 .map(
//                   (entry) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: _buildDetailRow(
//                       context,
//                       label: entry.value['label']!,
//                       value: entry.value['value']!,
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(BuildContext context,
//       {required String label, required String value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             label,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).textTheme.bodyMedium?.color,
//                 ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           flex: 3,
//           child: Text(
//             value,
//             style: Theme.of(context).textTheme.bodyMedium,
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appProvider = context.watch<AppProvider>();
//     final currencyFormat =
//         NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ');

//     final content = Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Custom Sidebar
//         Container(
//           margin: const EdgeInsets.symmetric(
//               vertical: 24), // Add top & bottom margin here
//           width: 200,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               _buildSidebarButton(
//                 context,
//                 icon: Icons.person_outline,
//                 label: 'Profile',
//                 onTap: () => _showDetailPopup(
//                   context,
//                   'Profile Details',
//                   [
//                     {
//                       'label': 'Name',
//                       'value': appProvider.spouseName.isNotEmpty
//                           ? appProvider.spouseName
//                           : 'N/A',
//                     },
//                     {
//                       'label': 'DOB',
//                       'value': appProvider.myDob != null
//                           ? DateFormat('dd MMM, yyyy')
//                               .format(appProvider.myDob!)
//                           : 'N/A',
//                     },
//                     {
//                       'label': 'Email',
//                       'value': appProvider.email ?? 'N/A',
//                     },
//                     {
//                       'label': 'Phone',
//                       'value': appProvider.phone ?? 'N/A',
//                     },
//                     {
//                       'label': 'KRA PIN',
//                       'value': appProvider.kraPin ?? 'N/A',
//                     },
//                     {
//                       'label': 'ID Number',
//                       'value': appProvider.idNumber ?? 'N/A',
//                     },
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               _buildSidebarButton(
//                 context,
//                 icon: Icons.shield_outlined,
//                 label: 'Cover Details',
//                 onTap: () => _showDetailPopup(
//                   context,
//                   'Cover Details',
//                   [
//                     {
//                       'label': 'Plan',
//                       'value': appProvider.selectedPlanType
//                           .toString()
//                           .split('.')
//                           .last,
//                     },
//                     {
//                       'label': 'Cover Amount',
//                       'value': currencyFormat
//                           .format(appProvider.selectedCoverAmount ?? 0),
//                     },
//                     {
//                       'label': 'Premium',
//                       'value': currencyFormat.format(appProvider.premium),
//                     },
//                     {
//                       'label': 'Start Date',
//                       'value': appProvider.coverStartDate != null
//                           ? DateFormat('dd MMM, yyyy')
//                               .format(appProvider.coverStartDate!)
//                           : 'N/A',
//                     },
//                     {
//                       'label': 'End Date',
//                       'value': appProvider.coverStartDate != null
//                           ? DateFormat('dd MMM, yyyy').format(
//                               DateTime(
//                                 appProvider.coverStartDate!.year + 1,
//                                 appProvider.coverStartDate!.month,
//                                 appProvider.coverStartDate!.day - 1,
//                               ),
//                             )
//                           : 'N/A',
//                     },
//                     {
//                       'label': 'Insurer',
//                       'value': appProvider.selectedInsurer ?? 'N/A',
//                     },
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               _buildSidebarButton(
//                 context,
//                 icon: Icons.family_restroom_outlined,
//                 label: 'Dependants',
//                 onTap: () => _showDetailPopup(
//                   context,
//                   'Dependants',
//                   [
//                     if (appProvider.spouseName.isNotEmpty)
//                       {
//                         'label': 'Spouse',
//                         'value':
//                             '${appProvider.spouseName} (${appProvider.spouseDob != null ? DateFormat('dd MMM, yyyy').format(appProvider.spouseDob!) : 'N/A'})',
//                       },
//                     if (appProvider.children.isNotEmpty)
//                       ...appProvider.children.asMap().entries.map(
//                             (entry) => {
//                               'label': 'Child ${entry.key + 1}',
//                               'value':
//                                   '${entry.value.name} (${entry.value.dob != null ? DateFormat('dd MMM, yyyy').format(entry.value.dob!) : 'N/A'})',
//                             },
//                           ),
//                     if (appProvider.spouseName.isEmpty &&
//                         appProvider.children.isEmpty)
//                       {
//                         'label': 'Dependants',
//                         'value': 'No dependants added.',
//                       },
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               _buildSidebarButton(
//                 context,
//                 icon: Icons.account_balance_wallet_outlined,
//                 label: 'Payments',
//                 onTap: () => _showDetailPopup(
//                   context,
//                   'Payment Details',
//                   [
//                     {
//                       'label': 'Total Payable',
//                       'value': currencyFormat.format(appProvider.totalPayable),
//                     },
//                     ...appProvider.calculatedTaxes.map(
//                       (tax) => {
//                         'label': tax.name,
//                         'value': currencyFormat.format(tax.amount),
//                       },
//                     ),
//                     {
//                       'label': 'Last Payment',
//                       'value': appProvider.lastPaymentAmount != null
//                           ? currencyFormat
//                               .format(appProvider.lastPaymentAmount!)
//                           : 'N/A',
//                     },
//                     {
//                       'label': 'Remaining Balance',
//                       'value': currencyFormat.format((appProvider.totalPayable -
//                           (appProvider.lastPaymentAmount ?? 0))),
//                     },
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         // Main Content
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome Back, ${appProvider.spouseName.isNotEmpty ? appProvider.spouseName : 'User'}!',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Here's a summary of your active cover.",
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: 24),
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
//                     return GridView.count(
//                       crossAxisCount: crossAxisCount,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       childAspectRatio: 1.3,
//                       children: [
//                         StatCard(
//                           title: 'Active Cover Plan',
//                           value: appProvider.selectedPlanType
//                               .toString()
//                               .split('.')
//                               .last,
//                           subtitle:
//                               'Insurer: ${appProvider.selectedInsurer ?? 'N/A'}',
//                           icon: Icons.shield_outlined,
//                           color: Colors.blue,
//                         ),
//                         StatCard(
//                           title: 'Cover Amount',
//                           value: currencyFormat
//                               .format(appProvider.selectedCoverAmount ?? 0),
//                           subtitle:
//                               'Premium: ${currencyFormat.format(appProvider.premium)}',
//                           icon: Icons.health_and_safety_outlined,
//                           color: Colors.green,
//                         ),
//                         StatCard(
//                           title: 'Total Balance Due',
//                           value: currencyFormat.format(
//                               (appProvider.totalPayable -
//                                   (appProvider.lastPaymentAmount ?? 0))),
//                           subtitle:
//                               'Last Payment: ${appProvider.lastPaymentAmount != null ? currencyFormat.format(appProvider.lastPaymentAmount!) : 'N/A'}',
//                           icon: Icons.account_balance_wallet_outlined,
//                           color: Colors.orange,
//                         ),
//                         StatCard(
//                           title: 'Next Renewal Date',
//                           value: appProvider.coverStartDate != null
//                               ? DateFormat('dd MMM, yyyy').format(
//                                   DateTime(
//                                     appProvider.coverStartDate!.year + 1,
//                                     appProvider.coverStartDate!.month,
//                                     appProvider.coverStartDate!.day - 1,
//                                   ),
//                                 )
//                               : 'N/A',
//                           subtitle:
//                               'Start Date: ${appProvider.coverStartDate != null ? DateFormat('dd MMM, yyyy').format(appProvider.coverStartDate!) : 'N/A'}',
//                           icon: Icons.event_repeat_outlined,
//                           color: Colors.purple,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );

//     return UniversalPageLayout(
//       slivers: [],
//       child: content,
//     );
//   }

//   Widget _buildSidebarButton(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required VoidCallback onTap}) {
//     return ListTile(
//       leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
//       title: Text(
//         label,
//         style: Theme.of(context)
//             .textTheme
//             .bodyMedium
//             ?.copyWith(fontWeight: FontWeight.bold),
//       ),
//       onTap: onTap,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       tileColor: Theme.of(context).cardColor.withOpacity(0.1),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//     );
//   }
// }

// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';
// // import 'package:flutter/material.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';
// // import 'package:provider/provider.dart';
// // import 'package:intl/intl.dart';

// // class DashboardOverviewScreen extends StatelessWidget {
// //   const DashboardOverviewScreen({super.key});

// //   void _showDetailPopup(
// //       BuildContext context, String title, List<Widget> content) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: content,
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(),
// //             child: const Text('Close'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final appProvider = context.watch<AppProvider>();
// //     final currencyFormat =
// //         NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ');

// //     final content = Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         // Custom Sidebar
// //         Container(
// //           width: 200,
// //           padding: const EdgeInsets.all(16),
// //           decoration: BoxDecoration(
// //             color: Theme.of(context).cardColor,
// //             borderRadius: BorderRadius.circular(12),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.1),
// //                 blurRadius: 8,
// //                 offset: const Offset(0, 2),
// //               ),
// //             ],
// //           ),
// //           child: Column(
// //             children: [
// //               _buildSidebarButton(
// //                 context,
// //                 icon: Icons.person_outline,
// //                 label: 'Profile',
// //                 onTap: () => _showDetailPopup(
// //                   context,
// //                   'Profile Details',
// //                   [
// //                     Text(
// //                         'Name: ${appProvider.spouseName.isNotEmpty ? appProvider.spouseName : 'N/A'}'),
// //                     Text(
// //                         'DOB: ${appProvider.myDob != null ? DateFormat('dd MMM, yyyy').format(appProvider.myDob!) : 'N/A'}'),
// //                     Text('Email: ${appProvider.email ?? 'N/A'}'),
// //                     Text('Phone: ${appProvider.phone ?? 'N/A'}'),
// //                     Text('KRA PIN: ${appProvider.kraPin ?? 'N/A'}'),
// //                     Text('ID Number: ${appProvider.idNumber ?? 'N/A'}'),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               _buildSidebarButton(
// //                 context,
// //                 icon: Icons.shield_outlined,
// //                 label: 'Cover Details',
// //                 onTap: () => _showDetailPopup(
// //                   context,
// //                   'Cover Details',
// //                   [
// //                     Text(
// //                         'Plan: ${appProvider.selectedPlanType.toString().split('.').last}'),
// //                     Text(
// //                         'Cover Amount: ${currencyFormat.format(appProvider.selectedCoverAmount ?? 0)}'),
// //                     Text(
// //                         'Premium: ${currencyFormat.format(appProvider.premium)}'),
// //                     Text(
// //                         'Start Date: ${appProvider.coverStartDate != null ? DateFormat('dd MMM, yyyy').format(appProvider.coverStartDate!) : 'N/A'}'),
// //                     Text(
// //                         'End Date: ${appProvider.coverStartDate != null ? DateFormat('dd MMM, yyyy').format(DateTime(appProvider.coverStartDate!.year + 1, appProvider.coverStartDate!.month, appProvider.coverStartDate!.day - 1)) : 'N/A'}'),
// //                     Text('Insurer: ${appProvider.selectedInsurer ?? 'N/A'}'),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               _buildSidebarButton(
// //                 context,
// //                 icon: Icons.family_restroom_outlined,
// //                 label: 'Dependants',
// //                 onTap: () => _showDetailPopup(
// //                   context,
// //                   'Dependants',
// //                   [
// //                     if (appProvider.spouseName.isNotEmpty)
// //                       Text(
// //                           'Spouse: ${appProvider.spouseName} (${appProvider.spouseDob != null ? DateFormat('dd MMM, yyyy').format(appProvider.spouseDob!) : 'N/A'})'),
// //                     if (appProvider.children.isNotEmpty)
// //                       ...appProvider.children.asMap().entries.map((entry) => Text(
// //                           'Child ${entry.key + 1}: ${entry.value.name} (${entry.value.dob != null ? DateFormat('dd MMM, yyyy').format(entry.value.dob!) : 'N/A'})')),
// //                     if (appProvider.spouseName.isEmpty &&
// //                         appProvider.children.isEmpty)
// //                       const Text('No dependants added.'),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               _buildSidebarButton(
// //                 context,
// //                 icon: Icons.account_balance_wallet_outlined,
// //                 label: 'Payments',
// //                 onTap: () => _showDetailPopup(
// //                   context,
// //                   'Payment Details',
// //                   [
// //                     Text(
// //                         'Total Payable: ${currencyFormat.format(appProvider.totalPayable)}'),
// //                     Text('Taxes:'),
// //                     ...appProvider.calculatedTaxes.map((tax) => Text(
// //                         '${tax.name}: ${currencyFormat.format(tax.amount)}')),
// //                     Text(
// //                         'Last Payment: ${appProvider.lastPaymentAmount != null ? currencyFormat.format(appProvider.lastPaymentAmount!) : 'N/A'}'),
// //                     Text(
// //                         'Remaining Balance: ${currencyFormat.format((appProvider.totalPayable - (appProvider.lastPaymentAmount ?? 0)))}'),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(width: 16),
// //         // Main Content
// //         Expanded(
// //           child: SingleChildScrollView(
// //             padding: const EdgeInsets.all(24.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Welcome Back, ${appProvider.spouseName.isNotEmpty ? appProvider.spouseName : 'User'}!',
// //                   style: Theme.of(context).textTheme.headlineMedium,
// //                 ),
// //                 const SizedBox(height: 8),
// //                 Text(
// //                   "Here's a summary of your active cover.",
// //                   style: Theme.of(context).textTheme.bodyMedium,
// //                 ),
// //                 const SizedBox(height: 24),
// //                 LayoutBuilder(
// //                   builder: (context, constraints) {
// //                     int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
// //                     return GridView.count(
// //                       crossAxisCount: crossAxisCount,
// //                       crossAxisSpacing: 16,
// //                       mainAxisSpacing: 16,
// //                       shrinkWrap: true,
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       childAspectRatio: 1.3,
// //                       children: [
// //                         StatCard(
// //                           title: 'Active Cover Plan',
// //                           value: appProvider.selectedPlanType
// //                               .toString()
// //                               .split('.')
// //                               .last,
// //                           subtitle:
// //                               'Insurer: ${appProvider.selectedInsurer ?? 'N/A'}',
// //                           icon: Icons.shield_outlined,
// //                           color: Colors.blue,
// //                         ),
// //                         StatCard(
// //                           title: 'Cover Amount',
// //                           value: currencyFormat
// //                               .format(appProvider.selectedCoverAmount ?? 0),
// //                           subtitle:
// //                               'Premium: ${currencyFormat.format(appProvider.premium)}',
// //                           icon: Icons.health_and_safety_outlined,
// //                           color: Colors.green,
// //                         ),
// //                         StatCard(
// //                           title: 'Total Balance Due',
// //                           value: currencyFormat.format(
// //                               (appProvider.totalPayable -
// //                                   (appProvider.lastPaymentAmount ?? 0))),
// //                           subtitle:
// //                               'Last Payment: ${appProvider.lastPaymentAmount != null ? currencyFormat.format(appProvider.lastPaymentAmount!) : 'N/A'}',
// //                           icon: Icons.account_balance_wallet_outlined,
// //                           color: Colors.orange,
// //                         ),
// //                         StatCard(
// //                           title: 'Next Renewal Date',
// //                           value: appProvider.coverStartDate != null
// //                               ? DateFormat('dd MMM, yyyy').format(
// //                                   DateTime(
// //                                     appProvider.coverStartDate!.year + 1,
// //                                     appProvider.coverStartDate!.month,
// //                                     appProvider.coverStartDate!.day - 1,
// //                                   ),
// //                                 )
// //                               : 'N/A',
// //                           subtitle:
// //                               'Start Date: ${appProvider.coverStartDate != null ? DateFormat('dd MMM, yyyy').format(appProvider.coverStartDate!) : 'N/A'}',
// //                           icon: Icons.event_repeat_outlined,
// //                           color: Colors.purple,
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ],
// //     );

// //     return UniversalPageLayout(
// //       slivers: [],
// //       child: content,
// //     );
// //   }

// //   Widget _buildSidebarButton(BuildContext context,
// //       {required IconData icon,
// //       required String label,
// //       required VoidCallback onTap}) {
// //     return ListTile(
// //       leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
// //       title: Text(
// //         label,
// //         style: Theme.of(context)
// //             .textTheme
// //             .bodyMedium
// //             ?.copyWith(fontWeight: FontWeight.bold),
// //       ),
// //       onTap: onTap,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //       tileColor: Theme.of(context).cardColor.withOpacity(0.1),
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
// //     );
// //   }
// // }

// // // // lib/screens/dashboard/dashboard_overview_screen.dart
// // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
// // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';
// // // import 'package:provider/provider.dart';
// // // // import 'package:royal_med/providers/dashboard_provider.dart';
// // // // import 'package:royal_med/screens/dashboard/components/stat_card.dart'; // We'll create this next
// // // import 'package:intl/intl.dart';

// // // class DashboardOverviewScreen extends StatelessWidget {
// // //   const DashboardOverviewScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final provider = context.watch<DashboardProvider>();
// // //     final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

// // //     // return Scaffold(
// // //     // appBar: AppBar(
// // //     //   title: const Text('Dashboard'),
// // //     //   automaticallyImplyLeading: false,
// // //     // ),
// // //     final content = SingleChildScrollView(
// // //       padding: const EdgeInsets.all(24.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             'Welcome Back, User!', // Replace with actual user name
// // //             style: Theme.of(context).textTheme.headlineMedium,
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(
// // //             "Here's a summary of your active cover.",
// // //             style: Theme.of(context).textTheme.bodyMedium,
// // //           ),
// // //           const SizedBox(height: 24),
// // //           LayoutBuilder(
// // //             builder: (context, constraints) {
// // //               int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
// // //               return GridView.count(
// // //                 crossAxisCount: crossAxisCount,
// // //                 crossAxisSpacing: 16,
// // //                 mainAxisSpacing: 16,
// // //                 shrinkWrap: true,
// // //                 physics: const NeverScrollableScrollPhysics(),
// // //                 childAspectRatio: 1.5,
// // //                 children: [
// // //                   StatCard(
// // //                     title: 'Active Cover Plan',
// // //                     value: provider.activeCover.coverType,
// // //                     icon: Icons.shield_outlined,
// // //                     color: Colors.blue,
// // //                   ),
// // //                   StatCard(
// // //                     title: 'Cover Amount',
// // //                     value:
// // //                         currencyFormat.format(provider.activeCover.coverAmount),
// // //                     icon: Icons.health_and_safety_outlined,
// // //                     color: Colors.green,
// // //                   ),
// // //                   StatCard(
// // //                     title: 'Total Balance Due',
// // //                     value: currencyFormat.format(provider.totalBalance),
// // //                     icon: Icons.account_balance_wallet_outlined,
// // //                     color: Colors.orange,
// // //                   ),
// // //                   StatCard(
// // //                     title: 'Next Renewal Date',
// // //                     value: DateFormat('dd MMM, yyyy').format(
// // //                       provider.activeCover.quoteDate
// // //                           .add(const Duration(days: 365)),
// // //                     ),
// // //                     icon: Icons.event_repeat_outlined,
// // //                     color: Colors.purple,
// // //                   ),
// // //                 ],
// // //               );
// // //             },
// // //           ),
// // //           // You can add more sections here like recent payments or alerts
// // //         ],
// // //       ),
// // //     );

// // //     return UniversalPageLayout(
// // //       // slivers: [],
// // //       slivers: [],
// // //       child: content,
// // //       // you can pass onScrollToRegister or other params here if needed
// // //     );

// // //     // );
// // //   }
// // // }

// // // // // lib/screens/dashboard/dashboard_overview_screen.dart
// // // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
// // // // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/dashboard_provider.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // // import 'package:royal_med/providers/dashboard_provider.dart';
// // // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/stat_card.dart';

// // // // class DashboardOverviewScreen extends StatelessWidget {
// // // //   const DashboardOverviewScreen({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final provider = context.watch<DashboardProvider>();

// // // //     return Scaffold(
// // // //       appBar: AppBar(title: const Text('Dashboard')),
// // // //       body: GridView.count(
// // // //         crossAxisCount: 2, // Make this adaptive!
// // // //         children: [
// // // //           StatCard(
// // // //               title: 'Active Cover', value: provider.activeCover.coverType),
// // // //           StatCard(
// // // //               title: 'Total Balance Due',
// // // //               value: '\$${provider.totalBalance.toStringAsFixed(2)}'),
// // // //           // ... more stat cards
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
