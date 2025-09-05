// lib/widgets/home_page_section/dependant_details_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
import 'package:flutter/material.dart';

class DependantDetailsCard extends StatefulWidget {
  final AppProvider provider;

  const DependantDetailsCard({super.key, required this.provider});

  @override
  State<DependantDetailsCard> createState() => _DependantDetailsCardState();
}

class _DependantDetailsCardState extends State<DependantDetailsCard> {
  late TextEditingController _spouseNameController;
  late List<TextEditingController> _childNameControllers;

  @override
  void initState() {
    super.initState();
    _spouseNameController =
        TextEditingController(text: widget.provider.spouseName);
    _childNameControllers = List.generate(
      widget.provider.childCount,
      (index) =>
          TextEditingController(text: widget.provider.children[index].name),
    );
  }

  @override
  void didUpdateWidget(covariant DependantDetailsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync child name controllers if the number of children changes
    if (widget.provider.childCount != _childNameControllers.length) {
      for (var controller in _childNameControllers) {
        controller.dispose();
      }
      setState(() {
        _childNameControllers = List.generate(
          widget.provider.childCount,
          (index) =>
              TextEditingController(text: widget.provider.children[index].name),
        );
      });
    }
  }

  @override
  void dispose() {
    _spouseNameController.dispose();
    for (var controller in _childNameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    final showSpouseField = provider.selectedCoverType == CoverType.spouse ||
        provider.selectedCoverType == CoverType.family;
    final showChildrenFields = provider.selectedCoverType == CoverType.family &&
        provider.childCount > 0;

    // Don't build anything if there are no dependants to add details for
    if (!showSpouseField && !showChildrenFields) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 32),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dependant's Details",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "Please provide the full names for all beneficiaries.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 32),

            // Conditionally show Spouse Name field
            if (showSpouseField)
              TextFormField(
                controller: _spouseNameController,
                decoration: const InputDecoration(
                  labelText: "Spouse's Full Name",
                  prefixIcon: Icon(Icons.favorite_border),
                  filled: true,
                ),
                onChanged: (value) {
                  provider.setSpouseName(value);
                },
              ),

            // Conditionally show Child input fields
            if (showChildrenFields) ...[
              if (showSpouseField) const SizedBox(height: 24),
              Text(
                "Children's Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ...List.generate(provider.childCount, (index) {
                return _buildChildInputRow(context, index);
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChildInputRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: _childNameControllers[index],
              decoration: InputDecoration(
                labelText: 'Child ${index + 1} Name',
                filled: true,
              ),
              onChanged: (value) {
                widget.provider.updateChildName(index, value);
              },
            ),
          ),
          const SizedBox(width: 16),
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
