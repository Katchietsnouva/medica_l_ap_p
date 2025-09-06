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

  const CoverPlanCard({
    super.key,
    required this.title,
    required this.amount,
    required this.coverage,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color selectedColor = theme.colorScheme.onSurface;
    final Color unselectedColor = theme.colorScheme.onSurface;

    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: isSelected ? selectedColor : unselectedColor,
      fontSize: 18,
      height: 1.3,
    );

    final amountStyle = TextStyle(
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      color: isSelected ? selectedColor : unselectedColor,
      fontSize: 16,
      height: 1.4,
    );

    final coverageStyle = TextStyle(
      color: isSelected
          ? selectedColor.withOpacity(0.9)
          : unselectedColor.withOpacity(0.8),
      fontSize: 14,
      height: 1.3,
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: CustomStyledContainer_2(
          isSelected: isSelected,
          outlineTypeOnSelection: OutlineTypeOnSelection.outline,
          minHeight: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 8),
              Text('Ksh. $amount', style: amountStyle),
              const SizedBox(height: 8),
              Text('Ksh. $coverage Coverage', style: coverageStyle),
            ],
          ),
        ),
      ),
    );
  }
}
