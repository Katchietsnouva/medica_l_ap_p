// lib/widgets/cover_amount_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class CoverAmountCard extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;

  const CoverAmountCard({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.compact(locale: 'en_US');
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: isSelected ? Colors.white : AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
        );
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 500),
        // padding: const EdgeInsets.symmetric(vertical: 60),
        child: CustomStyledContainer_2(
          isSelected: isSelected,
          minHeight: 140,
          child: Center(
            child: Text(
              formatter.format(amount),
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
