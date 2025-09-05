// lib/lib_medica_l_ap_p/widgets/home_page_section/2_person_or_family_details_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class Child {
  String name;
  DateTime? dob;

  Child({this.name = '', this.dob});
}

// CHANGED: Converted to a StatefulWidget
class PersonOrFamilyDetailsCard extends StatefulWidget {
  final AppProvider provider;
  final VoidCallback onScrollToCoverAmountsCard;
  final Key? detailsSectionKey;

  const PersonOrFamilyDetailsCard({
    Key? key,
    required this.provider,
    required this.onScrollToCoverAmountsCard,
    this.detailsSectionKey,
  }) : super(key: key);

  @override
  State<PersonOrFamilyDetailsCard> createState() =>
      _PersonOrFamilyDetailsCardState();
}

class _PersonOrFamilyDetailsCardState extends State<PersonOrFamilyDetailsCard> {
  // A list to hold a TextEditingController for each child's name
  late List<TextEditingController> _nameControllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers based on the initial number of children
    _nameControllers = List.generate(
      widget.provider.childCount,
      (index) =>
          TextEditingController(text: widget.provider.children[index].name),
    );
  }

  @override
  void didUpdateWidget(covariant PersonOrFamilyDetailsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This is crucial: when the provider's childCount changes, we update our list of controllers
    if (widget.provider.childCount != _nameControllers.length) {
      // Dispose old controllers
      for (var controller in _nameControllers) {
        controller.dispose();
      }
      // Create a new list of controllers matching the new child count
      setState(() {
        _nameControllers = List.generate(
          widget.provider.childCount,
          (index) =>
              TextEditingController(text: widget.provider.children[index].name),
        );
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is removed
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We now access the provider via `widget.provider`
    final provider = widget.provider;

    return Column(
      key: widget.detailsSectionKey,
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
              provider
                  .showCoverAmountSection(widget.onScrollToCoverAmountsCard);
            }),
        if (provider.selectedCoverType == CoverType.spouse ||
            provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 16),
          DobPickerField(
              label: "Spouse's Date of Birth",
              selectedDate: provider.spouseDob,
              onDateSelected: (date) {
                provider.setSpouseDob(date);
                if (provider.selectedCoverType == CoverType.spouse) {
                  provider.showCoverAmountSection(
                      widget.onScrollToCoverAmountsCard);
                }
              }),
        ],
        if (provider.selectedCoverType == CoverType.family) ...[
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: "Number of Children",
              filled: true,
            ),
            value: provider.childCount == 0 ? null : provider.childCount,
            hint: const Text("Select count"),
            items: List.generate(10, (index) => index + 1)
                .map((count) =>
                    DropdownMenuItem(value: count, child: Text("$count")))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                // This now resizes the list in the provider
                provider.setChildCount(value);
              }
              provider
                  .showCoverAmountSection(widget.onScrollToCoverAmountsCard);
            },
          ),

          // --- NEW: DYNAMIC CHILD INPUT FIELDS ---
          // This generates the input rows based on the number of children
          // ...List.generate(provider.childCount, (index) {
          //   return _buildChildInputRow(context, index);
          // }),
        ],
      ],
    );
  }

  // A new helper widget to create the two-column layout for each child
  Widget _buildChildInputRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Child's Name
          Expanded(
            child: TextFormField(
              controller: _nameControllers[index],
              decoration: InputDecoration(
                labelText: 'Child ${index + 1} Name',
                filled: true,
              ),
              onChanged: (value) {
                widget.provider.updateChildName(index, value);
              },
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Name is required' : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          const SizedBox(width: 16),
          // Column 2: Child's DOB
          Expanded(
            child: DobPickerField(
              label: 'Child ${index + 1} DOB',
              selectedDate: widget.provider.children[index].dob,
              onDateSelected: (date) {
                widget.provider.updateChildDob(index, date);
              },
            ),
          ),
        ],
      ),
    );
  }
}
