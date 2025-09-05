// components/steps/beno_dependants_step.dart
import 'package:flutter/material.dart';
import '../../helpers/responsive_helper.dart';
import '../../models/beno_project_model.dart';
import '../ui/beno_ui_components.dart';
import 'dart:math' as math;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uuid/uuid.dart';

class BenoDependantsStep extends StatefulWidget {
  final String plan;
  final SectionC sectionC;
  final Function(String) onPlanChange;
  final Function(SectionC) onSectionCChange;
  final VoidCallback nextStep;
  final VoidCallback prevStep;

  const BenoDependantsStep({
    super.key,
    required this.plan,
    required this.sectionC,
    required this.onPlanChange,
    required this.onSectionCChange,
    required this.nextStep,
    required this.prevStep,
  });

  @override
  _BenoDependantsStepState createState() => _BenoDependantsStepState();
}

class _BenoDependantsStepState extends State<BenoDependantsStep> {
  final _uuid = const Uuid();

  // void _addBeneficiary() {
  //   final newBeneficiary = Beneficiary(id: _uuid.v4());
  //   setState(() {
  //     widget.sectionC.beneficiaries.add(newBeneficiary);
  //     widget.onSectionCChange(widget.sectionC);
  //   });
  // }

  void _addBeneficiary() {
    final newBeneficiary = Beneficiary(id: _uuid.v4());
    setState(() {
      final updatedBeneficiaries =
          List<Beneficiary>.from(widget.sectionC.beneficiaries);
      updatedBeneficiaries.add(newBeneficiary);
      widget.onSectionCChange(
          widget.sectionC..beneficiaries = updatedBeneficiaries);
    });
  }

  // void _removeBeneficiary(String id) {
  //   setState(() {
  //     widget.sectionC.beneficiaries.removeWhere((b) => b.id == id);
  //     widget.onSectionCChange(widget.sectionC);
  //   });
  // }

  void _removeBeneficiary(String id) {
    setState(() {
      final updatedBeneficiaries =
          List<Beneficiary>.from(widget.sectionC.beneficiaries);
      updatedBeneficiaries.removeWhere((b) => b.id == id);
      widget.onSectionCChange(
          widget.sectionC..beneficiaries = updatedBeneficiaries);
    });
  }

  // void _addGuardian() {
  //   final newGuardian = Guardian(id: _uuid.v4());
  //   setState(() {
  //     widget.sectionC.guardians.add(newGuardian);
  //     widget.onSectionCChange(widget.sectionC);
  //   });
  // }

  void _addGuardian() {
    final newGuardian = Guardian(id: _uuid.v4());
    setState(() {
      final updatedGuardians = List<Guardian>.from(widget.sectionC.guardians);
      updatedGuardians.add(newGuardian);
      widget.onSectionCChange(widget.sectionC..guardians = updatedGuardians);
    });
  }

  void _removeGuardian(String id) {
    setState(() {
      final updatedGuardians = List<Guardian>.from(widget.sectionC.guardians);
      updatedGuardians.removeWhere((g) => g.id == id);
      widget.onSectionCChange(widget.sectionC..guardians = updatedGuardians);
    });
  }

  // void _removeGuardian(String id) {
  //   setState(() {
  //     widget.sectionC.guardians.removeWhere((g) => g.id == id);
  //     widget.onSectionCChange(widget.sectionC);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 600;
      final isPhone = constraints.maxWidth < 420;
      final double maxFormWidth = isNarrow
          ? math.min(constraints.maxWidth, 420)
          : math.min(constraints.maxWidth, 900);
      final double horizontalPadding = isPhone ? 8.0 : (isNarrow ? 16.0 : 32.0);
      final double verticalSpacing = isPhone ? 12.0 : (isNarrow ? 20.0 : 28.0);
      final double titleSize = responsiveFontSize(context,
          baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));

      return Center(
        child: BenoCard(
          maxWidth: maxFormWidth + horizontalPadding * 2,
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Step 2: Plan, Beneficiaries & Guardians",
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold)),
                SizedBox(height: verticalSpacing),
                // _buildPlanSelector(isNarrow, isPhone),
                SizedBox(height: verticalSpacing),
                _buildBeneficiariesList(isPhone),
                SizedBox(height: verticalSpacing),
                BenoButton(
                  onPressed: _addBeneficiary,
                  text: "+ Add Beneficiary",
                  isFullWidth: true,
                  isOutline: true,
                  compact: isPhone,
                ),
                SizedBox(height: verticalSpacing),
                _buildGuardiansList(isPhone),
                SizedBox(height: verticalSpacing),
                BenoButton(
                  onPressed: _addGuardian,
                  text: "+ Add Guardian",
                  isFullWidth: true,
                  isOutline: true,
                  compact: isPhone,
                ),
                SizedBox(height: verticalSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BenoButton(
                      onPressed: widget.prevStep,
                      text: 'Back',
                      isOutline: true,
                      compact: isPhone,
                    ),
                    BenoButton(
                      onPressed: widget.nextStep,
                      text: 'Next Step',
                      compact: isPhone,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPlanSelector(bool isNarrow, bool isPhone) {
    Widget premiumPlan = PlanRadioTile(
      title: "Premium Plan",
      subtitle: "Coverage: Ksh. 100,000 | Annual Premium: Ksh. 2,560",
      value: "Premium",
      groupValue: widget.plan,
      isCompact: isPhone,
      onChanged: (value) => widget.onPlanChange(value!),
    );

    Widget standardPlan = PlanRadioTile(
      title: "Standard Plan",
      subtitle: "Coverage: Ksh. 50,000 | Annual Premium: Ksh. 1,560",
      value: "Basic",
      groupValue: widget.plan,
      isCompact: isPhone,
      onChanged: (value) => widget.onPlanChange(value!),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your Currently Selected Plan",
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        isNarrow
            ? Column(children: [
                premiumPlan,
                const SizedBox(height: 8),
                standardPlan
              ])
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: premiumPlan),
                  const SizedBox(width: 16),
                  Expanded(child: standardPlan),
                ],
              ),
      ],
    );
  }

  Widget _buildBeneficiariesList(bool isPhone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Beneficiaries", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        if (widget.sectionC.beneficiaries.isEmpty)
          const Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No beneficiaries added yet.")))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.sectionC.beneficiaries.length,
            itemBuilder: (context, index) {
              return BeneficiaryFormCard(
                key: ValueKey(widget.sectionC.beneficiaries[index].id),
                beneficiary: widget.sectionC.beneficiaries[index],
                isCompact: isPhone,
                onRemove: () =>
                    _removeBeneficiary(widget.sectionC.beneficiaries[index].id),
                onChanged: (field, value) {
                  final updatedBeneficiaries =
                      List<Beneficiary>.from(widget.sectionC.beneficiaries);
                  final ben = updatedBeneficiaries[index];
                  switch (field) {
                    case 'name':
                      ben.name = value;
                      break;
                    case 'email':
                      ben.email = value.isEmpty ? null : value;
                      break;
                    case 'mobile':
                      ben.mobile = value;
                      break;
                    case 'dateOfBirth':
                      ben.dateOfBirth = value;
                      break;
                    case 'idNo':
                      ben.idNo = value.isEmpty ? null : value;
                      break;
                    case 'relationship':
                      ben.relationshipToMember = value;
                      break;
                    case 'sharePercent':
                      ben.sharePercent = int.tryParse(value) ?? 0;
                      break;
                  }
                  widget.onSectionCChange(
                      widget.sectionC..beneficiaries = updatedBeneficiaries);
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildGuardiansList(bool isPhone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Guardians", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        if (widget.sectionC.guardians.isEmpty)
          const Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No guardians added yet.")))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.sectionC.guardians.length,
            itemBuilder: (context, index) {
              return GuardianFormCard(
                key: ValueKey(widget.sectionC.guardians[index].id),
                guardian: widget.sectionC.guardians[index],
                isCompact: isPhone,
                onRemove: () =>
                    _removeGuardian(widget.sectionC.guardians[index].id),
                onChanged: (field, value) {
                  final updatedGuardians =
                      List<Guardian>.from(widget.sectionC.guardians);
                  final guard = updatedGuardians[index];
                  switch (field) {
                    case 'name':
                      guard.name = value;
                      break;
                    case 'email':
                      guard.email = value.isEmpty ? null : value;
                      break;
                    case 'mobile':
                      guard.mobile = value;
                      break;
                    case 'idNo':
                      guard.idNo = value.isEmpty ? null : value;
                      break;
                    case 'relationship':
                      guard.relationshipToMember = value;
                      break;
                  }
                  widget.onSectionCChange(
                      widget.sectionC..guardians = updatedGuardians);
                },
              );
            },
          ),
      ],
    );
  }
}

class PlanRadioTile extends StatelessWidget {
  final String title, subtitle, value, groupValue;
  final bool isCompact;
  final ValueChanged<String?> onChanged;

  const PlanRadioTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.isCompact,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: isCompact
            ? const EdgeInsets.symmetric(horizontal: 4, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? Colors.blue : Theme.of(context).dividerColor,
              width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.blue),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BeneficiaryFormCard extends StatefulWidget {
  final Beneficiary beneficiary;
  final bool isCompact;
  final VoidCallback onRemove;
  final Function(String field, String value) onChanged;

  const BeneficiaryFormCard({
    super.key,
    required this.beneficiary,
    required this.isCompact,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  _BeneficiaryFormCardState createState() => _BeneficiaryFormCardState();
}

class _BeneficiaryFormCardState extends State<BeneficiaryFormCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _dobController;
  late final TextEditingController _idController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _sharePercentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.beneficiary.name);
    _emailController = TextEditingController(text: widget.beneficiary.email);
    _mobileController = TextEditingController(text: widget.beneficiary.mobile);
    _dobController =
        TextEditingController(text: widget.beneficiary.dateOfBirth);
    _idController = TextEditingController(text: widget.beneficiary.idNo);
    _relationshipController =
        TextEditingController(text: widget.beneficiary.relationshipToMember);
    _sharePercentController =
        TextEditingController(text: widget.beneficiary.sharePercent.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _idController.dispose();
    _relationshipController.dispose();
    _sharePercentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: widget.isCompact ? 12 : 16),
      child: Padding(
        padding: EdgeInsets.all(widget.isCompact ? 12.0 : 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onRemove,
                color: Colors.red,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth > 500
                  ? _buildTwoColumnFields()
                  : _buildSingleColumnFields();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleColumnFields() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('name', 'Full Name', _nameController)),
            const SizedBox(width: 4),
            Expanded(
                child: _buildTextField('email', 'Email', _emailController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('mobile', 'Mobile', _mobileController)),
            const SizedBox(width: 4),
            Expanded(
                child: _buildTextField(
                    'dateOfBirth', 'Date of Birth', _dobController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
            const SizedBox(width: 4),
            Expanded(
                child: _buildTextField(
                    'relationship', 'Relationship', _relationshipController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField(
                    'sharePercent', 'Share Percent', _sharePercentController)),
            const SizedBox(width: 4),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildTwoColumnFields() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('name', 'Full Name', _nameController)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextField('email', 'Email', _emailController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('mobile', 'Mobile', _mobileController)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextField(
                    'dateOfBirth', 'Date of Birth', _dobController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextField(
                    'relationship', 'Relationship', _relationshipController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField(
                    'sharePercent', 'Share Percent', _sharePercentController)),
            const SizedBox(width: 16),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      String field, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Builder(
        builder: (context) {
          if (field == 'dateOfBirth') {
            return InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 365 * 18)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  controller.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  widget.onChanged(field, controller.text);
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    isDense: widget.isCompact,
                    contentPadding: widget.isCompact
                        ? const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8)
                        : null,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter $label'
                      : null,
                ),
              ),
            );
          }
          if (field == 'relationship') {
            return DropdownButtonFormField<String>(
              value: controller.text.isEmpty ? null : controller.text,
              items: [
                'Spouse',
                'Son',
                'Daughter',
                'Mother',
                'Father',
                'Sister',
                'Brother'
              ]
                  .map((relationship) => DropdownMenuItem(
                      value: relationship, child: Text(relationship)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.text = value;
                  widget.onChanged(field, value);
                }
              },
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select a $label'
                  : null,
            );
          }
          if (field == 'mobile') {
            return IntlPhoneField(
              controller: controller,
              initialCountryCode: 'KE',
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              keyboardType: TextInputType.phone,
              validator: (phone) =>
                  phone == null || phone.completeNumber.isEmpty
                      ? 'Please enter a valid $label'
                      : null,
              onChanged: (phone) =>
                  widget.onChanged(field, phone.completeNumber),
            );
          }
          if (field == 'email') {
            return TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value))
                    return 'Please enter a valid email';
                }
                return null;
              },
              onChanged: (value) => widget.onChanged(field, value),
            );
          }
          if (field == 'sharePercent') {
            return TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter $label';
                final numValue = int.tryParse(value);
                if (numValue == null || numValue < 0 || numValue > 100)
                  return 'Please enter a valid percentage (0-100)';
                return null;
              },
              onChanged: (value) => widget.onChanged(field, value),
            );
          }
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              isDense: widget.isCompact,
              contentPadding: widget.isCompact
                  ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                  : null,
            ),
            onChanged: (value) => widget.onChanged(field, value),
          );
        },
      ),
    );
  }
}

class GuardianFormCard extends StatefulWidget {
  final Guardian guardian;
  final bool isCompact;
  final VoidCallback onRemove;
  final Function(String field, String value) onChanged;

  const GuardianFormCard({
    super.key,
    required this.guardian,
    required this.isCompact,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  _GuardianFormCardState createState() => _GuardianFormCardState();
}

class _GuardianFormCardState extends State<GuardianFormCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _idController;
  late final TextEditingController _relationshipController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.guardian.name);
    _emailController = TextEditingController(text: widget.guardian.email);
    _mobileController = TextEditingController(text: widget.guardian.mobile);
    _idController = TextEditingController(text: widget.guardian.idNo);
    _relationshipController =
        TextEditingController(text: widget.guardian.relationshipToMember);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _idController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: widget.isCompact ? 12 : 16),
      child: Padding(
        padding: EdgeInsets.all(widget.isCompact ? 12.0 : 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onRemove,
                color: Colors.red,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth > 500
                  ? _buildTwoColumnFields()
                  : _buildSingleColumnFields();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleColumnFields() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('name', 'Full Name', _nameController)),
            const SizedBox(width: 4),
            Expanded(
                child: _buildTextField('email', 'Email', _emailController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('mobile', 'Mobile', _mobileController)),
            const SizedBox(width: 4),
            Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField(
                    'relationship', 'Relationship', _relationshipController)),
            const SizedBox(width: 4),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildTwoColumnFields() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('name', 'Full Name', _nameController)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextField('email', 'Email', _emailController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField('mobile', 'Mobile', _mobileController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildTextField(
                    'relationship', 'Relationship', _relationshipController)),
            const SizedBox(width: 16),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      String field, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Builder(
        builder: (context) {
          if (field == 'relationship') {
            return DropdownButtonFormField<String>(
              value: controller.text.isEmpty ? null : controller.text,
              items: ['Mother', 'Father', 'Uncle', 'Aunt', 'Grandparent']
                  .map((relationship) => DropdownMenuItem(
                      value: relationship, child: Text(relationship)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.text = value;
                  widget.onChanged(field, value);
                }
              },
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select a $label'
                  : null,
            );
          }
          if (field == 'mobile') {
            return IntlPhoneField(
              controller: controller,
              initialCountryCode: 'KE',
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              keyboardType: TextInputType.phone,
              validator: (phone) =>
                  phone == null || phone.completeNumber.isEmpty
                      ? 'Please enter a valid $label'
                      : null,
              onChanged: (phone) =>
                  widget.onChanged(field, phone.completeNumber),
            );
          }
          if (field == 'email') {
            return TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                isDense: widget.isCompact,
                contentPadding: widget.isCompact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                    : null,
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value))
                    return 'Please enter a valid email';
                }
                return null;
              },
              onChanged: (value) => widget.onChanged(field, value),
            );
          }
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              isDense: widget.isCompact,
              contentPadding: widget.isCompact
                  ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
                  : null,
            ),
            onChanged: (value) => widget.onChanged(field, value),
          );
        },
      ),
    );
  }
}

// // components/steps/beno_dependants_step.dart
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:uuid/uuid.dart';
// import '../../helpers/responsive_helper.dart';
// import '../../models/beno_project_model.dart';
// import '../ui/beno_ui_components.dart';
// import 'dart:math' as math;

// class BenoDependantsStep extends StatefulWidget {
//   final String plan;
//   // final List<BenoDependant> dependants;
//   final Function(String) onPlanChange;
//   // final Function(List<BenoDependant>) onDependantsChange;
//   // final VoidCallback onAddDependant;
//   final Function(String) onRemoveDependant;
//   final VoidCallback nextStep;
//   final VoidCallback prevStep;

//   final SectionC sectionC;
//   // final Function(String) onPlanChange;
//   final Function(SectionC) onSectionCChange;

//   const BenoDependantsStep({
//     super.key,
//     required this.plan,
//     // required this.dependants,
//     // required this.onDependantsChange,
//     // required this.onAddDependant,
//     required this.sectionC,
//     required this.onPlanChange,
//     required this.onSectionCChange,
//     required this.onRemoveDependant,
//     required this.nextStep,
//     required this.prevStep,
//   });

//   @override
//   _BenoDependantsStepState createState() => _BenoDependantsStepState();
// }

// class _BenoDependantsStepState extends State<BenoDependantsStep> {
//   final _uuid = const Uuid();

//   void _addBeneficiary() {
//     final newBeneficiary = Beneficiary(id: _uuid.v4());
//     setState(() {
//       widget.sectionC.beneficiaries.add(newBeneficiary);
//       widget.onSectionCChange(widget.sectionC);
//     });
//   }

//   void _removeBeneficiary(String id) {
//     setState(() {
//       widget.sectionC.beneficiaries.removeWhere((b) => b.id == id);
//       widget.onSectionCChange(widget.sectionC);
//     });
//   }

//   void _addGuardian() {
//     final newGuardian = Guardian(id: _uuid.v4());
//     setState(() {
//       widget.sectionC.guardians.add(newGuardian);
//       widget.onSectionCChange(widget.sectionC);
//     });
//   }

//   void _removeGuardian(String id) {
//     setState(() {
//       widget.sectionC.guardians.removeWhere((g) => g.id == id);
//       widget.onSectionCChange(widget.sectionC);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final isNarrow = constraints.maxWidth < 600;
//       final isPhone = constraints.maxWidth < 420;

//       final double maxFormWidth = isNarrow
//           ? math.min(constraints.maxWidth, 420)
//           : math.min(constraints.maxWidth, 900);

//       // ✅ More aggressive compaction for phones
//       final double horizontalPadding = isPhone ? 8.0 : (isNarrow ? 16.0 : 32.0);
//       final double verticalSpacing = isPhone ? 12.0 : (isNarrow ? 20.0 : 28.0);
//       final double titleSize = responsiveFontSize(context,
//           baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));

//       return Center(
//         child: BenoCard(
//           maxWidth: maxFormWidth + horizontalPadding * 2,
//           child: Padding(
//             padding: EdgeInsets.all(horizontalPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Step 2: Plan, Beneficiaries & Guardians",
//                     style: TextStyle(
//                         fontSize: titleSize, fontWeight: FontWeight.bold)),
//                 SizedBox(height: verticalSpacing),
//                 _buildPlanSelector(isNarrow, isPhone),
//                 SizedBox(height: verticalSpacing),
//                 // _buildDependantsList(isPhone),
//                 _buildBeneficiariesList(isPhone),
//                 SizedBox(height: verticalSpacing),
//                 BenoButton(
//                   // onPressed: widget.onAddDependant,
//                   onPressed: _addBeneficiary,
//                   text: "+ Add Dependant",
//                   isFullWidth: true,
//                   isOutline: true,
//                   compact: isPhone ? true : false,
//                 ),
//                 SizedBox(height: verticalSpacing),
//                 _buildGuardiansList(isPhone),
//                 SizedBox(height: verticalSpacing),
//                 BenoButton(
//                   onPressed: _addGuardian,
//                   text: "+ Add Guardian",
//                   isFullWidth: true,
//                   isOutline: true,
//                   compact: isPhone,
//                 ),
//                 SizedBox(height: verticalSpacing),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     BenoButton(
//                       onPressed: widget.prevStep,
//                       text: 'Back',
//                       isOutline: true,
//                       compact: isPhone ? true : false,
//                     ),
//                     BenoButton(
//                       onPressed: widget.nextStep,
//                       text: 'Next Step',
//                       compact: isPhone ? true : false,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildPlanSelector(bool isNarrow, bool isPhone) {
//     Widget premiumPlan = PlanRadioTile(
//       title: "Premium Plan",
//       subtitle: "Coverage: Ksh. 100,000 | Annual Premium: Ksh. 2,560",
//       value: "Premium",
//       groupValue: widget.plan,
//       isCompact: isPhone,
//       onChanged: (value) => widget.onPlanChange(value!),
//     );

//     Widget standardPlan = PlanRadioTile(
//       title: "Standard Plan",
//       subtitle: "Coverage: Ksh. 50,000 | Annual Premium: Ksh. 1,560",
//       value: "Basic",
//       groupValue: widget.plan,
//       isCompact: isPhone,
//       onChanged: (value) => widget.onPlanChange(value!),
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       // children: [
//       //   Text("Your Currently Selected Plan",
//       //       style: Theme.of(context).textTheme.titleLarge),
//       //   const SizedBox(height: 16),
//       //   if (isNarrow)
//       //     Column(
//       //         children: [premiumPlan, const SizedBox(height: 8), standardPlan])
//       //   else
//       //     Row(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         Expanded(child: premiumPlan),
//       //         const SizedBox(width: 16),
//       //         Expanded(child: standardPlan),
//       //       ],
//       //     )
//       // ],
//     );
//   }

//   Widget _buildBeneficiariesList(bool isPhone) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Beneficiaries", style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 16),
//         if (widget.sectionC.beneficiaries.isEmpty)
//           const Center(
//               child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text("No beneficiaries added yet.")))
//         else
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: widget.sectionC.beneficiaries.length,
//             itemBuilder: (context, index) {
//               return BeneficiaryFormCard(
//                 key: ValueKey(widget.sectionC.beneficiaries[index].id),
//                 beneficiary: widget.sectionC.beneficiaries[index],
//                 isCompact: isPhone,
//                 onRemove: () =>
//                     _removeBeneficiary(widget.sectionC.beneficiaries[index].id),
//                 onChanged: (field, value) {
//                   final updatedBeneficiaries =
//                       List<Beneficiary>.from(widget.sectionC.beneficiaries);
//                   final ben = updatedBeneficiaries[index];
//                   switch (field) {
//                     case 'name':
//                       ben.name = value;
//                       break;
//                     case 'email':
//                       ben.email = value.isEmpty ? null : value;
//                       break;
//                     case 'mobile':
//                       ben.mobile = value;
//                       break;
//                     case 'dateOfBirth':
//                       ben.dateOfBirth = value;
//                       break;
//                     case 'idNo':
//                       ben.idNo = value.isEmpty ? null : value;
//                       break;
//                     case 'relationship':
//                       ben.relationshipToMember = value;
//                       break;
//                     case 'sharePercent':
//                       ben.sharePercent = int.tryParse(value) ?? 0;
//                       break;
//                   }
//                   widget.onSectionCChange(
//                       widget.sectionC..beneficiaries = updatedBeneficiaries);
//                 },
//               );
//             },
//           ),
//       ],
//     );
//   }

//   Widget _buildGuardiansList(bool isPhone) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Guardians", style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 16),
//         if (widget.sectionC.guardians.isEmpty)
//           const Center(
//               child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text("No guardians added yet.")))
//         else
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: widget.sectionC.guardians.length,
//             itemBuilder: (context, index) {
//               return GuardianFormCard(
//                 key: ValueKey(widget.sectionC.guardians[index].id),
//                 guardian: widget.sectionC.guardians[index],
//                 isCompact: isPhone,
//                 onRemove: () =>
//                     _removeGuardian(widget.sectionC.guardians[index].id),
//                 onChanged: (field, value) {
//                   final updatedGuardians =
//                       List<Guardian>.from(widget.sectionC.guardians);
//                   final guard = updatedGuardians[index];
//                   switch (field) {
//                     case 'name':
//                       guard.name = value;
//                       break;
//                     case 'email':
//                       guard.email = value.isEmpty ? null : value;
//                       break;
//                     case 'mobile':
//                       guard.mobile = value;
//                       break;
//                     case 'idNo':
//                       guard.idNo = value.isEmpty ? null : value;
//                       break;
//                     case 'relationship':
//                       guard.relationshipToMember = value;
//                       break;
//                   }
//                   widget.onSectionCChange(
//                       widget.sectionC..guardians = updatedGuardians);
//                 },
//               );
//             },
//           ),
//       ],
//     );
//   }

//   // Widget __buildDependantsList(bool isPhone) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text("Dependants", style: Theme.of(context).textTheme.titleLarge),
//   //       const SizedBox(height: 16),
//   //       if (widget.dependants.isEmpty)
//   //         const Center(
//   //             child: Padding(
//   //           padding: EdgeInsets.all(16.0),
//   //           child: Text("No dependants added yet."),
//   //         ))
//   //       else
//   //         ListView.builder(
//   //           shrinkWrap: true,
//   //           physics: const NeverScrollableScrollPhysics(),
//   //           itemCount: widget.dependants.length,
//   //           itemBuilder: (context, index) {
//   //             return DependantFormCard(
//   //               key: ValueKey(widget.dependants[index].id),
//   //               dependant: widget.dependants[index],
//   //               isCompact: isPhone,
//   //               onRemove: () =>
//   //                   widget.onRemoveDependant(widget.dependants[index].id),
//   //               onChanged: (field, value) {
//   //                 final updatedDependants =
//   //                     List<BenoDependant>.from(widget.dependants);
//   //                 final dep = updatedDependants[index];
//   //                 switch (field) {
//   //                   case 'name':
//   //                     dep.name = value;
//   //                     break;
//   //                   case 'dob':
//   //                     dep.dob = value;
//   //                     break;
//   //                   case 'relationship':
//   //                     dep.relationship = value;
//   //                     break;
//   //                   case 'idNumber':
//   //                     dep.idNumber = value;
//   //                     break;
//   //                 }
//   //                 widget.onDependantsChange(updatedDependants);
//   //               },
//   //             );
//   //           },
//   //         ),
//   //     ],
//   //   );
//   // }
// }

// class PlanRadioTile extends StatelessWidget {
//   final String title, subtitle, value, groupValue;
//   final bool isCompact; // ✅ Added compact flag
//   final ValueChanged<String?> onChanged;

//   const PlanRadioTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.value,
//     required this.groupValue,
//     required this.isCompact,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isSelected = value == groupValue;
//     return InkWell(
//       onTap: () => onChanged(value),
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         // ✅ Responsive padding
//         padding: isCompact
//             ? const EdgeInsets.symmetric(horizontal: 4, vertical: 8)
//             : const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.blue : Theme.of(context).dividerColor,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Radio<String>(
//               value: value,
//               groupValue: groupValue,
//               onChanged: onChanged,
//               activeColor: Colors.blue,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class DependantFormCard extends StatefulWidget {
// //   final BenoDependant dependant;
// //   final bool isCompact;
// //   final VoidCallback onRemove;
// //   final Function(String field, String value) onChanged;

// //   const DependantFormCard(
// //       {super.key,
// //       required this.dependant,
// //       required this.isCompact,
// //       required this.onRemove,
// //       required this.onChanged});

// //   @override
// //   State<DependantFormCard> createState() => _DependantFormCardState();
// // }

// class BeneficiaryFormCard extends StatefulWidget {
//   final Beneficiary beneficiary;
//   final bool isCompact;
//   final VoidCallback onRemove;
//   final Function(String field, String value) onChanged;

//   const BeneficiaryFormCard({
//     super.key,
//     required this.beneficiary,
//     required this.isCompact,
//     required this.onRemove,
//     required this.onChanged,
//   });

//   @override
//   _BeneficiaryFormCardState createState() => _BeneficiaryFormCardState();
// }

// class GuardianFormCard extends StatefulWidget {
//   final Guardian guardian;
//   final bool isCompact;
//   final VoidCallback onRemove;
//   final Function(String field, String value) onChanged;

//   const GuardianFormCard({
//     super.key,
//     required this.guardian,
//     required this.isCompact,
//     required this.onRemove,
//     required this.onChanged,
//   });

//   @override
//   _GuardianFormCardState createState() => _GuardianFormCardState();
// }

// class _GuardianFormCardState extends State<GuardianFormCard> {
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _mobileController;
//   late final TextEditingController _idController;
//   late final TextEditingController _relationshipController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.guardian.name);
//     _emailController = TextEditingController(text: widget.guardian.email);
//     _mobileController = TextEditingController(text: widget.guardian.mobile);
//     _idController = TextEditingController(text: widget.guardian.idNo);
//     _relationshipController =
//         TextEditingController(text: widget.guardian.relationshipToMember);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _mobileController.dispose();
//     _idController.dispose();
//     _relationshipController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: widget.isCompact ? 12 : 16),
//       child: Padding(
//         padding: EdgeInsets.all(widget.isCompact ? 12.0 : 16.0),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: widget.onRemove,
//                 color: Colors.red,
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ),
//             LayoutBuilder(builder: (context, constraints) {
//               return constraints.maxWidth > 500
//                   ? _buildTwoColumnFields()
//                   : _buildSingleColumnFields();
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSingleColumnFields() {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('name', 'Full Name', _nameController)),
//             const SizedBox(width: 4),
//             Expanded(
//                 child: _buildTextField('email', 'Email', _emailController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('mobile', 'Mobile', _mobileController)),
//             const SizedBox(width: 4),
//             Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField(
//                     'relationship', 'Relationship', _relationshipController)),
//             const SizedBox(width: 4),
//             const Expanded(child: SizedBox.shrink()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTwoColumnFields() {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('name', 'Full Name', _nameController)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _buildTextField('email', 'Email', _emailController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('mobile', 'Mobile', _mobileController)),
//             const SizedBox(width: 16),
//             Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField(
//                     'relationship', 'Relationship', _relationshipController)),
//             const SizedBox(width: 16),
//             const Expanded(child: SizedBox.shrink()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField(
//       String field, String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Builder(
//         builder: (context) {
//           if (field == 'relationship') {
//             return DropdownButtonFormField<String>(
//               value: controller.text.isEmpty ? null : controller.text,
//               items: ['Mother', 'Father', 'Uncle', 'Aunt', 'Grandparent']
//                   .map((relationship) => DropdownMenuItem(
//                       value: relationship, child: Text(relationship)))
//                   .toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   controller.text = value;
//                   widget.onChanged(field, value);
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please select a $label'
//                   : null,
//             );
//           }
//           if (field == 'mobile') {
//             return IntlPhoneField(
//               controller: controller,
//               initialCountryCode: 'KE',
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               keyboardType: TextInputType.phone,
//               validator: (phone) =>
//                   phone == null || phone.completeNumber.isEmpty
//                       ? 'Please enter a valid $label'
//                       : null,
//               onChanged: (phone) =>
//                   widget.onChanged(field, phone.completeNumber),
//             );
//           }
//           if (field == 'email') {
//             return TextFormField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               validator: (value) {
//                 if (value != null && value.isNotEmpty) {
//                   final emailRegex =
//                       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                   if (!emailRegex.hasMatch(value))
//                     return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//               onChanged: (value) => widget.onChanged(field, value),
//             );
//           }
//           return TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: label,
//               isDense: widget.isCompact,
//               contentPadding: widget.isCompact
//                   ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                   : null,
//             ),
//             onChanged: (value) => widget.onChanged(field, value),
//           );
//         },
//       ),
//     );
//   }
// }

// class _BeneficiaryFormCardState extends State<BeneficiaryFormCard> {
//   // late final TextEditingController _nameController;
//   // late final TextEditingController _dobController;
//   // late final TextEditingController _relationshipController;
//   // late final TextEditingController _idController;
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _mobileController;
//   late final TextEditingController _dobController;
//   late final TextEditingController _idController;
//   late final TextEditingController _relationshipController;
//   late final TextEditingController _sharePercentController;

//   @override
//   // void initState() {
//   //   super.initState();
//   //   _nameController = TextEditingController(text: widget.dependant.name);
//   //   _dobController = TextEditingController(text: widget.dependant.dob);
//   //   _relationshipController =
//   //       TextEditingController(text: widget.dependant.relationship);
//   //   _idController = TextEditingController(text: widget.dependant.idNumber);
//   // }

//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.beneficiary.name);
//     _emailController = TextEditingController(text: widget.beneficiary.email);
//     _mobileController = TextEditingController(text: widget.beneficiary.mobile);
//     _dobController =
//         TextEditingController(text: widget.beneficiary.dateOfBirth);
//     _idController = TextEditingController(text: widget.beneficiary.idNo);
//     _relationshipController =
//         TextEditingController(text: widget.beneficiary.relationshipToMember);
//     _sharePercentController =
//         TextEditingController(text: widget.beneficiary.sharePercent.toString());
//   }

//   @override
//   void dispose() {
//     // _nameController.dispose();
//     // _dobController.dispose();
//     // _relationshipController.dispose();
//     // _idController.dispose();
//     // super.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _mobileController.dispose();
//     _dobController.dispose();
//     _idController.dispose();
//     _relationshipController.dispose();
//     _sharePercentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: widget.isCompact ? 12 : 16),
//       child: Padding(
//         padding: EdgeInsets.all(widget.isCompact ? 12.0 : 16.0),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: widget.onRemove,
//                 color: Colors.red,
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//             ),
//             LayoutBuilder(builder: (context, constraints) {
//               if (constraints.maxWidth > 500) {
//                 return _buildTwoColumnFields();
//               }
//               return _buildSingleColumnFields();
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSingleColumnFields() {
//     return Column(
//       // children: [
//       //   _buildTextField('name', 'Full Name', _nameController),
//       //   _buildTextField(
//       //       'relationship', 'Relationship', _relationshipController),
//       //   _buildTextField('dob', 'Date of Birth', _dobController),
//       //   _buildTextField('idNumber', 'ID / Birth Cert No.', _idController),
//       // ],
//       children: [
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     Expanded(
//         //         child: _buildTextField('name', 'Full Name', _nameController)),
//         //     const SizedBox(width: 4),
//         //     Expanded(
//         //         child: _buildTextField(
//         //             'relationship', 'Relationship', _relationshipController)),
//         //   ],
//         // ),
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     Expanded(
//         //         child: _buildTextField('dob', 'Date of Birth', _dobController)),
//         //     const SizedBox(width: 4),
//         //     Expanded(
//         //         child: _buildTextField(
//         //             'idNumber', 'ID / Birth Cert No.', _idController)),
//         //   ],
//         // ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('name', 'Full Name', _nameController)),
//             const SizedBox(width: 4),
//             Expanded(
//                 child: _buildTextField('email', 'Email', _emailController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('mobile', 'Mobile', _mobileController)),
//             const SizedBox(width: 4),
//             Expanded(
//                 child: _buildTextField(
//                     'dateOfBirth', 'Date of Birth', _dobController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
//             const SizedBox(width: 4),
//             Expanded(
//                 child: _buildTextField(
//                     'relationship', 'Relationship', _relationshipController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField(
//                     'sharePercent', 'Share Percent', _sharePercentController)),
//             const SizedBox(width: 4),
//             const Expanded(child: SizedBox.shrink()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTwoColumnFields() {
//     return Column(
//       children: [
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     Expanded(
//         //         child: _buildTextField('name', 'Full Name', _nameController)),
//         //     const SizedBox(width: 16),
//         //     Expanded(
//         //         child: _buildTextField(
//         //             'relationship', 'Relationship', _relationshipController)),
//         //   ],
//         // ),
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     Expanded(
//         //         child: _buildTextField('dob', 'Date of Birth', _dobController)),
//         //     const SizedBox(width: 16),
//         //     Expanded(
//         //         child: _buildTextField(
//         //             'idNumber', 'ID / Birth Cert No.', _idController)),
//         //   ],
//         // ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('name', 'Full Name', _nameController)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _buildTextField('email', 'Email', _emailController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField('mobile', 'Mobile', _mobileController)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _buildTextField(
//                     'dateOfBirth', 'Date of Birth', _dobController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildTextField('idNo', 'ID No.', _idController)),
//             const SizedBox(width: 16),
//             Expanded(
//                 child: _buildTextField(
//                     'relationship', 'Relationship', _relationshipController)),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: _buildTextField(
//                     'sharePercent', 'Share Percent', _sharePercentController)),
//             const SizedBox(width: 16),
//             const Expanded(child: SizedBox.shrink()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField(
//       String field, String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Builder(
//         builder: (context) {
//           if (field == 'dateOfBirth') {
//             return InkWell(
//               onTap: () async {
//                 DateTime? picked = await showDatePicker(
//                   context: context,
//                   initialDate:
//                       DateTime.now().subtract(const Duration(days: 365 * 18)),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 );
//                 if (picked != null) {
//                   controller.text =
//                       "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//                   widget.onChanged(field, controller.text);
//                 }
//               },
//               child: IgnorePointer(
//                 child: TextFormField(
//                   controller: controller,
//                   decoration: InputDecoration(
//                     labelText: label,
//                     isDense: widget.isCompact,
//                     contentPadding: widget.isCompact
//                         ? const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 8)
//                         : null,
//                   ),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Please enter $label'
//                       : null,
//                 ),
//               ),
//             );
//           }
//           if (field == 'relationship') {
//             return DropdownButtonFormField<String>(
//               value: controller.text.isEmpty ? null : controller.text,
//               items: [
//                 'Spouse',
//                 'Son',
//                 'Daughter',
//                 'Mother',
//                 'Father',
//                 'Sister',
//                 'Brother'
//               ]
//                   .map((relationship) => DropdownMenuItem(
//                       value: relationship, child: Text(relationship)))
//                   .toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   controller.text = value;
//                   widget.onChanged(field, value);
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please select a $label'
//                   : null,
//             );
//           }
//           if (field == 'mobile') {
//             return IntlPhoneField(
//               controller: controller,
//               initialCountryCode: 'KE',
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               keyboardType: TextInputType.phone,
//               validator: (phone) =>
//                   phone == null || phone.completeNumber.isEmpty
//                       ? 'Please enter a valid $label'
//                       : null,
//               onChanged: (phone) =>
//                   widget.onChanged(field, phone.completeNumber),
//             );
//           }
//           if (field == 'email') {
//             return TextFormField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               validator: (value) {
//                 if (value != null && value.isNotEmpty) {
//                   final emailRegex =
//                       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                   if (!emailRegex.hasMatch(value))
//                     return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//               onChanged: (value) => widget.onChanged(field, value),
//             );
//           }
//           if (field == 'sharePercent') {
//             return TextFormField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: label,
//                 isDense: widget.isCompact,
//                 contentPadding: widget.isCompact
//                     ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                     : null,
//               ),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty)
//                   return 'Please enter $label';
//                 final numValue = int.tryParse(value);
//                 if (numValue == null || numValue < 0 || numValue > 100)
//                   return 'Please enter a valid percentage (0-100)';
//                 return null;
//               },
//               onChanged: (value) => widget.onChanged(field, value),
//             );
//           }
//           return TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: label,
//               isDense: widget.isCompact,
//               contentPadding: widget.isCompact
//                   ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
//                   : null,
//             ),
//             onChanged: (value) => widget.onChanged(field, value),
//           );
//         },
//       ),
//     );
//   }
// }

// // // components/steps/beno_dependants_step.dart
