// lib/widgets/cover_amount_cards.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart';
import 'package:provider/provider.dart';

class CoverAmountCards extends StatelessWidget {
  final AppProvider provider;
  final VoidCallback onScrollToPlanCards;
  final Key? coverAmountSectionKey;

  const CoverAmountCards({
    super.key,
    required this.provider,
    required this.onScrollToPlanCards,
    this.coverAmountSectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    Widget content;
    if (appProvider.isLoadingLimits) {
      content = const Center(child: CircularProgressIndicator());
    } else if (appProvider.limitsError != null) {
      content = Center(child: Text(appProvider.limitsError!));
    } else if (appProvider.medicalLimits.isEmpty) {
      content = const Center(child: Text('No cover amounts available.'));
    } else {
      final coverAmounts = appProvider.medicalLimits;

      Widget rowContent = Row(
        children: coverAmounts
            .asMap()
            .entries
            .map(
              (entry) => [
                Expanded(
                  child: CardAnimationLayout(
                    index: entry.key,
                    child: CoverAmountCard(
                      amount: entry.value['limit'] as int,
                      isSelected:
                          provider.selectedCoverAmount == entry.value['limit'],
                      onTap: () {
                        appProvider.selectCoverAmount(
                            context, entry.value['limit'] as int);
                        provider.showCoverPlansCard(onScrollToPlanCards);
                      },
                    ),
                  ),
                ),
                if (entry.key < coverAmounts.length - 1)
                  const SizedBox(width: 16),
              ],
            )
            .expand((element) => element)
            .toList(),
      );
      content = Column(
        key: coverAmountSectionKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 40),
          Text(
            "Select Cover Amount",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          rowContent,
        ],
      );
    }
    return content;
    // );
  }
}














// // lib/widgets/cover_amount_cards.dart
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart';
// import 'package:provider/provider.dart';
// class CoverAmountCards extends StatelessWidget {
//   final AppProvider provider;
//   final VoidCallback onScrollToPlanCards;
//   final Key? coverAmountSectionKey;

//   const CoverAmountCards({
//     super.key,
//     required this.provider,
//     required this.onScrollToPlanCards,
//     this.coverAmountSectionKey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: ContactInfoService.fetchMedicalLimits(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('Failed to load cover amounts.'));
//         }

//         final coverAmounts = snapshot.data!;

//         return Column(
//           key: coverAmountSectionKey,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Divider(height: 40),
//             Text(
//               "Select Cover Amount",
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: coverAmounts
//                   .asMap()
//                   .entries
//                   .map(
//                     (entry) => [
//                       Expanded(
//                         child: CardAnimationLayout(
//                           index: entry.key,
//                           child: CoverAmountCard(
//                             amount: entry.value['limit'] as int,
//                             isSelected: provider.selectedCoverAmount ==
//                                 entry.value['limit'],
//                             onTap: () {
//                               provider.selectCoverAmount(
//                                   entry.value['limit'] as int);
//                               provider.showCoverPlansCard(onScrollToPlanCards);
//                             },
//                           ),
//                         ),
//                       ),
//                       if (entry.key < coverAmounts.length - 1)
//                         const SizedBox(width: 16),
//                     ],
//                   )
//                   .expand((element) => element)
//                   .toList(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



// Expanded(
//               child: CardAnimationLayout(
//                 index: 0,
//                 bounce: true,
//                 child: CoverAmountCard(
//                   amount: 500000,
//                   isSelected: provider.selectedCoverAmount == 500000,
//                   onTap: () {
//                     provider.selectCoverAmount(500000);
//                     provider
//                         .showCoverAmountSection(onScrollToPlanCards);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: CardAnimationLayout(
//                 index: 1,
//                 child: CoverAmountCard(
//                   amount: 1000000,
//                   isSelected: provider.selectedCoverAmount == 1000000,
//                   onTap: () {
//                     provider.selectCoverAmount(1000000);
//                     provider
//                         .showCoverAmountSection(onScrollToPlanCards);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: CardAnimationLayout(
//                 index: 2,
//                 bounceX: true,
//                 child: CoverAmountCard(
//                   amount: 2000000,
//                   isSelected: provider.selectedCoverAmount == 2000000,
//                   onTap: () {
//                     provider.selectCoverAmount(2000000);
//                     provider
//                         .showCoverAmountSection(onScrollToPlanCards);
//                   },
//                 ),
//               ),
//             ),