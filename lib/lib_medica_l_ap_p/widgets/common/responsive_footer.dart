// lib/widgets/common/responsive_footer.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// import 'package:royal_med/utils/app_theme.dart';

class ResponsiveFooter extends StatelessWidget {
  const ResponsiveFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 600;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          // color: AppTheme.primaryColor.withOpacity(0.7),
          // color: AppTheme.textColor.withOpacity(0.7),
          color: Colors.black,
          child:
              isWide ? _buildWideFooter(context) : _buildNarrowFooter(context),
        );
      },
    );
  }

  /// Wide screen footer (desktop / tablet)
  Widget _buildWideFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandSection(),
        _buildQuickLinks(),
        _buildContactInfo(),
      ],
    );
  }

  /// Narrow screen footer (mobile)
  Widget _buildNarrowFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandSection(),
        const SizedBox(height: 24),
        _buildQuickLinks(),
        const SizedBox(height: 24),
        _buildContactInfo(),
      ],
    );
  }

  /// Branding / About section
  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Royal Med",
        //   style: TextStyle(
        //     color: AppTheme.primaryColor,
        //     fontSize: 22,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10), // left/right only
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40), // fully rounded corners
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: 50, // exact container height
                width: 200, // exact container width
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4), // frosted glass effect
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/medica_l_ap_p/images/logo.png',
                    fit: BoxFit.contain, // scales logo inside container
                    height: 72, // optional: match image height
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
        SizedBox(
          width: 250,
          child: Text(
            "Your trusted partner in affordable medical cover solutions. "
            "Protect yourself and your family with flexible health plans.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  /// Quick Links section
  Widget _buildQuickLinks() {
    final links = [
      "My Cover",
      "Quote Summary",
      "Pay Later",
      "Dashboard",
      "My Payments",
      "Contact Us",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Links",
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (var link in links)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  /// Contact Info section
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Us",
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Email: support@royalmed.com",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Phone: +254 700 000 000",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Address: Nairobi, Kenya",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// // lib/widgets/common/responsive_footer.dart
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// import 'package:flutter/material.dart';
// // import 'package:royal_med/utils/app_theme.dart';

// class ResponsiveFooter extends StatelessWidget {
//   const ResponsiveFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isWide = constraints.maxWidth > 600;
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
//           color: AppTheme.textColor.withOpacity(0.9),
//           child:
//               isWide ? _buildWideFooter(context) : _buildNarrowFooter(context),
//         );
//       },
//     );
//   }

//   Widget _buildWideFooter(BuildContext context) {
//     // ... Implementation for wide screen footer
//   }

//   Widget _buildNarrowFooter(BuildContext context) {
//     // ... Implementation for narrow screen footer
//   }
// }
