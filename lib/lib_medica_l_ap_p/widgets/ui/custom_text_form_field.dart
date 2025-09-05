// lib/widgets/common/custom_text_form_field.dart
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/custom_text_form_field_validators.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final ValidatorType validatorType;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? hintText;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    this.validatorType = ValidatorType.none,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValidator =
        validator ?? NouvaValidators.getValidator(validatorType);
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        // prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        prefixIcon: Icon(
          icon,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(color: Colors.grey.shade400),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        // ),
      ),
      validator: effectiveValidator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
    );
  }
}
