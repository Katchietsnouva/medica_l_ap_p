import 'package:flutter/material.dart';
import '../ui/beno_ui_components.dart';
import '../../helpers/responsive_helper.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onRegister;

  const HeroSection({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final double horizontalPadding = isSmall ? 16.0 : 32.0;
        final double verticalPadding = isSmall ? 24.0 : 40.0;
        final double titleSize =
            responsiveFontSize(context, baseSize: isSmall ? 28 : 36);
        final double subtitleSize =
            responsiveFontSize(context, baseSize: isSmall ? 14 : 18);

        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black12
              : Colors.white,
          child: isSmall
              ? _buildSingleColumn(context, titleSize, subtitleSize)
              : _buildTwoColumn(context, titleSize, subtitleSize),
        );
      },
    );
  }

  Widget _buildSingleColumn(
      BuildContext context, double titleSize, double subtitleSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Join the Umbrella Scheme',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Secure your family’s future with our streamlined registration. Easily provide personal, banking, and beneficiary details.',
          style: TextStyle(
            fontSize: subtitleSize,
            color: Colors.grey[800],
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        BenoButton(
          onPressed: onRegister,
          text: 'Register Now',
          compact: true,
          isFullWidth: true,
          backgroundColor: primaryColor,
          // textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildTwoColumn(
      BuildContext context, double titleSize, double subtitleSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join the Umbrella Scheme',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Secure your family’s future with our streamlined registration. Easily provide personal, banking, and beneficiary details.',
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BenoButton(
                onPressed: onRegister,
                text: 'Register Now',
                backgroundColor: primaryColor,
                // textColor: Colors.white,
                // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// // lib/lib_mtn_digital_ap_p/components/hero_section.dart

// import 'package:flutter/material.dart';

// // This is a professional and responsive hero section component.
// // It adapts from a two-column layout on large screens to a single
// // column on small screens.

// //   static const Color primaryColor =
// //       // #D02030
// //       Color(0xFFD02030);

// const Color jubileeRed = Color(0xFFc21b2d);
// const Color jubileeLightGrey = Color(0xFFf0f0f0);
// const Color textDark = Color(0xFF333333);

// class HeroSection extends StatelessWidget {
//   final VoidCallback onRegister;

//   const HeroSection({
//     super.key,
//     required this.onRegister,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Use LayoutBuilder to get the current widget constraints.
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Check if the screen is a large device (e.g., tablet or desktop).
//         final bool isLargeScreen = constraints.maxWidth > 800;

//         // Determine padding based on screen size for professional spacing.
//         final double horizontalPadding = isLargeScreen ? 64.0 : 24.0;
//         final double verticalPadding = isLargeScreen ? 96.0 : 64.0;

//         // Define the main content container.
//         return Container(
//           color: jubileeLightGrey,
//           padding: EdgeInsets.symmetric(
//             horizontal: horizontalPadding,
//             vertical: verticalPadding,
//           ),
//           child: isLargeScreen
//               ? _buildLargeScreenLayout(context, jubileeRed, textDark)
//               : _buildSmallScreenLayout(context, jubileeRed, textDark),
//         );
//       },
//     );
//   }

//   // A method to build the two-column layout for large screens.
//   Widget _buildLargeScreenLayout(
//     BuildContext context,
//     Color primaryColor,
//     Color textColor,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Column 1: Text and Call-to-Action
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Protecting Your Future',
//                 style: TextStyle(
//                   fontSize: 52,
//                   fontWeight: FontWeight.w800,
//                   color: primaryColor,
//                   height: 1.1,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Secure what matters most with our comprehensive insurance solutions. Join the Jubilee Umbrella Scheme today.',
//                 style: TextStyle(
//                   fontSize: 18,
//                   height: 1.5,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               // Register button
//               ElevatedButton(
//                 onPressed: onRegister,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 20,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 child: const Text(
//                   'Register Now',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Column 2: Placeholder for a professional image or graphic
//         const SizedBox(width: 48), // Spacing between columns
//         Expanded(
//           child: Center(
//             child: Container(
//               height: 400,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: jubileeRed.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: primaryColor, width: 2),
//                 // This is a simple placeholder. You can replace it with an Image.
//               ),
//               child: Icon(
//                 Icons.security_rounded,
//                 size: 150,
//                 color: primaryColor.withOpacity(0.4),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // A method to build the single-column layout for small screens.
//   Widget _buildSmallScreenLayout(
//     BuildContext context,
//     Color primaryColor,
//     Color textColor,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Image placeholder at the top
//         Container(
//           height: 250,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: jubileeRed.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: primaryColor, width: 1.5),
//           ),
//           child: Icon(
//             Icons.security_rounded,
//             size: 100,
//             color: primaryColor.withOpacity(0.4),
//           ),
//         ),
//         const SizedBox(height: 40),
//         // Text and Call-to-Action below the image
//         Text(
//           'Protecting Your Future',
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.w800,
//             color: primaryColor,
//             height: 1.2,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Secure what matters most with our comprehensive insurance solutions. Join the Jubilee Umbrella Scheme today.',
//           style: TextStyle(
//             fontSize: 16,
//             height: 1.5,
//             color: textColor,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 32),
//         // Register button
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: onRegister,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               padding: const EdgeInsets.symmetric(vertical: 18),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//             ),
//             child: const Text(
//               'Register Now',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import '../ui/beno_ui_components.dart';
// // import '../../helpers/responsive_helper.dart';

// // class HeroSection extends StatelessWidget {
// //   final VoidCallback onRegister;

// //   const HeroSection({super.key, required this.onRegister});

// //   static const Color primaryColor =
// //       // #D02030
// //       Color(0xFFD02030);

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final isPhone = constraints.maxWidth < 420;
// //         final isNarrow = constraints.maxWidth < 600;
// //         final double horizontalPadding =
// //             isPhone ? 16.0 : (isNarrow ? 24.0 : 32.0);
// //         final double verticalPadding = isPhone ? 12.0 : 16.0;
// //         final double titleSize = responsiveFontSize(context,
// //             baseSize: isPhone ? 28 : (isNarrow ? 34 : 40));
// //         final double subtitleSize = responsiveFontSize(context,
// //             baseSize: isPhone ? 14 : (isNarrow ? 16 : 18));

// //         return Container(
// //           padding: EdgeInsets.symmetric(
// //               horizontal: horizontalPadding, vertical: verticalPadding),
// //           color: Colors.white,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 'Join the Umbrella Scheme',
// //                 style: TextStyle(
// //                   fontSize: titleSize,
// //                   fontWeight: FontWeight.bold,
// //                   color: primaryColor,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 12),
// //               Text(
// //                 'Secure your family’s future with our streamlined registration process. Provide your personal, banking, and beneficiary details effortlessly.',
// //                 style: TextStyle(
// //                   fontSize: subtitleSize,
// //                   color: Colors.grey[800],
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 24),
// //               BenoButton(
// //                 onPressed: onRegister,
// //                 text: 'Register Now',
// //                 compact: isPhone,
// //                 isFullWidth: isNarrow,
// //                 backgroundColor: primaryColor,
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import '../ui/beno_ui_components.dart';
// // // import '../../helpers/responsive_helper.dart';

// // // class HeroSection extends StatelessWidget {
// // //   final VoidCallback onRegister;

// // //   const HeroSection({super.key, required this.onRegister});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Widget build() {
// // //     return LayoutBuilder(
// // //       builder: (context, constraints) {
// // //         final isPhone = constraints.maxWidth < 420;
// // //         final isNarrow = constraints.maxWidth < 600;
// // //         final double horizontalPadding =
// // //             isPhone ? 16.0 : (isNarrow ? 24.0 : 32.0);
// // //         final double verticalPadding = isPhone ? 12.0 : 16.0;
// // //         final double titleSize = responsiveFontSize(context,
// // //             baseSize: isPhone ? 32 : (isNarrow ? 38 : 42));
// // //         final double subtitleSize = responsiveFontSize(context,
// // //             baseSize: isPhone ? 16 : (isNarrow ? 18 : 20));

// // //         return Container(
// // //           padding: EdgeInsets.symmetric(
// // //               horizontal: horizontalPadding, vertical: verticalPadding),
// // //           color: Theme.of(context).brightness == Brightness.dark
// // //               ? Colors.black.withOpacity(0.2)
// // //               : Colors.white,
// // //           child: Column(
// // //             children: [
// // //               Text(
// // //                 'Join the Benevolent Ministry Scheme',
// // //                 style: TextStyle(
// // //                   fontSize: titleSize,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Theme.of(context).brightness == Brightness.dark
// // //                       ? Colors.white
// // //                       : Colors.black,
// // //                 ),
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //               const SizedBox(height: 12),
// // //               Text(
// // //                 'Secure your family’s future with our streamlined registration process. Provide your personal, banking, and beneficiary details effortlessly.',
// // //                 style: TextStyle(
// // //                   fontSize: subtitleSize,
// // //                   color: Colors.grey[600],
// // //                 ),
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //               const SizedBox(height: 24),
// // //               BenoButton(
// // //                 onPressed: onRegister,
// // //                 text: 'Register Now',
// // //                 compact: isPhone,
// // //                 isFullWidth: isNarrow,
// // //                 backgroundColor: Colors.blue,
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // // // // components/sections/beno_hero_section.dart
// // // // import 'package:flutter/material.dart';
// // // // import '../ui/beno_ui_components.dart';
// // // // import '../../helpers/responsive_helper.dart';

// // // // class HeroSection extends StatelessWidget {
// // // //   const HeroSection({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
// // // //       child: Column(
// // // //         children: [
// // // //           Text(
// // // //             'Benevolent Ministry Scheme',
// // // //             // style: Theme.of(context)
// // // //             //     .textTheme
// // // //             //     .displaySmall
// // // //             //     ?.copyWith(fontWeight: FontWeight.bold),
// // // //             style: TextStyle(
// // // //               fontSize: responsiveFontSize(context, baseSize: 42),
// // // //               fontWeight: FontWeight.bold,
// // // //             ),
// // // //             textAlign: TextAlign.center,
// // // //           ),
// // // //           const SizedBox(height: 8),
// // // //           Text(
// // // //             "Our comprehensive member registration system and secure your family's future.",
// // // //             // style: Theme.of(context).textTheme.titleLarge,
// // // //             style: TextStyle(
// // // //               fontSize: responsiveFontSize(context, baseSize: 20),
// // // //               color: Colors.grey[600],
// // // //             ),
// // // //             textAlign: TextAlign.center,
// // // //           ),
// // // //           // const SizedBox(height: 32),
// // // //           // BenoButton(onPressed: () {}, text: 'Register Now'),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
