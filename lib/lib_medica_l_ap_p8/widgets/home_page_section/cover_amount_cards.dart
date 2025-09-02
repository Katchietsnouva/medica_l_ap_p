// lib/widgets/cover_amount_cards.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/cover_amount_card.dart';

class CoverAmountCards extends StatelessWidget {
  final AppProvider provider;
  final VoidCallback onScrollToQuoteSummaryCard;
  final Key? coverAmountSectionKey;

  const CoverAmountCards({
    super.key,
    required this.provider,
    required this.onScrollToQuoteSummaryCard,
    this.coverAmountSectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final coverAmounts = [
      {'amount': 500000, 'index': 0, 'bounce': true, 'bounceX': false},
      {'amount': 1000000, 'index': 1, 'bounce': true, 'bounceX': false},
      {'amount': 2000000, 'index': 2, 'bounce': true, 'bounceX': false},
    ];

    return Column(
      key: coverAmountSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40),
        Text(
          "Select Cover Amount",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: coverAmounts
              .asMap()
              .entries
              .map(
                (entry) => [
                  Expanded(
                    child: CardAnimationLayout(
                      index: entry.value['index'] as int,
                      bounce: entry.value['bounce'] as bool,
                      bounceX: entry.value['bounceX'] as bool,
                      child: CoverAmountCard(
                        amount: entry.value['amount'] as int,
                        isSelected: provider.selectedCoverAmount ==
                            entry.value['amount'],
                        onTap: () {
                          provider
                              .selectCoverAmount(entry.value['amount'] as int);
                          provider.showCoverAmountSection(
                              onScrollToQuoteSummaryCard);
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
        ),
      ],
    );
  }
}




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
//                         .showCoverAmountSection(onScrollToQuoteSummaryCard);
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
//                         .showCoverAmountSection(onScrollToQuoteSummaryCard);
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
//                         .showCoverAmountSection(onScrollToQuoteSummaryCard);
//                   },
//                 ),
//               ),
//             ),