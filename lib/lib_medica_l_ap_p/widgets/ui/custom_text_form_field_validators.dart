// lib/lib_medica_l_ap_p/widgets/ui/custom_text_form_field_validators.dart
enum ValidatorType {
  email,
  phone,
  kraPin,
  requiredText,
  none,
}

class NouvaValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^(0)[17]\d{8}$').hasMatch(value)) {
      return 'Enter a valid Safaricom number';
    }
    return null;
  }

  static String? kraPin(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[A-Z]\d{9}[A-Z]$').hasMatch(value.toUpperCase())) {
        return 'Enter a valid KRA PIN (e.g. A123456789B)';
      }
    }
    return null;
  }

  static String? requiredText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? Function(String?)? getValidator(ValidatorType type) {
    switch (type) {
      case ValidatorType.email:
        return email;
      case ValidatorType.phone:
        return phone;
      case ValidatorType.kraPin:
        return kraPin;
      case ValidatorType.requiredText:
        return requiredText;
      case ValidatorType.none:
        return null;
    }
  }
}
