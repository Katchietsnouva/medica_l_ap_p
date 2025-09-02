// lib/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart
import 'dart:convert';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactInfoService {
  static const String _endpoint = 'https://apitoget.com/submit';

  static Future<bool> submitContactInfo({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController kraController,
    required AppProvider provider,
    required VoidCallback onSuccessScrollToMpesa,
  }) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    try {
      final payload = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'kra_pin': kraController.text.trim().toUpperCase(),
      };

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showPopupDialog(
          context,
          message: 'Quote saved successfully! Proceed.',
          autoCloseDuration: const Duration(seconds: 2),
          showButton: false,
        );

        provider.showMpesaCard(() {
          provider.showMpesaCard(onSuccessScrollToMpesa);
        });

        return true;
      } else {
        showPopupDialog(
          context,
          message:
              'Submission failed (${response.statusCode}): ${response.body}',
          isError: true,
          showButton: false,
        );
        return false;
      }
    } catch (e) {
      showPopupDialog(
        context,
        message: 'Error submitting: $e',
        isError: true,
        showButton: false,
      );
      return false;
    }
  }
}
