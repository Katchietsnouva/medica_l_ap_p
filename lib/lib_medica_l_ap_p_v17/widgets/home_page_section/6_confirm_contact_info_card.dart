// lib/lib_medica_l_ap_p/widgets/home_page_section/6_confirm_contact_info_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/dob_picker_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field_validators.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactInfoCard extends StatefulWidget {
  final AppProvider provider;
  final VoidCallback onSuccessScrollToMpesa;
  final Key? contactInfoCardKey;

  const ContactInfoCard({
    super.key,
    required this.provider,
    required this.onSuccessScrollToMpesa,
    this.contactInfoCardKey,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _kraController = TextEditingController();
  final _idController = TextEditingController();

  late TextEditingController _spouseNameController;
  late List<TextEditingController> _childNameControllers;

  bool _isSubmitting = false;
  final ValueNotifier<bool> _isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _idController.addListener(_validateForm);
    _kraController.addListener(_validateForm);

    _spouseNameController =
        TextEditingController(text: widget.provider.spouseName);
    _childNameControllers = List.generate(
      widget.provider.childCount,
      (index) =>
          TextEditingController(text: widget.provider.children[index].name),
    );

    _validateForm();
  }

  @override
  void didUpdateWidget(covariant ContactInfoCard oldWidget) {
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _kraController.dispose();
    _idController.dispose();
    _isFormValid.dispose();
    _spouseNameController.dispose();
    for (var controller in _childNameControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _validateForm() {
    final nameValid =
        NouvaValidators.requiredText(_nameController.text) == null;
    final emailValid = NouvaValidators.email(_emailController.text) == null;
    final phoneValid = NouvaValidators.phone(_phoneController.text) == null;
    final idValid = NouvaValidators.requiredText(_idController.text) == null;
    final kraValid = NouvaValidators.kraPin(_kraController.text) == null;
    _isFormValid.value =
        nameValid && emailValid && phoneValid && idValid && kraValid;
  }

  Future<void> _submitForm() async {
    if (_isSubmitting || !_isFormValid.value) return;

    setState(() => _isSubmitting = true);

    final provider = Provider.of<AppProvider>(context, listen: false);

    final dob = provider.myDob;
    final coverAmount = provider.selectedCoverAmount;

    if (dob == null || coverAmount == null) {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
      return;
    }

    final success = await ContactInfoService.submitContactInfo(
      context: context,
      formKey: _formKey,
      nameController: _nameController,
      emailController: _emailController,
      phoneController: _phoneController,
      kraController: _kraController,
      provider: widget.provider,
      onSuccessScrollToMpesa: widget.onSuccessScrollToMpesa,
      principalDob: dob.toIso8601String(),
      limit: coverAmount.toDouble(),
      idController: _idController,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    final showSpouseField = provider.selectedCoverType == CoverType.spouse ||
        provider.selectedCoverType == CoverType.family;
    final showChildrenFields = provider.selectedCoverType == CoverType.family &&
        provider.childCount > 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 32),
      child: Form(
        key: _formKey,
        child: CustomStyledContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Confirm Your Contact Info Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Please provide your details to finalize your quote. We will contact you to complete the payment.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              CustomTextFormField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validatorType: ValidatorType.requiredText,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validatorType: ValidatorType.email,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validatorType: ValidatorType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _idController,
                label: 'National ID Number',
                icon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
                validatorType: ValidatorType.requiredText,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _kraController,
                label: 'KRA PIN (Optional)',
                icon: Icons.receipt_long_outlined,
                keyboardType: TextInputType.text,
                validatorType: ValidatorType.kraPin,
              ),
              const SizedBox(height: 40),
              if (showSpouseField || showChildrenFields) ...[
                const Divider(height: 48),
                Text("Dependant's Details",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text("Please provide the full names for all beneficiaries.",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24),
              ],

              if (showSpouseField)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CustomTextFormField(
                    controller: _spouseNameController,
                    label: "Spouse's Full Name",
                    icon: Icons.favorite_border,
                    validatorType: ValidatorType.requiredText,
                    onChanged: (value) => provider.setSpouseName(value),
                  ),
                ),

              if (showChildrenFields)
                ...List.generate(provider.childCount, (index) {
                  return _buildChildInputRow(context, index);
                }),

              // --- FINAL SUBMIT BUTTON ---
              const SizedBox(height: 40),
              ValueListenableBuilder<bool>(
                valueListenable: _isFormValid,
                builder: (context, isValid, child) {
                  return _isSubmitting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : NouvaButton(
                          onPressed:
                              _isSubmitting || !isValid ? null : _submitForm,
                          text: 'Submit & Proceed to Payment',
                          isFullWidth: true,
                          // isLoading: _isSubmitting,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildInputRow(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _childNameControllers[index],
              label: 'Child ${index + 1} Name',
              icon: Icons.child_care_outlined,
              validatorType: ValidatorType.requiredText,
              onChanged: (value) =>
                  widget.provider.updateChildName(index, value),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DobPickerField(
              label: 'Child ${index + 1} DOB',
              selectedDate: widget.provider.children[index].dob,
              onDateSelected: (date) =>
                  widget.provider.updateChildDob(index, date),
            ),
          ),
        ],
      ),
    );
  }
}
