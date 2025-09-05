// lib/lib_medica_l_ap_p/widgets/home_page_section/quote_summary_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/popup_dialog_utils.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';

class QuoteSummaryCard extends StatelessWidget {
  final VoidCallback onProceedToPayment;

  const QuoteSummaryCard({
    super.key,
    required this.onProceedToPayment,
  });

  // Helper to format the plan name enum into a readable string
  String _formatPlanName(PlanType planType) {
    switch (planType) {
      case PlanType.royalPre:
        return 'Royal Pre';
      case PlanType.royalMedExe:
        return 'Royalmed Exe';
      default:
        return 'Not Selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    // The summary is visible only when a cover amount AND a final plan have been selected.
    final isVisible = provider.selectedCoverAmount != null &&
        provider.selectedPlanType != PlanType.none;

    final currencyFormatter = NumberFormat.currency(
        locale: 'en_KE', symbol: 'Ksh ', decimalDigits: 0);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 0.0,
      child: isVisible
          ? CustomStyledContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Quote Summary",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  _buildPremiumHighlight(
                      context, currencyFormatter, provider.selectedPlanAmount),
                  const SizedBox(height: 24),
                  _buildPlanDetails(context, currencyFormatter, provider),
                  // const Divider(height: 32),
                  // _buildBeneficiaryDetails(context, provider),
                  const SizedBox(height: 32),
                  const Divider(height: 32),
                  _buildCalculationSummary(
                      context, provider, currencyFormatter),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: NouvaButton(
                      onPressed: () {
                        // showPopupDialog(
                        //   context,
                        //   message:
                        //       'Quote confirmed! Please provide contact details.',
                        //   autoCloseDuration: const Duration(seconds: 2),
                        //   showButton: false,
                        // );
                        context.read<AppProvider>().showPaymentForm();
                        onProceedToPayment();
                      },
                      text: 'Confirm Quote & Enter Details',
                    ),
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // A new dedicated widget for the highlighted premium amount
  Widget _buildPremiumHighlight(
      BuildContext context, NumberFormat formatter, int? premium) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            "ANNUAL PREMIUM",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.0,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            formatter.format(premium ?? 0),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanDetails(
      BuildContext context, NumberFormat formatter, AppProvider provider) {
    return Row(
      children: [
        _buildDetailItem(
          context,
          label: "Plan Name",
          value: _formatPlanName(provider.selectedPlanType),
        ),
        _buildDetailItem(
          context,
          label: "Cover Limit",
          value: formatter.format(provider.selectedCoverAmount),
        ),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context,
      {required String label, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaryDetails(BuildContext context, AppProvider provider) {
    final coverTypeString = provider.selectedCoverType
        .toString()
        .split('.')
        .last
        .replaceAllMapped(RegExp(r'(\w)(\w+)'),
            (match) => '${match.group(1)!.toUpperCase()}${match.group(2)}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "WHO'S COVERED",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSummaryRow(
          context,
          icon: Icons.person_outline,
          label: "Principal (You)",
          value: DateFormat('dd MMM, yyyy').format(provider.myDob!),
        ),
        if (provider.selectedCoverType == CoverType.spouse ||
            provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            icon: Icons.favorite_border,
            label: "Spouse",
            value: DateFormat('dd MMM, yyyy').format(provider.spouseDob!),
          ),
        ],
        if (provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            icon: Icons.child_care_outlined,
            label: "Children",
            value: provider.childCount.toString(),
          ),
        ],
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
        const SizedBox(width: 16),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Add the missing calculation summary widget
  // Widget _buildCalculationSummary(
  //     BuildContext context, AppProvider provider, NumberFormat formatter) {
  //   // Example summary, adjust as needed for your app's logic
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Calculation Summary",
  //         style: Theme.of(context)
  //             .textTheme
  //             .titleMedium
  //             ?.copyWith(fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 12),
  //       _buildSummaryRow(
  //         context,
  //         icon: Icons.attach_money,
  //         label: "Base Premium",
  //         value: formatter.format(provider.selectedPlanAmount ?? 0),
  //       ),
  //       const SizedBox(height: 8),
  //       _buildSummaryRow(
  //         context,
  //         icon: Icons.percent,
  //         label: "Tax (16%)",
  //         value: formatter
  //             .format(((provider.selectedPlanAmount ?? 0) * 0.16).round()),
  //       ),
  //       const SizedBox(height: 8),
  //       _buildSummaryRow(
  //         context,
  //         icon: Icons.check_circle_outline,
  //         label: "Total Payable",
  //         value: formatter
  //             .format(((provider.selectedPlanAmount ?? 0) * 1.16).round()),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCalculationSummary(
      BuildContext context, AppProvider provider, NumberFormat formatter) {
    // 1. Get the base premium (Sum Insured)
    final double premium = (provider.selectedPlanAmount ?? 0).toDouble();

    // 2. Perform the calculations
    const double pcfRate = 0.0025; // 0.25%
    const double itlRate = 0.0020; // 0.2%
    const double stampDuty = 40.00;

    final double pcf = premium * pcfRate;
    final double itl = premium * itlRate;
    final double total = premium + pcf + itl + stampDuty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .scaffoldBackgroundColor, // A slightly different background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "COST BREAKDOWN",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCalculationRow(
            context,
            label: 'Sum Insured (Premium)',
            value: formatter.format(premium),
          ),
          const SizedBox(height: 8),
          // _buildCalculationRow(
          //   context,
          //   label: 'PCF (0.25%)',
          //   value: formatter.format(pcf),
          // ),
          // const SizedBox(height: 8),
          // _buildCalculationRow(
          //   context,
          //   label: 'ITL (0.2%)',
          //   value: formatter.format(itl),
          // ),
          // const SizedBox(height: 8),
          // _buildCalculationRow(
          //   context,
          //   label: 'Stamp Duty',
          //   value: formatter.format(stampDuty),
          // ),
          // const Divider(height: 24),
          // _buildCalculationRow(
          //   context,
          //   label: 'Total Payable',
          //   value: formatter.format(total),
          //   isTotal: true, // Make it stand out
          // ),

          ...provider.calculatedTaxes.map((tax) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildCalculationRow(
                  context,
                  label:
                      '${tax.name} ${tax.rate > 0 ? '(${tax.rate * 100}%)' : ''}'
                          .trim(),
                  value: formatter.format(tax.amount),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCalculationRow(BuildContext context,
      {required String label, required String value, bool isTotal = false}) {
    final valueStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          color: isTotal ? Theme.of(context).colorScheme.primary : null,
        );

    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(),
        Text(
          value,
          style: valueStyle,
        ),
      ],
    );
  }
}

// class _buildCalculationSummary  {
// }

// // lib/lib_medica_l_ap_p/widgets/home_page_section/quote_summary_card.dart

// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/popup_dialog_utils.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';

// class QuoteSummaryCard extends StatelessWidget {
//   final VoidCallback onProceedToPayment;

//   const QuoteSummaryCard({
//     super.key,
//     required this.onProceedToPayment,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AppProvider>();
//     final isVisible = provider.selectedCoverAmount != null &&
//         provider.selectedPlanAmount != null;

//     final coverTypeString =
//         provider.selectedCoverType.toString().split('.').last.replaceAllMapped(
//               RegExp(r'(\w)(\w+)'),
//               (match) => '${match.group(1)!.toUpperCase()}${match.group(2)}',
//             );

//     final amountFormatter = NumberFormat.currency(
//         locale: 'en_KE', symbol: 'Ksh ', decimalDigits: 0);

//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 400),
//       opacity: isVisible ? 1.0 : 0.0,
//       child: isVisible
//           ? CustomStyledContainer(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Your Quote Summary",
//                       style: Theme.of(context).textTheme.headlineMedium),
//                   const SizedBox(height: 20),
//                   _buildSummaryRow("Cover For", coverTypeString),
//                   _buildSummaryRow("Your DOB",
//                       DateFormat('dd MMM, yyyy').format(provider.myDob!)),
//                   if (provider.selectedCoverType == CoverType.spouse ||
//                       provider.selectedCoverType == CoverType.family)
//                     _buildSummaryRow("Spouse's DOB",
//                         DateFormat('dd MMM, yyyy').format(provider.spouseDob!)),
//                   if (provider.selectedCoverType == CoverType.family)
//                     _buildSummaryRow(
//                         "Children", provider.childCount.toString()),
//                   const Divider(height: 30),
//                   _buildSummaryRow(
//                     "Cover Amount",
//                     amountFormatter.format(provider.selectedCoverAmount),
//                     isHighlight: true,
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     "Premium details will be calculated here.",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(fontStyle: FontStyle.italic),
//                   ),
//                   const SizedBox(height: 24),
//                   // context.go('/dashboard');
//                   // context.push('/payment');
//                   Row(
//                     children: [
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: NouvaButton(
//                             onPressed: () {
//                               showPopupDialog(
//                                 context,
//                                 message: 'Quote saved successfully!',
//                                 autoCloseDuration: const Duration(seconds: 2),
//                                 showButton: false,
//                               );
//                               context.read<AppProvider>().showPaymentForm();
//                               onProceedToPayment();
//                             },
//                             text: 'Confirm Quote'),
//                       )
//                       // ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           : const SizedBox.shrink(),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value,
//       {bool isHighlight = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style:
//                 const TextStyle(color: AppTheme.subtleTextColor, fontSize: 16),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               color: isHighlight ? AppTheme.secondaryColor : AppTheme.textColor,
//               fontSize: 16,
//               fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
