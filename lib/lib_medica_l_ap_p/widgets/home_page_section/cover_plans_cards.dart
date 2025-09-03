import 'dart:convert';

import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/statics_plans.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/popup_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_plan_card.dart';

// // class CoverPlansCard extends StatelessWidget {
// //   final AppProvider provider;
// //   final Key? coverPlanCardsKey;

// //   final VoidCallback onScrollToQuoteSummaryCard;
// //   // final VoidCallback onProceedToPayment;
// //   // final Key? coverAmountSectionKey;

// //   const CoverPlansCard({
// //     super.key,
// //     required this.coverPlanCardsKey,
// //     required this.provider,
// //     required this.onScrollToQuoteSummaryCard,
// //     // required this.onProceedToPayment,
// //     // required this.coverAmountSectionKey,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final planAmounts = [
// //       {'amount': 23000, 'index': 0, 'bounce': true, 'bounceX': false},
// //       {'amount': 31000, 'index': 1, 'bounce': true, 'bounceX': false},
// //     ];

// //     return Column(
// //       key: coverPlanCardsKey,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Divider(height: 40),
// //         Text(
// //           "Select Plan",
// //           style: Theme.of(context).textTheme.headlineMedium,
// //         ),
// //         const SizedBox(height: 16),
// //         Row(
// //           children: planAmounts
// //               .asMap()
// //               .entries
// //               .map(
// //                 (entry) => [
// //                   Expanded(
// //                     child: CardAnimationLayout(
// //                       index: entry.value['index'] as int,
// //                       bounce: entry.value['bounce'] as bool,
// //                       bounceX: entry.value['bounceX'] as bool,
// //                       child: CoverPlanCard(
// //                         amount: entry.value['amount'] as int,
// //                         isSelected:
// //                             provider.selectPlanAmount == entry.value['amount'],
// //                         onTap: () {
// //                           provider
// //                               .selectPlanAmount(entry.value['amount'] as int);
// //                           provider.showCoverAmountSection(
// //                               onScrollToQuoteSummaryCard);
// //                         },
// //                         title: '',
// //                         coverage: '',
// //                       ),
// //                     ),
// //                   ),
// //                   if (entry.key < planAmounts.length - 1)
// //                     const SizedBox(width: 16),
// //                 ],
// //               )
// //               .expand((element) => element)
// //               .toList(),
// //         ),
// //       ],
// //     );
// //   }
// // }

// class CoverPlansCard extends StatelessWidget {
//   final AppProvider provider;
//   final Key? coverPlanCardsKey;
//   final VoidCallback onScrollToQuoteSummaryCard;
//   final Map<String, dynamic> payload; // <-- pass in API payload

//   const CoverPlansCard({
//     super.key,
//     required this.coverPlanCardsKey,
//     required this.provider,
//     required this.onScrollToQuoteSummaryCard,
//     required this.payload,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: ContactInfoService.fetchPlans(
//         context: context,
//         payload: payload,
//       ),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('Failed to load plans.'));
//         }

//         final plans = snapshot.data!;

//         return Column(
//           key: coverPlanCardsKey,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Divider(height: 40),
//             Text(
//               "Select Plan",
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: plans
//                   .asMap()
//                   .entries
//                   .map(
//                     (entry) {
//                       final plan = entry.value;
//                       return [
//                         Expanded(
//                           child: CardAnimationLayout(
//                             index: entry.key,
//                             bounce: true,
//                             bounceX: false,
//                             child: CoverPlanCard(
//                               amount: plan['premium'] as int,
//                               isSelected:
//                                   provider.selectPlanAmount == plan['premium'],
//                               onTap: () {
//                                 provider
//                                     .selectPlanAmount(plan['premium'] as int);
//                                 provider.showCoverAmountSection(
//                                     onScrollToQuoteSummaryCard);
//                               },
//                               title: "${plan['plan']} (${plan['insurer']})",
//                               coverage: plan['option'].toString(),
//                             ),
//                           ),
//                         ),
//                         if (entry.key < plans.length - 1)
//                           const SizedBox(width: 16),
//                       ];
//                     },
//                   )
//                   .expand((e) => e)
//                   .toList(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class CoverPlansCard extends StatelessWidget {
  final AppProvider provider;
  final Key? coverPlanCardsKey;
  final VoidCallback onScrollToQuoteSummaryCard;

  const CoverPlansCard({
    super.key,
    required this.coverPlanCardsKey,
    required this.provider,
    required this.onScrollToQuoteSummaryCard,
  });

  PlanType _getPlanTypeFromName(String planName) {
    switch (planName) {
      case 'Royal Pre':
        return PlanType.royalPre;
      case 'Royalmed Exe':
        return PlanType.royalmedExe;
      default:
        return PlanType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: coverPlanCardsKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40),
        Text(
          "Select Your Plan",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),

        // Use FutureBuilder to fetch and display the plans
        FutureBuilder<List<Map<String, dynamic>>>(
          future: ContactInfoService.fetchMedicalPlans(context, provider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              final errorMessage = snapshot.error.toString();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                showPopupDialog(context, message: errorMessage, isError: true);
              });

              return Center(child: Text(errorMessage));
            }

            List<Map<String, dynamic>> plans;

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // fallback to static data
              plans = extractPlans(staticPlansData);
            } else {
              plans = snapshot.data!;
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: plans.asMap().entries.expand(
                (entry) {
                  final planData = entry.value;
                  final index = entry.key;
                  final planType = _getPlanTypeFromName(planData['planName']);

                  final card = Expanded(
                    child: CardAnimationLayout(
                      index: index,
                      child: CoverPlanCard(
                        title: planData['planName'],
                        amount: planData['premium'],
                        coverage: planData['coverage'].toString(),
                        // isSelected: provider.selectPlanAmount == planData['premium'],
                        isSelected: provider.selectedPlanType == planType,
                        onTap: () {
                          // provider.selectPlanAmount(planData['premium']);
                          //     as PlanType;
                          provider.selectPlanType(
                              planType, planData['premium'] as int);
                          onScrollToQuoteSummaryCard();
                        },
                      ),
                    ),
                  );

                  if (index < plans.length - 1) {
                    return [card, const SizedBox(width: 24)];
                  } else {
                    return [card];
                  }
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
