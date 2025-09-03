import 'dart:convert';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/popup_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ContactInfoService {
  static const String _authEndpoint = 'https://royal.inscloud.net/api/auth';
  static const String _quoteEndpoint =
      'https://royal.inscloud.net/api/medical_quote';

  // static const String _quoteEndpoint = 'https://royal.inscloud.net/api/medical_quote';

  static const String _inscloudKey =
      r'$2y$12$Yp/PEdXkZeKt5VwrW4yBS.Uk6/4Z3n7D6xvmyFir3/ohUFQFhTZjC';
  static const String _passkey = '00A8A073114C99FB01A54C07A97F5E';

  static const String _coverGetter =
      'https://royal.inscloud.net/api/medical_limits';

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

  // --- ADD THIS NEW METHOD ---
  static Future<List<Map<String, dynamic>>> fetchMedicalPlans(
    BuildContext context,
    AppProvider provider,
  ) async {
    final token = await _getAuthToken();
    if (token == null) {
      showPopupDialog(context,
          message: 'Authentication failed.', isError: true);
      return [];
    }

    // Ensure we have the necessary data from the provider
    if (provider.myDob == null || provider.selectedCoverAmount == null) {
      // Don't make the call if essential data is missing
      return [];
    }

    try {
      // 1. Build the payload from the provider's state
      final payload = {
        "insurer": 1,
        "principal_dob": DateFormat('yyyy-MM-dd').format(provider.myDob!),
        "spouse_age": provider.spouseDob != null
            ? DateFormat('yyyy-MM-dd').format(provider.spouseDob!)
            : "",
        "children": provider.childCount,
        "limit": provider.selectedCoverAmount,
        "ipp": false,
        "ips": true,
        "op": false,
        "ops": false,
        "meternity": false,
        "dental": false,
        "optical": false,
        "lastexpense": false,
        "pa": false
      };

      final response = await http.post(
        Uri.parse(_quoteEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 2. Parse and flatten the complex JSON into a simple list
        final List<Map<String, dynamic>> plans = [];
        final options = data['options'] as List<dynamic>;

        for (var insurerData in options) {
          final String insurerName = insurerData['insurer'];
          final insurerPlans = insurerData['plans'] as List<dynamic>;

          for (var planData in insurerPlans) {
            final String planName = planData['Plan'];
            final planOptions = planData['Options'] as List<dynamic>;

            for (var optionData in planOptions) {
              final int coverage = optionData['limit'];
              final rates =
                  optionData['rates']['INPATIENT SHARED'] as List<dynamic>;

              if (rates.isNotEmpty) {
                final int premium = rates[0]['premium'];
                plans.add({
                  'insurer': insurerName,
                  'planName': planName,
                  'coverage': coverage,
                  'premium': premium,
                });
              }
            }
          }
        }
        return plans;
      } else {
        showPopupDialog(context,
            message: 'Failed to load plans: ${response.body}', isError: true);
        return [];
      }
    } catch (e) {
      showPopupDialog(context,
          message: 'Error fetching plans: $e', isError: true);
      return [];
    }
  }

  // static Future<void> fetchMedicalLimits(BuildContext context) async {
  static Future<List<Map<String, dynamic>>> fetchMedicalLimits(
      BuildContext context) async {
    final token = await _getAuthToken();

    if (token == null) {
      showPopupDialog(
        context,
        message: 'Failed to authenticate for limits.',
        isError: true,
        showButton: false,
      );
      return [];
    }

    try {
      final response = await http.post(
        Uri.parse(_coverGetter),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Medical Limits: $data');
        return List<Map<String, dynamic>>.from(data);
      } else {
        showPopupDialog(
          context,
          message:
              'Failed to load limits. (${response.statusCode}): ${response.body}',
          isError: true,
          showButton: false,
        );
        return [];
      }
    } catch (e) {
      showPopupDialog(
        context,
        message: 'Error fetching limits: $e',
        isError: true,
        showButton: false,
      );
      return [];
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
    required String principalDob,
    required double limit,
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
        'principal_dob': principalDob,
        'limit': limit,
      };

      print('Payload being sent: $payload');

      final response = await http.post(
        Uri.parse(_quoteEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
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

  // inside ContactInfoService

  static Future<List<Map<String, dynamic>>> fetchPlans({
    required BuildContext context,
    required Map<String, dynamic> payload,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      showPopupDialog(
        context,
        message: 'Failed to authenticate for plans.',
        isError: true,
        showButton: false,
      );
      return [];
    }

    try {
      final response = await http.post(
        Uri.parse(_quoteEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Plans response: $data');

        if (data['status'] == 'success' && data['options'] != null) {
          final insurerBlock = data['options'][0];
          final insurer = insurerBlock['insurer'];

          final plans = (insurerBlock['plans'] as List).expand((plan) {
            final planName = plan['Plan'];
            final options = plan['Options'] as List;

            return options.map((opt) {
              return {
                'insurer': insurer,
                'plan': planName,
                'option': opt['Option'],
                'limit': opt['limit'],
                'premium': opt['rates']['INPATIENT SHARED'][0]['premium'],
              };
            });
          }).toList();

          return plans.cast<Map<String, dynamic>>();
        } else {
          return [];
        }
      } else {
        showPopupDialog(
          context,
          message: 'Failed to load plans (${response.statusCode}).',
          isError: true,
          showButton: false,
        );
        return [];
      }
    } catch (e) {
      showPopupDialog(
        context,
        message: 'Error fetching plans: $e',
        isError: true,
        showButton: false,
      );
      return [];
    }
  }
}



// class ApiService {
//   static const String _coverGetter =
//       'https://royal.inscloud.net/api/medical_limits';

//   Future<void> fetchMedicalLimits() async {
//     try {
//       final response = await http.get(Uri.parse(_coverGetter));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Medical Limits: $data');
//       } else {
//         print('Failed to load data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   final response = await http.get(
//   Uri.parse(_coverGetter),
//   headers: {
//     'Authorization': 'Bearer YOUR_TOKEN_HERE',
//     'Content-Type': 'application/json',
//   },
// );
// }


