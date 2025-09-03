// lib/lib_medica_l_ap_p/widgets/home_page_section/person_or_family_details_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class PersonOrFamilyDetailsCard extends StatelessWidget {
  final AppProvider provider;
  final VoidCallback onScrollToCoverAmountsCard;
  final Key? detailsSectionKey;

  const PersonOrFamilyDetailsCard(
      {Key? key,
      required this.provider,
      required this.onScrollToCoverAmountsCard,
      this.detailsSectionKey});

  @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }

  Widget build(
    BuildContext context,
  ) {
    return Column(
      key: detailsSectionKey,
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
            onDateSelected: (date) {
              provider.setMyDob(date);
              provider.showCoverAmountSection(onScrollToCoverAmountsCard);
            }),
        if (provider.selectedCoverType == CoverType.spouse ||
            provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 16),
          DobPickerField(
              label: "Spouse's Date of Birth",
              selectedDate: provider.spouseDob,
              onDateSelected: (date) {
                provider.setSpouseDob(date);
                provider.showCoverAmountSection(onScrollToCoverAmountsCard);
              }),
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
              provider.showCoverAmountSection(onScrollToCoverAmountsCard);
            },
          ),
        ],
      ],
    );
  }
}
