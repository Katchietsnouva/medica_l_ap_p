import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container_2.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// import 'selection_card_2.dart';

class FamilyTypeSelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double? minHeight;

  const FamilyTypeSelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? theme.colorScheme.surface
              : AppTheme.reversedTextColor(context),
          height: 1.4,
        );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: CustomStyledContainer_2(
          isSelected: isSelected,
          minHeight: minHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected
                    ? theme.colorScheme.surface
                    : AppTheme.reversedTextColor(context),
              ),
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.0,
                    child: Text(
                      ' \n ',
                      style: textStyle,
                    ),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// class FamilyTypeSelectionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final double? minHeight;

//   const FamilyTypeSelectionCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//     this.minHeight, // optional minHeight
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? AppTheme.surfaceColor
//                 : AppTheme.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
//               width: isSelected ? 2.0 : 1.0,
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: AppTheme.primaryColor.withOpacity(0.85),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 40,
//                 color: isSelected
//                     ? AppTheme.primaryColor
//                     : AppTheme.primaryColor.withOpacity(0.9),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   color: isSelected
//                       ? AppTheme.primaryColor
//                       : AppTheme.primaryColor.withOpacity(0.9),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
