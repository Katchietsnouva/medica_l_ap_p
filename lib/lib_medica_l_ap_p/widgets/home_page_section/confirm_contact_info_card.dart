// lib/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field_validators.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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
  bool _isSubmitting = false;
  final ValueNotifier<bool> _isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _kraController.addListener(_validateForm);
    _validateForm();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _kraController.dispose();
    _isFormValid.dispose();
    super.dispose();
  }

  void _validateForm() {
    final nameValid =
        NouvaValidators.requiredText(_nameController.text) == null;
    final emailValid = NouvaValidators.email(_emailController.text) == null;
    final phoneValid = NouvaValidators.phone(_phoneController.text) == null;
    final kraValid = NouvaValidators.kraPin(_kraController.text) == null;
    _isFormValid.value = nameValid && emailValid && phoneValid && kraValid;
  }

  Future<void> _submitForm() async {
    if (_isSubmitting || !_isFormValid.value) return;

    setState(() => _isSubmitting = true);

    final success = await ContactInfoService.submitContactInfo(
      context: context,
      formKey: _formKey,
      nameController: _nameController,
      emailController: _emailController,
      phoneController: _phoneController,
      kraController: _kraController,
      provider: widget.provider,
      onSuccessScrollToMpesa: widget.onSuccessScrollToMpesa,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _kraController,
                label: 'KRA PIN (Optional)',
                icon: Icons.receipt_long_outlined,
                keyboardType: TextInputType.text,
                validatorType: ValidatorType.kraPin,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isFormValid,
                      builder: (context, isValid, child) {
                        return NouvaButton(
                          onPressed:
                              _isSubmitting || !isValid ? null : _submitForm,
                          text: 'Submit',
                          isFullWidth: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
