// lib/lib_medica_l_ap_p/widgets/home_page_section/confirm_contact_info_card.dart.dart
import 'dart:convert';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/custom_styled_container.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';

// void popupfxn_with_msg(BuildContext context, String message) {
void popupfxn_with_msg(BuildContext context, String message,
    {bool isError = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // close after 2 sec
      });

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: isError ? Colors.red : Colors.green,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    },
  );
}

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

// Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _kraController = TextEditingController();

  bool _isSubmitting = false;

  // Replace with your real endpoint
  final String _endpoint = 'https://apitoget.com/submit';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _kraController.dispose();
    super.dispose();
  }
  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     // Form is valid, show a success message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //             'Quote saved successfully! Our team will contact you shortly.'),
  //         backgroundColor: AppTheme.textColor,
  //       ),
  //     );
  //   }
  // }

  Future<bool> _submitForm() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) {
      return false; // invalid form
    }

    // optionally save form state if you use onSaved in fields
    _formKey.currentState!.save();

    setState(() => _isSubmitting = true);

    try {
      // Build JSON payload (adjust keys to your API)
      final payload = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'kra_pin': _kraController.text.trim().toUpperCase(),
      };

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text(
        // 'Quote saved successfully! Our team will contact you shortly.'),
        //     backgroundColor: AppTheme.textColor,
        //   ),
        // );

        popupfxn_with_msg(
          context,
          'Quote saved successfully! Proceed.',
        );

        return true;
      } else {
        // show server-side error
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //         'Submission failed (${response.statusCode}): ${response.body}'),
        //     backgroundColor: Colors.red,
        //   ),
        // );

        popupfxn_with_msg(
          context,
          'Submission failed (${response.statusCode}): ${response.body}',
          isError: true,
        );

        return true;
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error submitting: $e'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      popupfxn_with_msg(
        context,
        'Error submitting: $e',
        isError: true,
      );

      return true;
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 32),
      // child: Padding(
      // padding: const EdgeInsets.all(32.0),
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
              _buildTextFormField(
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                // controller: _kraPinController,
                label: 'KRA PIN (Optional)',
                icon: Icons.receipt_long_outlined,

                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^[A-Z]\d{9}[A-Z]$')
                        .hasMatch(value.toUpperCase())) {
                      return 'Enter a valid KRA PIN (e.g. A123456789B)';
                    }
                  }
                  return null; // optional & valid
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  // Expanded(
                  //   child: ElevatedButton(
                  //     // onPressed: _submitForm,
                  //     // onPressed: () async {
                  //     //   final success = await _submitForm();
                  //     //   if (success) {
                  //     //     // context.go('/dashboard');
                  //     //     Navigator.pushNamed(context, '/dashboard');
                  //     //   }
                  //     // },

                  //     onPressed: () async {
                  //       Navigator.pushNamed(context, '/dashboard');
                  //     },

                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(vertical: 16),
                  //     ),
                  //     child: const Text('Save My Quote'),
                  //   ),
                  // ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: NouvaButton(
                      onPressed: () async {
                        bool success = await _submitForm();
                        if (success) {
                          final provider = context.read<AppProvider>();
                          provider.showMpesaCard(() {
                            // _scrollToMpesaComponent();
                            provider
                                .showMpesaCard(widget.onSuccessScrollToMpesa);
                          });
                        } else {
                          final provider = context.read<AppProvider>();
                          provider.showMpesaCard(() {
                            // _scrollToMpesaComponent();
                            provider
                                .showMpesaCard(widget.onSuccessScrollToMpesa);
                          });
                        }
                      },
                      text: 'Submit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  TextFormField _buildTextFormField({
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.primaryColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

// ```dart
// TextFormField _buildTextFormField({
//   required String label,
//   required IconData icon,
//   String? Function(String?)? validator,
//   TextInputType? keyboardType,
//   int? maxLength,
//   TextCapitalization textCapitalization = TextCapitalization.none,
//   TextEditingController? controller,
// }) {
//   return TextFormField(
//     controller: controller,
//     decoration: InputDecoration(
//       labelText: label,
//       prefixIcon: Icon(icon),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//     ),
//     validator: validator,
//     keyboardType: keyboardType,
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     maxLength: maxLength,
//     textCapitalization: textCapitalization,
//   );
// }
// ```

// ---

// ### ✅ Use it for KRA PIN only:

// ```dart
// _buildTextFormField(
//   label: 'KRA PIN (Optional)',
//   icon: Icons.receipt_long_outlined,
//   keyboardType: TextInputType.text,
//   maxLength: 11, // only for KRA
//   textCapitalization: TextCapitalization.characters, // force uppercase
//   validator: (value) {
//     if (value != null && value.isNotEmpty) {
//       if (!RegExp(r'^[A-Z]\d{9}[A-Z]$')
//           .hasMatch(value.toUpperCase())) {
//         return 'Enter a valid KRA PIN (e.g. A123456789B)';
//       }
//     }
//     return null; // optional & valid
//   },
// ),
// ```
