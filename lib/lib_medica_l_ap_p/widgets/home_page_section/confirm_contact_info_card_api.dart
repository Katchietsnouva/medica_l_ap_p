// lib/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card_api.dart
import 'dart:convert';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/popup_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactInfoService {
  static const String _authEndpoint = 'https://royal.inscloud.net/api/auth';

  static const String _quoteEndpoint =
      'https://royal.inscloud.net/api/medical_quote';

  static const String _inscloudKey =
      r'$2y$12$Yp/PEdXkZeKt5VwrW4yBS.Uk6/4Z3n7D6xvmyFir3/ohUFQFhTZjC';
  static const String _passkey = '00A8A073114C99FB01A54C07A97F5E';

  static Future<String?> _getAuthToken() async {
    try {
      final authPayload = {
        'inscloudkey': _inscloudKey,
        'passkey': _passkey,
      };

      final authResponse = await http.post(
        Uri.parse(_authEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(authPayload),
      );

      if (authResponse.statusCode == 200 || authResponse.statusCode == 201) {
        final responseData = jsonDecode(authResponse.body);
        return responseData['token'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

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

    final token = await _getAuthToken();
    if (token == null) {
      showPopupDialog(
        context,
        message: 'Failed to authenticate with the server.',
        isError: true,
        showButton: false,
      );
      return false;
    }

    try {
      final payload = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'kra_pin': kraController.text.trim().toUpperCase(),
      };

      final response = await http.post(
        Uri.parse(_quoteEndpoint),
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
