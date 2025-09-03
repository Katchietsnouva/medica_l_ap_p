// lib/lib_medica_l_ap_p/widgets/custom_styled_container_2.dart

import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class CustomStyledContainer_2 extends StatelessWidget {
  final bool isSelected;
  final double? minHeight;
  final double? minWidth;
  final Widget child;

  const CustomStyledContainer_2({
    super.key,
    required this.isSelected,
    this.minHeight,
    this.minWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      constraints: BoxConstraints(
          minHeight: minHeight ?? 140, minWidth: minWidth ?? 140),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withAlpha(200)
                ]
              : [
                  theme.cardTheme.color!,
                  theme.colorScheme.onSurface.withOpacity(0.1)
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface.withAlpha(100),
          width: isSelected ? 2.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.3)
                : theme.colorScheme.onSurface.withOpacity(0.1),
            blurRadius: isSelected ? 12 : 8,
            offset: const Offset(0, 4),
            spreadRadius: isSelected ? 2 : 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// // // lib/widgets/selection_card.dart

// class SelectionCard_2 extends StatelessWidget {
//   // final IconData icon;
//   // final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final double? minHeight;
//   final Widget child;

//   const SelectionCard_2({
//     super.key,
//     // required this.icon,
//     // required this.title,
//     required this.isSelected,
//     required this.onTap,
//     this.minHeight,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           color: isSelected
//               ? Colors.white
//               : AppTheme.primaryColor.withOpacity(0.9),
//           height: 1.4,
//         );

//     // return Expanded(
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedScale(
//         scale: isSelected ? 1.05 : 1.0,
//         duration: const Duration(milliseconds: 1000),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           constraints: BoxConstraints(minHeight: minHeight ?? 140),
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: isSelected
//                   ? [
//                       AppTheme.primaryColor,
//                       Color(0xFF5E35B1),
//                     ]
//                   : [
//                       AppTheme.surfaceColor,
//                       Color.fromARGB(255, 142, 140, 140),
//                     ],
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
//               width: isSelected ? 2.0 : 1.5,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: isSelected
//                     ? AppTheme.primaryColor.withOpacity(0.3) // Stronger shadow
//                     : Colors.grey.shade200.withOpacity(0.5), // Subtle shadow
//                 blurRadius: isSelected ? 12 : 8,
//                 offset: const Offset(0, 4),
//                 spreadRadius: isSelected ? 2 : 1,
//               ),
//             ],
//           ),
//           child: child,
//         ),
//       ),
//     );
//     // );
//   }
// }
