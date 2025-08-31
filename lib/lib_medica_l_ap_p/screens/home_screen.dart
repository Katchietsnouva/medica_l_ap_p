import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/common/responsive_footer.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/system_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/selection_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/summary_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/payment_details_form.dart'; // ADD THIS IMPORT
import 'dart:ui';
// import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _formSectionKey = GlobalKey();
  final GlobalKey _paymentFormKey = GlobalKey();
  final GlobalKey _detailsSectionKey =
      GlobalKey(); // Add key for details section
  final GlobalKey _coverAmountSectionKey = GlobalKey(); // Add key for cover

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

  void _scrollToDetailsSection() {
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

  void _scrollToPaymentForm() {
    // We add a small delay to allow the widget to build before we scroll to it
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _paymentFormKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
          alignment: 0.1, // Aligns it near the top of the viewport
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

    return Scaffold(
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
            //
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(context),
            ),
          ),

          // The form content, now wrapped in a Sliver
          SliverToBoxAdapter(
            child: Container(
              key: _formSectionKey,
              // color: AppTheme.backgroundColor,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Who do you want to cover?",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Select a plan that's right for you.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: ConstrainedBox(
                        //         // SizedBox(
                        //         // height: 200,
                        //         constraints: const BoxConstraints(
                        //             minHeight: 100, maxHeight: 120),
                        //         child: SelectionCard(
                        //           icon: Icons.person_outline,
                        //           title: "Me",
                        //           isSelected: provider.selectedCoverType ==
                        //               CoverType.me,
                        //           onTap: () {
                        //             provider.selectCoverType(CoverType.me);
                        //             provider.showDetailsSection(
                        //                 _scrollToDetailsSection);
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 16),
                        //     Expanded(
                        //       child: ConstrainedBox(
                        //         // SizedBox(
                        //         // height: 200,
                        //         constraints: const BoxConstraints(
                        //             minHeight: 100, maxHeight: 120),
                        //         child: SelectionCard(
                        //           icon: Icons.group_outlined,
                        //           title: "Me & Spouse",
                        //           isSelected: provider.selectedCoverType ==
                        //               CoverType.spouse,
                        //           onTap: () {
                        //             provider.selectCoverType(CoverType.spouse);
                        //             provider.showDetailsSection(
                        //                 _scrollToDetailsSection);
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 16),
                        //     Container(
                        //       child: ConstrainedBox(
                        //         // SizedBox(
                        //         // height: 200,
                        //         constraints: const BoxConstraints(
                        //             minHeight: 100, maxHeight: 120),
                        //         child: SelectionCard(
                        //           icon: Icons.family_restroom_outlined,
                        //           title: "My Family",
                        //           isSelected: provider.selectedCoverType ==
                        //               CoverType.family,
                        //           onTap: () {
                        //             provider.selectCoverType(CoverType.family);
                        //             provider.showDetailsSection(
                        //                 _scrollToDetailsSection);
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            SelectionCard(
                              // minHeight: 150, // example minHeight if you want
                              icon: Icons.person_outline,
                              title: "Me",
                              isSelected:
                                  provider.selectedCoverType == CoverType.me,
                              onTap: () {
                                provider.selectCoverType(CoverType.me);
                                provider.showDetailsSection(
                                  _scrollToDetailsSection,
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            SelectionCard(
                              // minHeight: 150, // example minHeight if you want
                              icon: Icons.group_outlined,
                              title: "Me & Spouse",
                              isSelected:
                                  provider.selectedCoverType ==
                                  CoverType.spouse,
                              onTap: () {
                                provider.selectCoverType(CoverType.spouse);
                                provider.showDetailsSection(
                                  _scrollToDetailsSection,
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            SelectionCard(
                              // minHeight: 150, // example minHeight if you want
                              icon: Icons.family_restroom_outlined,
                              title: "My Family",
                              isSelected:
                                  provider.selectedCoverType ==
                                  CoverType.family,
                              onTap: () {
                                provider.selectCoverType(CoverType.family);
                                provider.showDetailsSection(
                                  _scrollToDetailsSection,
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        _buildAnimatedSection(
                          isVisible: provider.isDetailsSectionVisible,
                          child: _buildDetailsSection(context, provider),
                        ),
                        _buildAnimatedSection(
                          isVisible: provider.isCoverAmountSectionVisible,
                          child: _buildCoverAmountSection(context, provider),
                        ),
                        const SizedBox(height: 24),
                        // const SummaryCard(),
                        SummaryCard(onProceedToPayment: _scrollToPaymentForm),
                        const SizedBox(height: 24),

                        // ADD THIS SECTION to display the payment form
                        _buildAnimatedSection(
                          isVisible: provider.isPaymentFormVisible,
                          child: Container(
                            key: _paymentFormKey, // Assign the key here
                            child: const PaymentDetailsForm(),
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sliv

          // FlexibleSpaceBar(
          //   background: ResponsiveFooter(),
          // ),
          // inside your CustomScrollView (home_screen.dart)
          SliverToBoxAdapter(child: const ResponsiveFooter()),
        ],
      ),
    );
  }

  // The new Hero Section Widget
  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image.asset(
              //   'https://via.placeholder.com/800?text=Royal+Med+Hero',
              //   fit: BoxFit.cover,
              //   color: Colors.black.withOpacity(0.4),
              //   colorBlendMode: BlendMode.darken,
              // ),
              Image(
                image: AssetImage('assets/medica_l_ap_p/images/hero_image.png'),
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.2),
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppTheme.primaryColor.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Protect What Matters Most',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  blurRadius: 8.0,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Choose a tailored medical cover plan for you, your spouse, or your entire family with Royal Med.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontSize: 18,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          _scrollController.animateTo(
                            MediaQuery.of(context).size.height,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          'Get Cover Now',
                          // style:
                          //     Theme.of(context).textTheme.labelLarge?.copyWith(
                          //           fontSize: 18,
                          //         ),
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: const Duration(milliseconds: 600)),
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildDetailsSection(BuildContext context, AppProvider provider) {
    return Column(
      key: _detailsSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40),
        Text(
          "Personal Details",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        DobPickerField(
          label: "Your Date of Birth",
          selectedDate: provider.myDob,
          onDateSelected: (date) => provider.setMyDob(date),
        ),
        if (provider.selectedCoverType == CoverType.spouse ||
            provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 16),
          DobPickerField(
            label: "Spouse's Date of Birth",
            selectedDate: provider.spouseDob,
            onDateSelected: (date) => provider.setSpouseDob(date),
          ),
        ],
        if (provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: "Number of Children",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.secondaryColor,
                  width: 2,
                ),
              ),
              labelStyle: const TextStyle(color: AppTheme.subtleTextColor),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            value: provider.childCount == 0 ? null : provider.childCount,
            hint: const Text("Select count"),
            items: List.generate(10, (index) => index + 1)
                .map(
                  (count) =>
                      DropdownMenuItem(value: count, child: Text("$count")),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) provider.setChildCount(value);
              provider.showCoverAmountSection(_scrollToCoverAmountSection);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildCoverAmountSection(BuildContext context, AppProvider provider) {
    return Column(
      key: _coverAmountSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40),
        Text(
          "Select Cover Amount",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CoverAmountCard(
              amount: 500000,
              isSelected: provider.selectedCoverAmount == 500000,
              onTap: () {
                provider.selectCoverAmount(500000);
                provider.showCoverAmountSection(_scrollToCoverAmountSection);
              },
            ),
            const SizedBox(width: 16),
            CoverAmountCard(
              amount: 1000000,
              isSelected: provider.selectedCoverAmount == 1000000,
              onTap: () {
                provider.selectCoverAmount(1000000);
                provider.showCoverAmountSection(_scrollToCoverAmountSection);
              },
            ),
            const SizedBox(width: 16),
            CoverAmountCard(
              amount: 2000000,
              isSelected: provider.selectedCoverAmount == 2000000,
              onTap: () {
                provider.selectCoverAmount(2000000);
                provider.showCoverAmountSection(_scrollToCoverAmountSection);
              },
            ),
          ],
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:broka/lib_medica_l_ap_p/lib/providers/app_provider.dart';
// import 'package:broka/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// import 'package:broka/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
// import 'package:broka/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
// import 'package:broka/lib_medica_l_ap_p/widgets/selection_card.dart';
// import 'package:broka/lib_medica_l_ap_p/widgets/summary_card.dart';
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
//                         isVisible: provider.isDetailsSectionVisible,
//                         child: _buildDetailsSection(context, provider),
//                       ),
//                       _buildAnimatedSection(
//                         isVisible: provider.isCoverAmountSectionVisible,
//                         child: _buildCoverAmountSection(context, provider),
//                       ),
//                       const SizedBox(height: 24),
//                       _buildAnimatedSection(
//                         isVisible: provider.isCoverAmountSectionVisible,
//                         child: const SummaryCard(),
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

//   Widget _buildDetailsSection(BuildContext context, AppProvider provider) {
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

//   Widget _buildCoverAmountSection(BuildContext context, AppProvider provider) {
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
// // import 'package:broka/lib_medica_l_ap_p/lib/providers/app_provider.dart';
// // import 'package:broka/lib_medica_l_ap_p/lib/utils/app_theme.dart';
// // import 'package:broka/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
// // import 'package:broka/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
// // import 'package:broka/lib_medica_l_ap_p/widgets/selection_card.dart';
// // import 'package:broka/lib_medica_l_ap_p/widgets/summary_card.dart';

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
// //                 isVisible: provider.isDetailsSectionVisible,
// //                 child: _buildDetailsSection(context, provider),
// //               ),
// //               _buildAnimatedSection(
// //                 isVisible: provider.isCoverAmountSectionVisible,
// //                 child: _buildCoverAmountSection(context, provider),
// //               ),
// //               const SizedBox(height: 24),
// //               const SummaryCard(),
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

// //   Widget _buildDetailsSection(BuildContext context, AppProvider provider) {
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

// //   Widget _buildCoverAmountSection(BuildContext context, AppProvider provider) {
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
