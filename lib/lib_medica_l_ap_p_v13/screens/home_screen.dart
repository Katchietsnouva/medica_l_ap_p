// lib/screens/home_screen.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/cover_amount_cards.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/cover_plans_cards.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/family_cover_cards.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/hero_section_widget.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/common/responsive_footer.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/mpesa_payment_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/mobile_nav_panel.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/system_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/quote_summary_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/person_or_family_details_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _formSectionKey = GlobalKey();
  final GlobalKey _paymentFormKey = GlobalKey();
  final GlobalKey _mpesapaymentFormKey = GlobalKey();
  final GlobalKey _detailsSectionKey = GlobalKey();
  final GlobalKey _coverAmountSectionKey = GlobalKey();
  final GlobalKey _coverPlanCardsKey = GlobalKey();

  void _scrollToForm() {
    final context = _formSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToPersonOrFamilyDetailsCard() {
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _detailsSectionKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.5,
        );
      }
    });
  }

  void _scrollToCoverAmountSection() {
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _coverAmountSectionKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  void _scrollToCoverPlansCards() {
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _coverPlanCardsKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  void _scrollToQuoteSummaryCard() {
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _paymentFormKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  void _scrollToMpesaComponent() {
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _mpesapaymentFormKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isSmallScreen = screenWidth < 1200;

    return Scaffold(
      endDrawer: isSmallScreen ? const MobileNavPanel() : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // RoyalHeader(
          //   onScrollToRegister: () {},
          //   // onLogout: auth.logout,
          //   // currentUser: auth.currentUser!.formData.personalDetails,
          //   // onScrollToRegister: onScrollToRegister ?? () {},
          // ),
          SliverAppBar(
            // RoyalHeader(),
            leading: null,
            title: RoyalHeader(
              onScrollToRegister: () {},
              // onLogout: auth.logout,
              // currentUser: auth.currentUser!.formData.personalDetails,
              // onScrollToRegister: onScrollToRegister ?? () {},
            ),
            expandedHeight: screenHeight * 0.6,
            pinned: true,
            floating: true,
            backgroundColor: AppTheme.surfaceColor,
            elevation: 4,
            flexibleSpace: FlexibleSpaceBar(
              // background: _buildHeroSection(context),
              background: HeroSectionWidget(
                scrollController: _scrollController,
              ),
            ),
          ),

          // The form content, now wrapped in a Sliver
          SliverToBoxAdapter(
            child: Container(
              key: _formSectionKey,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FamilyCoverCards(
                            provider: provider,
                            ScrollToPersonOrFamilyDetailsCard:
                                _scrollToPersonOrFamilyDetailsCard),
                        const SizedBox(height: 24),
                        _buildAnimatedSection(
                          isVisible:
                              provider.isPersonOrFamilyDetailsCardVisible,
                          // child: _buildPersonalDetailsCard(context, provider),
                          child: PersonOrFamilyDetailsCard(
                            provider: provider,
                            onScrollToCoverAmountsCard:
                                _scrollToCoverAmountSection,
                            detailsSectionKey: _detailsSectionKey,
                            // wont scroll to personal details if like this
                            // detailsSectionKey: _coverAmountSectionKey,
                          ),
                        ),
                        _buildAnimatedSection(
                          isVisible: provider.isCoverAmountCardVisible,
                          // child: _buildCoverAmountCards(context, provider),
                          child: CoverAmountCards(
                            provider: provider,
                            onScrollToPlanCards: _scrollToCoverPlansCards,
                            coverAmountSectionKey: _coverAmountSectionKey,
                          ),
                        ),
                        _buildAnimatedSection(
                          isVisible: provider.isCoverPlansCardVisible,
                          // child: _buildCoverAmountCards(context, provider),
                          child: CoverPlansCard(
                            provider: provider,
                            // payload: provider.buildPlanPayload(),
                            onScrollToQuoteSummaryCard:
                                _scrollToCoverPlansCards,
                            // onProceedToPayment: () {},
                            coverPlanCardsKey: _coverPlanCardsKey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        QuoteSummaryCard(
                            onProceedToPayment: _scrollToQuoteSummaryCard),
                        const SizedBox(height: 24),
                        _buildAnimatedSection(
                          isVisible: provider.isPaymentFormVisible,
                          child: Container(
                            key: _paymentFormKey,
                            child: ContactInfoCard(
                              provider: provider,
                              onSuccessScrollToMpesa: _scrollToMpesaComponent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildAnimatedSection(
                          isVisible: provider.isMpesaComponentVisible,
                          // child: Container(
                          // key: _mpesapaymentFormKey,
                          child: MpesaPaymentCard(
                            provider: provider,
                            onScrollTo____: () {},
                          ),
                          // ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // FlexibleSpaceBar(
          //   background: ResponsiveFooter(),
          // ),
          // inside your CustomScrollView (home_screen.dart)
          SliverToBoxAdapter(child: ResponsiveFooter()),
        ],
      ),
    );
  }

  // Helper methods (no changes needed here)
  Widget _buildAnimatedSection({
    required bool isVisible,
    required Widget child,
  }) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: isVisible ? child : const SizedBox.shrink(),
    );
  }
}

// class _buildHeroSection {
// }

// Widget _buildHeroSection(BuildContext context) {
//   return HeroSectionWidget(
//     onGetCoverPressed: () {
//       _scrollController.animateTo(
//         MediaQuery.of(context).size.height,
//         duration: const Duration(milliseconds: 800),
//         curve: Curves.easeInOut,
//       );
//     },
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/providers/app_provider.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/selection_card.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/summary_card.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AppProvider>();
//     final ScrollController scrollController = ScrollController();

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(72.0),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppTheme.primaryColor.withOpacity(0.9),
//                   AppTheme.primaryColor.withOpacity(0.6),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           title: Row(
//             children: [
//               // Image.network(
//               //   'https://via.placeholder.com/40?text=RM',
//               //   height: 40,
//               //   width: 40,
//               // ),
//               Image(
//                 image: AssetImage('assets/medica_l_ap_p/images/hero_image.png'),
//                 fit: BoxFit.cover,
//                 color: Colors.black.withOpacity(0.4),
//                 colorBlendMode: BlendMode.darken,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Royal Med',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//               ),
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: TextButton(
//                 onPressed: () {
//                   // Placeholder for future profile or menu action
//                 },
//                 child: Text(
//                   'Profile',
//                   style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                         color: Colors.white70,
//                       ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         controller: scrollController,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Hero Section
//             SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Image.asset(
//                   //   'https://via.placeholder.com/800?text=Royal+Med+Hero',
//                   //   fit: BoxFit.cover,
//                   //   color: Colors.black.withOpacity(0.4),
//                   //   colorBlendMode: BlendMode.darken,
//                   // ),
//                   Image(
//                     image: AssetImage(
//                         'assets/medica_l_ap_p/images/hero_image.png'),
//                     fit: BoxFit.cover,
//                     color: Colors.black.withOpacity(0.4),
//                     colorBlendMode: BlendMode.darken,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           AppTheme.primaryColor.withOpacity(0.3),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 800),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Protect What Matters Most',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge
//                                 ?.copyWith(
//                               color: Colors.white,
//                               fontSize: 36,
//                               fontWeight: FontWeight.w700,
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 8.0,
//                                   color: Colors.black.withOpacity(0.3),
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Choose a tailored medical cover plan for you, your spouse, or your entire family with Royal Med.',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                   color: Colors.white70,
//                                   fontSize: 18,
//                                   height: 1.6,
//                                 ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 32),
//                           ElevatedButton(
//                             onPressed: () {
//                               scrollController.animateTo(
//                                 MediaQuery.of(context).size.height,
//                                 duration: const Duration(milliseconds: 800),
//                                 curve: Curves.easeInOut,
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppTheme.secondaryColor,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 32,
//                                 vertical: 16,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               elevation: 4,
//                             ),
//                             child: Text(
//                               'Get Cover Now',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelLarge
//                                   ?.copyWith(
//                                     fontSize: 18,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       )
//                           .animate()
//                           .fadeIn(duration: const Duration(milliseconds: 600)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Main Content
//             Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 800),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Who do you want to cover?",
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Select a plan that's right for you.",
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                       const SizedBox(height: 24),
//                       LayoutBuilder(
//                         builder: (context, constraints) {
//                           return Wrap(
//                             spacing: 16,
//                             runSpacing: 16,
//                             children: [
//                               SelectionCard(
//                                 icon: Icons.person_outline,
//                                 title: "Me",
//                                 isSelected:
//                                     provider.selectedCoverType == CoverType.me,
//                                 onTap: () =>
//                                     provider.selectCoverType(CoverType.me),
//                                 // width: constraints.maxWidth > 600
//                                 //     ? (constraints.maxWidth - 32) / 3
//                                 //     : constraints.maxWidth,
//                               ),
//                               SelectionCard(
//                                 icon: Icons.group_outlined,
//                                 title: "Me & Spouse",
//                                 isSelected: provider.selectedCoverType ==
//                                     CoverType.spouse,
//                                 onTap: () =>
//                                     provider.selectCoverType(CoverType.spouse),
//                                 // width: constraints.maxWidth > 600
//                                 //     ? (constraints.maxWidth - 32) / 3
//                                 //     : constraints.maxWidth,
//                               ),
//                               SelectionCard(
//                                 icon: Icons.family_restroom_outlined,
//                                 title: "My Family",
//                                 isSelected: provider.selectedCoverType ==
//                                     CoverType.family,
//                                 onTap: () =>
//                                     provider.selectCoverType(CoverType.family),
//                                 // width: constraints.maxWidth > 600
//                                 //     ? (constraints.maxWidth - 32) / 3
//                                 //     : constraints.maxWidth,
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 24),
//                       _buildAnimatedSection(
//                         isVisible: provider.isPersonOrFamilyDetailsCardVisible,
//                         child: _buildPersonalDetailsCard(context, provider),
//                       ),
//                       _buildAnimatedSection(
//                         isVisible: provider.isCoverAmountCardVisible,
//                         child: _buildCoverAmountCards(context, provider),
//                       ),
//                       const SizedBox(height: 24),
//                       _buildAnimatedSection(
//                         isVisible: provider.isCoverAmountCardVisible,
//                         child: const QuoteSummaryCard(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedSection({
//     required bool isVisible,
//     required Widget child,
//   }) {
//     return AnimatedSize(
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//       child: isVisible
//           ? child.animate().fadeIn(duration: const Duration(milliseconds: 400))
//           : const SizedBox.shrink(),
//     );
//   }

//   Widget _buildPersonalDetailsCard(BuildContext context, AppProvider provider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(height: 40),
//         Text(
//           "Personal Details",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: 16),
//         DobPickerField(
//           label: "Your Date of Birth",
//           selectedDate: provider.myDob,
//           onDateSelected: (date) => provider.setMyDob(date),
//         ),
//         if (provider.selectedCoverType == CoverType.spouse ||
//             provider.selectedCoverType == CoverType.family) ...[
//           const SizedBox(height: 16),
//           DobPickerField(
//             label: "Spouse's Date of Birth",
//             selectedDate: provider.spouseDob,
//             onDateSelected: (date) => provider.setSpouseDob(date),
//           ),
//         ],
//         if (provider.selectedCoverType == CoverType.family) ...[
//           const SizedBox(height: 16),
//           DropdownButtonFormField<int>(
//             decoration: InputDecoration(
//               labelText: "Number of Children",
//               labelStyle: const TextStyle(color: AppTheme.subtleTextColor),
//               filled: true,
//               fillColor: Colors.grey.shade50,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//             ),
//             value: provider.childCount == 0 ? null : provider.childCount,
//             hint: const Text("Select count"),
//             items: List.generate(10, (index) => index + 1)
//                 .map((count) =>
//                     DropdownMenuItem(value: count, child: Text("$count")))
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) provider.setChildCount(value);
//             },
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildCoverAmountCards(BuildContext context, AppProvider provider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(height: 40),
//         Text(
//           "Select Cover Amount",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: 16),
//         LayoutBuilder(
//           builder: (context, constraints) {
//             return Wrap(
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//                 CoverAmountCard(
//                   amount: 500000,
//                   isSelected: provider.selectedCoverAmount == 500000,
//                   onTap: () => provider.selectCoverAmount(500000),
//                   // width: constraints.maxWidth > 600
//                   //     ? (constraints.maxWidth - 32) / 3
//                   //     : constraints.maxWidth,
//                 ),
//                 CoverAmountCard(
//                   amount: 1000000,
//                   isSelected: provider.selectedCoverAmount == 1000000,
//                   onTap: () => provider.selectCoverAmount(1000000),
//                   // width: constraints.maxWidth > 600
//                   //     ? (constraints.maxWidth - 32) / 3
//                   //     : constraints.maxWidth,
//                 ),
//                 CoverAmountCard(
//                   amount: 2000000,
//                   isSelected: provider.selectedCoverAmount == 2000000,
//                   onTap: () => provider.selectCoverAmount(2000000),
//                   // width: constraints.maxWidth > 600
//                   //     ? (constraints.maxWidth - 32) / 3
//                   //     : constraints.maxWidth,
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
// // // lib/screens/home_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/providers/app_provider.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/selection_card.dart';
// // import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/summary_card.dart';

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<AppProvider>();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Royal Med',
// //             style: Theme.of(context).textTheme.headlineMedium),
// //         backgroundColor: AppTheme.surfaceColor,
// //         elevation: 1,
// //       ),
// //       body: Center(
// //         child: ConstrainedBox(
// //           constraints: const BoxConstraints(
// //               maxWidth: 800), // For large screen responsiveness
// //           child: ListView(
// //             padding: const EdgeInsets.all(24.0),
// //             children: [
// //               Text(
// //                 "Who do you want to cover?",
// //                 style: Theme.of(context).textTheme.headlineMedium,
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 "Select a plan that's right for you.",
// //                 style: Theme.of(context).textTheme.bodyMedium,
// //               ),
// //               const SizedBox(height: 24),
// //               Row(
// //                 children: [
// //                   SelectionCard(
// //                     icon: Icons.person_outline,
// //                     title: "Me",
// //                     isSelected: provider.selectedCoverType == CoverType.me,
// //                     onTap: () => provider.selectCoverType(CoverType.me),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   SelectionCard(
// //                     icon: Icons.group_outlined,
// //                     title: "Me & Spouse",
// //                     isSelected: provider.selectedCoverType == CoverType.spouse,
// //                     onTap: () => provider.selectCoverType(CoverType.spouse),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   SelectionCard(
// //                     icon: Icons.family_restroom_outlined,
// //                     title: "My Family",
// //                     isSelected: provider.selectedCoverType == CoverType.family,
// //                     onTap: () => provider.selectCoverType(CoverType.family),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 24),
// //               _buildAnimatedSection(
// //                 isVisible: provider.isPersonOrFamilyDetailsCardVisible,
// //                 child: _buildPersonalDetailsCard(context, provider),
// //               ),
// //               _buildAnimatedSection(
// //                 isVisible: provider.isCoverAmountCardVisible,
// //                 child: _buildCoverAmountCards(context, provider),
// //               ),
// //               const SizedBox(height: 24),
// //               const QuoteSummaryCard(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAnimatedSection(
// //       {required bool isVisible, required Widget child}) {
// //     return AnimatedSize(
// //       duration: const Duration(milliseconds: 400),
// //       curve: Curves.easeInOut,
// //       child: isVisible ? child : const SizedBox.shrink(),
// //     );
// //   }

// //   Widget _buildPersonalDetailsCard(BuildContext context, AppProvider provider) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Divider(height: 40),
// //         Text("Personal Details",
// //             style: Theme.of(context).textTheme.headlineMedium),
// //         const SizedBox(height: 16),
// //         DobPickerField(
// //           label: "Your Date of Birth",
// //           selectedDate: provider.myDob,
// //           onDateSelected: (date) => provider.setMyDob(date),
// //         ),
// //         if (provider.selectedCoverType == CoverType.spouse ||
// //             provider.selectedCoverType == CoverType.family) ...[
// //           const SizedBox(height: 16),
// //           DobPickerField(
// //             label: "Spouse's Date of Birth",
// //             selectedDate: provider.spouseDob,
// //             onDateSelected: (date) => provider.setSpouseDob(date),
// //           ),
// //         ],
// //         if (provider.selectedCoverType == CoverType.family) ...[
// //           const SizedBox(height: 16),
// //           DropdownButtonFormField<int>(
// //             decoration: InputDecoration(
// //               labelText: "Number of Children",
// //               labelStyle: const TextStyle(color: AppTheme.subtleTextColor),
// //               filled: true,
// //               fillColor: Colors.grey.shade50,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //                 borderSide: BorderSide(color: Colors.grey.shade300),
// //               ),
// //             ),
// //             value: provider.childCount == 0 ? null : provider.childCount,
// //             hint: const Text("Select count"),
// //             items: List.generate(10, (index) => index + 1)
// //                 .map((count) =>
// //                     DropdownMenuItem(value: count, child: Text("$count")))
// //                 .toList(),
// //             onChanged: (value) {
// //               if (value != null) provider.setChildCount(value);
// //             },
// //           ),
// //         ],
// //       ],
// //     );
// //   }

// //   Widget _buildCoverAmountCards(BuildContext context, AppProvider provider) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Divider(height: 40),
// //         Text("Select Cover Amount",
// //             style: Theme.of(context).textTheme.headlineMedium),
// //         const SizedBox(height: 16),
// //         Row(
// //           children: [
// //             CoverAmountCard(
// //               amount: 500000,
// //               isSelected: provider.selectedCoverAmount == 500000,
// //               onTap: () => provider.selectCoverAmount(500000),
// //             ),
// //             const SizedBox(width: 16),
// //             CoverAmountCard(
// //               amount: 1000000,
// //               isSelected: provider.selectedCoverAmount == 1000000,
// //               onTap: () => provider.selectCoverAmount(1000000),
// //             ),
// //             const SizedBox(width: 16),
// //             CoverAmountCard(
// //               amount: 2000000,
// //               isSelected: provider.selectedCoverAmount == 2000000,
// //               onTap: () => provider.selectCoverAmount(2000000),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }
