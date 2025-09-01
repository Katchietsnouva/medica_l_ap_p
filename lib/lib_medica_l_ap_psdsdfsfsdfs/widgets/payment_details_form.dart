// lib/widgets/payment_details_form.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PaymentDetailsForm extends StatefulWidget {
  const PaymentDetailsForm({super.key});

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  final _formKey = GlobalKey<FormState>();

// Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _kraController = TextEditingController();

  bool _isSubmitting = false;

  // Replace with your real endpoint
  final String _endpoint = 'https://api.com/submit';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Quote saved successfully! Our team will contact you shortly.'),
            backgroundColor: AppTheme.textColor,
          ),
        );
        return true;
      } else {
        // show server-side error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Submission failed (${response.statusCode}): ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
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
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.secondaryColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.85),
                blurRadius: 12,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Confirm Your Details',
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
                  Expanded(
                    child: ElevatedButton(
                      // onPressed: _submitForm,
                      // onPressed: () async {
                      //   final success = await _submitForm();
                      //   if (success) {
                      //     // context.go('/dashboard');
                      //     Navigator.pushNamed(context, '/dashboard');
                      //   }
                      // },

                      onPressed: () async {
                        Navigator.pushNamed(context, '/dashboard');
                      },

                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Save My Quote'),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppTheme.backgroundColor,
                      ),
                      child: const Text('Submit'),
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
