import 'package:broka/lib_medica_l_ap_p/widgets/selection_card.dart';
import 'package:broka/lib_medica_l_ap_p/widgets/card_animation_layout.dart';
import 'package:flutter/material.dart';
import 'package:broka/lib_medica_l_ap_p/providers/app_provider.dart';

class FamilyCoverCards extends StatelessWidget {
  final AppProvider provider;
  final VoidCallback ScrollToPersonOrFamilyDetailsCard;

  FamilyCoverCards(
      {Key? key,
      required this.provider,
      required this.ScrollToPersonOrFamilyDetailsCard});

  @override
  Widget build(BuildContext context) {
    final coverOptions = [
      {
        'icon': Icons.person_outline,
        'title': 'Me',
        'coverType': CoverType.me,
        'index': 0,
        'bounce': true,
        'bounceX': false,
      },
      {
        'icon': Icons.group_outlined,
        'title': 'Me & Spouse',
        'coverType': CoverType.spouse,
        'index': 1,
        'bounce': true,
        'bounceX': false,
      },
      {
        'icon': Icons.family_restroom_outlined,
        'title': 'My Family',
        'coverType': CoverType.family,
        'index': 2,
        'bounce': true,
        'bounceX': false,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          children: coverOptions
              .asMap()
              .entries
              .map(
                (entry) => [
                  Expanded(
                    child: CardAnimationLayout(
                      index: entry.value['index'] as int,
                      bounce: entry.value['bounce'] as bool,
                      bounceX: entry.value['bounceX'] as bool,
                      child: SelectionCard(
                        minHeight: 160,
                        icon: entry.value['icon'] as IconData,
                        title: entry.value['title'] as String,
                        isSelected: provider.selectedCoverType ==
                            entry.value['coverType'],
                        onTap: () {
                          provider.selectCoverType(
                              entry.value['coverType'] as CoverType);
                          provider.showDetailsSection(
                              ScrollToPersonOrFamilyDetailsCard);
                        },
                      ),
                    ),
                  ),
                  if (entry.key < coverOptions.length - 1)
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
