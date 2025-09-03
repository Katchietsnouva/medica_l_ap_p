// lib/widgets/cover_amount_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class CoverPlanCard extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;
  final String title, coverage;

  const CoverPlanCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.coverage,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.white
              : AppTheme.primaryColor.withOpacity(0.9),
          height: 1.4,
        );
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: CustomStyledContainer_2(
          isSelected: isSelected,
          minHeight: 160,
          // padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Ksh. $amount', style: textStyle),
              const SizedBox(height: 4),
              Text('Ksh. $coverage Coverage', style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
