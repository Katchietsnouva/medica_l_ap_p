// lib/lib_medica_l_ap_p/widgets/custom_styled_container_2.dart

import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

enum OutlineTypeOnSelection {
  filled,
  outline,
}

class CustomStyledContainer_2 extends StatelessWidget {
  final bool isSelected;
  final double? minHeight;
  final double? minWidth;
  final OutlineTypeOnSelection outlineTypeOnSelection;

  final Widget child;

  const CustomStyledContainer_2({
    super.key,
    required this.isSelected,
    this.minHeight,
    this.outlineTypeOnSelection = OutlineTypeOnSelection.filled,
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
        color: outlineTypeOnSelection == OutlineTypeOnSelection.outline
            ? Colors.red
            // ? Colors.transparent
            : null,
        // : AppTheme.surfaceColor_3,
        // : Colors.pink,
        gradient: outlineTypeOnSelection == OutlineTypeOnSelection.filled &&
                isSelected
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // affects part 1 when selected
                  theme.colorScheme.primary,
                  // theme.colorScheme.primary.withAlpha(200),
                  // AppTheme.surfaceColor_2,
                  theme.colorScheme.primary.withAlpha(50),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isSelected
                    ? [
                        // affected selected wtiht outline when selected, if removed we cownt see any text
                        // theme.colorScheme.primary,
                        AppTheme.surfaceColor_3,
                        // theme.colorScheme.primary.withAlpha(1),
                        // theme.colorScheme.primary.withAlpha(255)
                        AppTheme.surfaceColor_3,
                      ]
                    : [
                        // affects part 1 when not selected
                        theme.cardTheme.color!,
                        // theme.colorScheme.onSurface.withOpacity(0.9)
                        AppTheme.surfaceColor_2,
                      ],
              ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface.withAlpha(150),
          width: isSelected ? 2.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.5)
                : theme.colorScheme.onSurface.withOpacity(0.5),
            // color: Colors.red,
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
