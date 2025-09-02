// lib/lib_medica_l_ap_p/widgets/home_page_section/quote_summary_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/dialog_utils.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';

class QuoteSummaryCard extends StatelessWidget {
  final VoidCallback onProceedToPayment;

  const QuoteSummaryCard({
    super.key,
    required this.onProceedToPayment,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isVisible = provider.selectedCoverAmount != null;

    final coverTypeString =
        provider.selectedCoverType.toString().split('.').last.replaceAllMapped(
              RegExp(r'(\w)(\w+)'),
              (match) => '${match.group(1)!.toUpperCase()}${match.group(2)}',
            );

    final amountFormatter = NumberFormat.currency(
        locale: 'en_KE', symbol: 'Ksh ', decimalDigits: 0);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isVisible ? 1.0 : 0.0,
      child: isVisible
          ? CustomStyledContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Quote Summary",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  _buildSummaryRow("Cover For", coverTypeString),
                  _buildSummaryRow("Your DOB",
                      DateFormat('dd MMM, yyyy').format(provider.myDob!)),
                  if (provider.selectedCoverType == CoverType.spouse ||
                      provider.selectedCoverType == CoverType.family)
                    _buildSummaryRow("Spouse's DOB",
                        DateFormat('dd MMM, yyyy').format(provider.spouseDob!)),
                  if (provider.selectedCoverType == CoverType.family)
                    _buildSummaryRow(
                        "Children", provider.childCount.toString()),
                  const Divider(height: 30),
                  _buildSummaryRow(
                    "Cover Amount",
                    amountFormatter.format(provider.selectedCoverAmount),
                    isHighlight: true,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Premium details will be calculated here.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 24),
                  // context.go('/dashboard');
                  // context.push('/payment');
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: NouvaButton(
                            onPressed: () {
                              showPopupDialog(
                                context,
                                message: 'Quote saved successfully!',
                                autoCloseDuration: const Duration(seconds: 2),
                                showButton: false,
                              );
                              context.read<AppProvider>().showPaymentForm();
                              onProceedToPayment();
                            },
                            text: 'Confirm Quote'),
                      )
                      // ),
                    ],
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                const TextStyle(color: AppTheme.subtleTextColor, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlight ? AppTheme.secondaryColor : AppTheme.textColor,
              fontSize: 16,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
