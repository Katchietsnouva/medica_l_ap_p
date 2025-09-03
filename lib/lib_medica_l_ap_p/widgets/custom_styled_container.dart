// lib/lib_medica_l_ap_p/widgets/custom_styled_container.dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomStyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BoxDecoration? customDecoration;
  final Key? containerKey;

  const CustomStyledContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.backgroundColor,
    this.customDecoration,
    this.containerKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: containerKey,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ??
            theme.cardTheme.color ??
            theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? theme.colorScheme.outline
              : theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryColor.withOpacity(0.85),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
