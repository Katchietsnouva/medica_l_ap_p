// lib/widgets/summary_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:broka/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:broka/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:go_router/go_router.dart';

class SummaryCard extends StatelessWidget {
  final VoidCallback onProceedToPayment;

  const SummaryCard({
    super.key,
    required this.onProceedToPayment, // ADD THIS
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

    final amountFormatter =
        NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isVisible ? 1.0 : 0.0,
      child: isVisible
          ? Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.secondaryColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondaryColor.withOpacity(0.85),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
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
                  // Placeholder for premium cost
                  Text(
                    "Premium details will be calculated here.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 24),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: AppTheme.secondaryColor),
                  //     child: const Text("Proceed to Payment"),
                  //   ),
                  // )
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // context.go('/dashboard');
                            Navigator.pushNamed(context, '/dashboard');
                          },
                          child: const Text("Pay Later"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // context.push('/payment'); // Navigate to payment form
                            context.read<AppProvider>().showPaymentForm();
                            // 2. Trigger the scroll callback passed from home_screen
                            onProceedToPayment();
                          },
                          child: const Text("Proceed to Payment"),
                        ),
                      ),
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
