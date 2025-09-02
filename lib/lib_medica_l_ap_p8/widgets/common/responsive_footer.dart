// lib/widgets/responsive_footer.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResponsiveFooter extends StatelessWidget {
  const ResponsiveFooter({super.key});

  // A constant for the dark background color for easy reuse
  static const Color footerColor = Color(0xFF1a1a1a);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: footerColor,
      // Increased vertical padding for more space
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 768) {
            // Mobile layout: Stack vertically
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactSection(context),
                const SizedBox(height: 32), // Increased space
                _buildVisitSection(context),
              ],
            );
          } else {
            // Desktop layout: Center the content with a max width
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 1200), // Max width for content
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactSection(context)),
                    const SizedBox(width: 32), // Increased space
                    Expanded(child: _buildVisitSection(context)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method for the "Contact Us" column
  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconText(
          context,
          icon: Icons.email,
          title: 'Write to Us',
          mainText: 'insure@royalmed.com',
          subText: 'AVAILABLE 24/7',
        ),
        const SizedBox(height: 24), // Increased space
        _buildIconText(
          context,
          icon: Icons.phone,
          title: 'Call Us',
          mainText: '+254 718 917211',
          subText: 'Waiting for your call...',
        ),
      ],
    );
  }

  // Helper method for the "Visit Us" column
  Widget _buildVisitSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconText(
          context,
          icon: Icons.location_on,
          title: 'Visit Us',
          mainText: '123, Westlands, Nairobi',
          subText: 'VIEW MAP',
        ),
        const SizedBox(height: 24), // Increased space
        _buildIconText(
          context,
          icon: Icons.chat,
          title: 'Follow Us',
          mainText: 'OUR SOCIAL MEDIA',
          subText: '', // Subtext is optional
          showSocialIcons: true,
        ),
      ],
    );
  }

  // The core component for each icon-text group, now bigger and better styled
  Widget _buildIconText(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String mainText,
    required String subText,
    bool showSocialIcons = false,
  }) {
    // Using theme for text styles is more scalable
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          radius: 28, // Bigger radius
          child: Icon(icon, color: Colors.white, size: 26), // Bigger icon
        ),
        const SizedBox(width: 16), // Increased space
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                mainText,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              if (subText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    subText.toUpperCase(), // Made uppercase for style
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey[400],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              if (showSocialIcons)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      _buildSocialIcon(FontAwesomeIcons.facebookF, 'Facebook'),
                      const SizedBox(width: 16),
                      _buildSocialIcon(FontAwesomeIcons.twitter, 'Twitter'),
                      const SizedBox(width: 16),
                      _buildSocialIcon(FontAwesomeIcons.instagram, 'Instagram'),
                      const SizedBox(width: 16),
                      _buildSocialIcon(FontAwesomeIcons.linkedinIn, 'LinkedIn'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper for creating interactive social icons
  Widget _buildSocialIcon(IconData icon, String tooltip) {
    return IconButton(
      icon: FaIcon(icon, color: Colors.white, size: 22), // Bigger icon
      onPressed: () {
        // Add your navigation logic here, e.g., using url_launcher
      },
      tooltip: tooltip,
      splashRadius: 24,
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ResponsiveFooter extends StatelessWidget {
//   const ResponsiveFooter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final isMobile = constraints.maxWidth < 800;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Get In Touch',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: 48),

//               // Main Grid
//               Flex(
//                 direction: isMobile ? Axis.vertical : Axis.horizontal,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Left Column: Contact Info
//                   Expanded(
//                     flex: 2,
//                     child: Wrap(
//                       runSpacing: 24,
//                       spacing: 32,
//                       children: [
//                         _contactTile(
//                           icon: Icons.edit,
//                           title: 'Write to Us',
//                           content: 'admin@digi.africa',
//                           subtext: 'Available 24/7',
//                         ),
//                         _contactTile(
//                           icon: Icons.phone_android,
//                           title: 'Call Us',
//                           content: '+254 722 211711',
//                           subtext: 'Sylvia is waiting',
//                         ),
//                         _contactTile(
//                           icon: Icons.location_on,
//                           title: 'Visit Us',
//                           content: 'The Mvuli, Mvuli Road',
//                           subtext: 'View Map',
//                         ),
//                         _contactTile(
//                           icon: Icons.chat_bubble_outline,
//                           title: 'Follow Us',
//                           content: 'Our Social Media',
//                           subtext: '',
//                           customWidget: Row(
//                             children: [
//                               _socialIcon(FontAwesomeIcons.facebookF),
//                               _socialIcon(FontAwesomeIcons.instagram),
//                               _socialIcon(FontAwesomeIcons.linkedinIn),
//                               _socialIcon(FontAwesomeIcons.xTwitter),
//                               _socialIcon(FontAwesomeIcons.whatsapp),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 32),

//                   // Right Column: Image
//                   if (!isMobile)
//                     Expanded(
//                       flex: 1,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(200),
//                         child: Image.asset(
//                           'assets/images/mvuli.png', // Replace with your asset
//                           height: 250,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _contactTile({
//     required IconData icon,
//     required String title,
//     required String content,
//     required String subtext,
//     Widget? customWidget,
//   }) {
//     return SizedBox(
//       width: 280,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.red[900],
//             child: Icon(icon, color: Colors.white),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16)),
//                 const SizedBox(height: 4),
//                 Text(
//                   content,
//                   style: const TextStyle(
//                       fontSize: 14, color: Colors.black54, height: 1.4),
//                 ),
//                 const SizedBox(height: 4),
//                 if (customWidget != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: customWidget,
//                   )
//                 else if (subtext.isNotEmpty)
//                   Text(
//                     subtext.toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _socialIcon(IconData icon) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         color: Colors.white,
//       ),
//       child: Icon(icon, size: 16),
//     );
//   }
// }

// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// // // import 'package:royal_med/utils/app_theme.dart';

// // class ResponsiveFooter extends StatelessWidget {
// //   const ResponsiveFooter({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         bool isWide = constraints.maxWidth > 600;
// //         return Container(
// //           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
// //           // color: AppTheme.primaryColor.withOpacity(0.7),
// //           // color: AppTheme.textColor.withOpacity(0.7),
// //           color: Colors.black,
// //           child:
// //               isWide ? _buildWideFooter(context) : _buildNarrowFooter(context),
// //         );
// //       },
// //     );
// //   }

// //   /// Wide screen footer (desktop / tablet)
// //   Widget _buildWideFooter(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _buildBrandSection(),
// //         // _buildQuickLinks(),
// //         _buildContactInfo(),
// //       ],
// //     );
// //   }

// //   /// Narrow screen footer (mobile)
// //   Widget _buildNarrowFooter(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _buildBrandSection(),
// //         const SizedBox(height: 24),
// //         // _buildQuickLinks(),
// //         const SizedBox(height: 24),
// //         _buildContactInfo(),
// //       ],
// //     );
// //   }

// //   /// Branding / About section
// //   Widget _buildBrandSection() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         // Text(
// //         //   "Royal Med",
// //         //   style: TextStyle(
// //         //     color: AppTheme.primaryColor,
// //         //     fontSize: 22,
// //         //     fontWeight: FontWeight.bold,
// //         //   ),
// //         // ),
// //         Container(
// //           margin: const EdgeInsets.symmetric(horizontal: 10), // left/right only
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(40), // fully rounded corners
// //             child: BackdropFilter(
// //               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
// //               child: Container(
// //                 height: 50, // exact container height
// //                 width: 200, // exact container width
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.4), // frosted glass effect
// //                   borderRadius: BorderRadius.circular(40),
// //                   border: Border.all(
// //                     color: Colors.white.withOpacity(0.3),
// //                     width: 1.2,
// //                   ),
// //                 ),
// //                 child: Center(
// //                   child: Image.asset(
// //                     'assets/medica_l_ap_p/images/logo.png',
// //                     fit: BoxFit.contain, // scales logo inside container
// //                     height: 72, // optional: match image height
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         SizedBox(
// //           width: 250,
// //           child: Text(
// //             "Your peace of mind is our priority.",
// //             style: TextStyle(
// //               color: Colors.white.withOpacity(0.8),
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               height: 1.4,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   /// Quick Links section
// //   Widget _buildQuickLinks() {
// //     final links = [
// //       "My Cover",
// //       "Quote Summary",
// //       "Pay Later",
// //       "Dashboard",
// //       "My Payments",
// //       "Contact Us",
// //     ];

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Quick Links",
// //           style: TextStyle(
// //             color: AppTheme.primaryColor,
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         for (var link in links)
// //           Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 4),
// //             child: Text(
// //               link,
// //               style: TextStyle(
// //                 color: Colors.white.withOpacity(0.8),
// //                 fontSize: 14,
// //               ),
// //             ),
// //           ),
// //       ],
// //     );
// //   }

// //   /// Contact Info section
// //   Widget _buildContactInfo() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Get In Touch",
// //           style: TextStyle(
// //             color: AppTheme.primaryColor,
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Icon(
// //               Icons.email_outlined,
// //               color: Colors.white.withOpacity(0.8),
// //               size: 20,
// //             ),
// //             const SizedBox(width: 8),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Write to Us",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Text(
// //                   "admin@digi.africa",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 Text(
// //                   "available 24/7",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.6),
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Icon(
// //               Icons.phone_outlined,
// //               color: Colors.white.withOpacity(0.8),
// //               size: 20,
// //             ),
// //             const SizedBox(width: 8),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Call Us",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Text(
// //                   "+254 722 211711",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 Text(
// //                   "Sylvia is Waiting",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.6),
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Icon(
// //               Icons.location_on_outlined,
// //               color: Colors.white.withOpacity(0.8),
// //               size: 20,
// //             ),
// //             const SizedBox(width: 8),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Visit Us",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Text(
// //                   "The Mvuli, Mvuli Road",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 GestureDetector(
// //                   onTap: () {
// //                     // TODO: Implement map link (e.g., open Google Maps)
// //                   },
// //                   child: Text(
// //                     "view map",
// //                     style: TextStyle(
// //                       color: AppTheme.secondaryColor,
// //                       fontSize: 12,
// //                       decoration: TextDecoration.underline,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         Row(
// //           children: [
// //             Icon(
// //               Icons.share_outlined,
// //               color: Colors.white.withOpacity(0.8),
// //               size: 20,
// //             ),
// //             const SizedBox(width: 8),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Follow Us",
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.8),
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Row(
// //                   children: [
// //                     // Placeholder for social media icons
// //                     IconButton(
// //                       icon: Icon(
// //                         Icons.facebook,
// //                         color: Colors.white.withOpacity(0.8),
// //                         size: 20,
// //                       ),
// //                       onPressed: () {
// //                         // TODO: Implement social media link
// //                       },
// //                     ),
// //                     IconButton(
// //                       icon: Icon(
// //                         Icons.abc,
// //                         color: Colors.white.withOpacity(0.8),
// //                         size: 20,
// //                       ),
// //                       onPressed: () {
// //                         // TODO: Implement social media link
// //                       },
// //                     ),
// //                     IconButton(
// //                       icon: Icon(
// //                         Icons.abc_rounded,
// //                         color: Colors.white.withOpacity(0.8),
// //                         size: 20,
// //                       ),
// //                       onPressed: () {
// //                         // TODO: Implement social media link
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // // lib/widgets/common/responsive_footer.dart
// // // import 'dart:ui';

// // // import 'package:flutter/material.dart';
// // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
// // // // import 'package:royal_med/utils/app_theme.dart';

// // // class ResponsiveFooter extends StatelessWidget {
// // //   const ResponsiveFooter({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return LayoutBuilder(
// // //       builder: (context, constraints) {
// // //         bool isWide = constraints.maxWidth > 600;
// // //         return Container(
// // //           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
// // //           // color: AppTheme.primaryColor.withOpacity(0.7),
// // //           // color: AppTheme.textColor.withOpacity(0.7),
// // //           color: Colors.black,
// // //           child:
// // //               isWide ? _buildWideFooter(context) : _buildNarrowFooter(context),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   /// Wide screen footer (desktop / tablet)
// // //   Widget _buildWideFooter(BuildContext context) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         _buildBrandSection(),
// // //         _buildQuickLinks(),
// // //         _buildContactInfo(),
// // //       ],
// // //     );
// // //   }

// // //   /// Narrow screen footer (mobile)
// // //   Widget _buildNarrowFooter(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         _buildBrandSection(),
// // //         const SizedBox(height: 24),
// // //         _buildQuickLinks(),
// // //         const SizedBox(height: 24),
// // //         _buildContactInfo(),
// // //       ],
// // //     );
// // //   }

// // //   /// Branding / About section
// // //   Widget _buildBrandSection() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // Text(
// // //         //   "Royal Med",
// // //         //   style: TextStyle(
// // //         //     color: AppTheme.primaryColor,
// // //         //     fontSize: 22,
// // //         //     fontWeight: FontWeight.bold,
// // //         //   ),
// // //         // ),
// // //         Container(
// // //           margin: const EdgeInsets.symmetric(horizontal: 10), // left/right only
// // //           child: ClipRRect(
// // //             borderRadius: BorderRadius.circular(40), // fully rounded corners
// // //             child: BackdropFilter(
// // //               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
// // //               child: Container(
// // //                 height: 50, // exact container height
// // //                 width: 200, // exact container width
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.white.withOpacity(0.4), // frosted glass effect
// // //                   borderRadius: BorderRadius.circular(40),
// // //                   border: Border.all(
// // //                     color: Colors.white.withOpacity(0.3),
// // //                     width: 1.2,
// // //                   ),
// // //                 ),
// // //                 child: Center(
// // //                   child: Image.asset(
// // //                     'assets/medica_l_ap_p/images/logo.png',
// // //                     fit: BoxFit.contain, // scales logo inside container
// // //                     height: 72, // optional: match image height
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),

// // //         const SizedBox(height: 12),
// // //         SizedBox(
// // //           width: 250,
// // //           child: Text(
// // //             "Your trusted partner in affordable medical cover solutions. "
// // //             "Protect yourself and your family with flexible health plans.",
// // //             style: TextStyle(
// // //               color: Colors.white.withOpacity(0.8),
// // //               fontSize: 14,
// // //               height: 1.4,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   /// Quick Links section
// // //   Widget _buildQuickLinks() {
// // //     final links = [
// // //       "My Cover",
// // //       "Quote Summary",
// // //       "Pay Later",
// // //       "Dashboard",
// // //       "My Payments",
// // //       "Contact Us",
// // //     ];

// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           "Quick Links",
// // //           style: TextStyle(
// // //             color: AppTheme.primaryColor,
// // //             fontSize: 18,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         for (var link in links)
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(vertical: 4),
// // //             child: Text(
// // //               link,
// // //               style: TextStyle(
// // //                 color: Colors.white.withOpacity(0.8),
// // //                 fontSize: 14,
// // //               ),
// // //             ),
// // //           ),
// // //       ],
// // //     );
// // //   }

// // //   /// Contact Info section
// // //   Widget _buildContactInfo() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           "Contact Us",
// // //           style: TextStyle(
// // //             color: AppTheme.primaryColor,
// // //             fontSize: 18,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         Text(
// // //           "Email: support@royalmed.com",
// // //           style: TextStyle(
// // //             color: Colors.white.withOpacity(0.8),
// // //             fontSize: 14,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Text(
// // //           "Phone: +254 700 000 000",
// // //           style: TextStyle(
// // //             color: Colors.white.withOpacity(0.8),
// // //             fontSize: 14,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Text(
// // //           "Address: Nairobi, Kenya",
// // //           style: TextStyle(
// // //             color: Colors.white.withOpacity(0.8),
// // //             fontSize: 14,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }

// // // // // lib/widgets/common/responsive_footer.dart
// // // // import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// // // // import 'package:flutter/material.dart';
// // // // // import 'package:royal_med/utils/app_theme.dart';

// // // // class ResponsiveFooter extends StatelessWidget {
// // // //   const ResponsiveFooter({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return LayoutBuilder(
// // // //       builder: (context, constraints) {
// // // //         bool isWide = constraints.maxWidth > 600;
// // // //         return Container(
// // // //           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
// // // //           color: AppTheme.textColor.withOpacity(0.9),
// // // //           child:
// // // //               isWide ? _buildWideFooter(context) : _buildNarrowFooter(context),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   Widget _buildWideFooter(BuildContext context) {
// // // //     // ... Implementation for wide screen footer
// // // //   }

// // // //   Widget _buildNarrowFooter(BuildContext context) {
// // // //     // ... Implementation for narrow screen footer
// // // //   }
// // // // }
