// lib/widgets/selection_card.dart
import 'package:flutter/material.dart';
import 'package:broka/lib_medica_l_ap_p/utils/app_theme.dart';
// import 'package:broka/lib_medica_l_ap_p/providers/app_provider.dart';
// // lib/widgets/selection_card.dart

class SelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double? minHeight;

  const SelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Define the text style once to ensure consistency
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? AppTheme.primaryColor
              : AppTheme.primaryColor.withOpacity(0.9),
          // Set a consistent line height for better spacing
          height: 1.4,
        );

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // Use minHeight if provided for extra control
          constraints: BoxConstraints(minHeight: minHeight ?? 140),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.surfaceColor
                : AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.primaryColor.withOpacity(0.9),
              ),
              const SizedBox(height: 12),

              // --- THE UPGRADED TEXT WIDGET ---
              // We use a Stack to guarantee a minimum height of 2 lines.
              Stack(
                alignment: Alignment.center,
                children: [
                  // 1. The INVISIBLE "Strut":
                  // This text has two lines (' \n ') and is invisible.
                  // It stretches the Stack to be exactly two lines high based on the font style.
                  Opacity(
                    opacity: 0.0,
                    child: Text(
                      ' \n ', // Two lines of text to set the minimum height
                      style: textStyle,
                    ),
                  ),

                  // 2. The VISIBLE Title:
                  // This is the actual title, centered inside the Stack.
                  // It can take up to 2 lines and will add an ellipsis if it's too long.
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2, // Max lines set to 2
                    overflow:
                        TextOverflow.ellipsis, // Add '...' if text is longer
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
// // import 'package:broka/lib_medica_l_ap_p/providers/app_provider.dart';
// class SelectionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final double? minHeight;

//   const SelectionCard({
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
