// components/steps/beno_payment_step.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/steps/beno_personal_details_step.dart';
import 'package:flutter/material.dart';
import '../../models/beno_project_model.dart';
import '../ui/beno_ui_components.dart';
import 'dart:math' as math;
import '../../helpers/responsive_helper.dart';

enum PaymentMethod { card, mpesa }

class BenoPaymentStep extends StatefulWidget {
  final BenoFormDataType formData;
  // final BenoPaymentDetails paymentDetails;

  final Function(BenoFormDataType) onUpdate;
  final VoidCallback nextStep;
  final VoidCallback prevStep;

  const BenoPaymentStep({
    super.key,
    required this.formData,
    // required this.paymentDetails,
    required this.onUpdate,
    required this.nextStep,
    required this.prevStep,
  });

  @override
  // State<BenoPaymentStep> createState() => _BenoPaymentStepState();
  _BenoPaymentStepState createState() => _BenoPaymentStepState();
}

class _BenoPaymentStepState extends State<BenoPaymentStep> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  // PaymentMethod _selectedMethod = PaymentMethod.card;
  // late final TextEditingController _cardNameController;
  // late final TextEditingController _cardNumberController;
  // late final TextEditingController _expiryDateController;
  // late final TextEditingController _cvcController;
  // // late final TextEditingController _mpesaPhoneController;
  // late String? _selectedMpesaNumber;

  @override
  void initState() {
    super.initState();
    // Set the initial payment method to M-Pesa
    // _selectedMethod = PaymentMethod.mpesa;

    // // final details = widget.formData.paymentDetails;
    // final paymentDetails = widget.formData.paymentDetails;
    // final personalDetails = widget.formData.personalDetails;
    // _cardNameController = TextEditingController(text: paymentDetails.cardName);
    // _cardNumberController = TextEditingController(text: paymentDetails.cardNumber);
    // _expiryDateController = TextEditingController(text: paymentDetails.expiryDate);
    // _cvcController = TextEditingController(text: paymentDetails.cvc);
    // _selectedMpesaNumber = personalDetails.paymentPhoneNumber ??
    //     (personalDetails.phoneNumbers.isNotEmpty ? personalDetails.phoneNumbers.first : null);

    _controllers = {
      'accountName':
          TextEditingController(text: widget.formData.sectionB.accountName),
      'bankName':
          TextEditingController(text: widget.formData.sectionB.bankName),
      'bankBranch':
          TextEditingController(text: widget.formData.sectionB.bankBranch),
      'accountNumber':
          TextEditingController(text: widget.formData.sectionB.accountNumber),
      'townCity':
          TextEditingController(text: widget.formData.sectionB.townCity),
      'bankCode':
          TextEditingController(text: widget.formData.sectionB.bankCode),
      'branchCode':
          TextEditingController(text: widget.formData.sectionB.branchCode),
      'swiftCode':
          TextEditingController(text: widget.formData.sectionB.swiftCode),
      'sortCodeIban':
          TextEditingController(text: widget.formData.sectionB.sortCodeIban),
    };
  }

  @override
  void dispose() {
    // _cardNameController.dispose();
    // _cardNumberController.dispose();
    // _expiryDateController.dispose();
    // _cvcController.dispose();
    // // _mpesaPhoneController.dispose();
    _controllers.forEach((_, controller) => controller.dispose());
    // super.dispose();
    super.dispose();
  }

  void _onUpdate() {
    // // final updatedDetails = BenoPaymentDetails(
    // widget.formData.paymentDetails = BenoPaymentDetails(
    //   cardName: _cardNameController.text,
    //   cardNumber: _cardNumberController.text,
    //   expiryDate: _expiryDateController.text,
    //   cvc: _cvcController.text,
    //   // mpesaPhoneNumber: _mpesaPhoneController.text,
    // );
    // // widget.formData.paymentDetails = updatedDetails;
    // // ✅ Update the selected payment phone number

    if (_formKey.currentState!.validate()) {
      widget.formData.sectionB = SectionB(
        accountName: _controllers['accountName']!.text,
        bankName: _controllers['bankName']!.text,
        bankBranch: _controllers['bankBranch']!.text,
        accountNumber: _controllers['accountNumber']!.text,
        townCity: _controllers['townCity']!.text,
        bankCode: _controllers['bankCode']!.text,
        branchCode: _controllers['branchCode']!.text,
        swiftCode: _controllers['swiftCode']!.text,
        sortCodeIban: _controllers['sortCodeIban']!.text,
      );
      widget.onUpdate(widget.formData);
      widget.nextStep();
    }
    // widget.formData.personalDetails.paymentPhoneNumber = _selectedMpesaNumber;
    // widget.onUpdate(widget.formData);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 600;
      final isPhone = constraints.maxWidth < 420;
      final double maxFormWidth = isNarrow ? double.infinity : 600;
      final double horizontalPadding =
          isPhone ? 12.0 : (isNarrow ? 16.0 : 32.0);
      final double titleSize = responsiveFontSize(context,
          baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));
      final premium = widget.formData.plan == 'Premium' ? '2,560' : '1,560';

      return Center(
        child: BenoCard(
          maxWidth: maxFormWidth,
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Step 3: Bank Details',
                      style: TextStyle(
                          fontSize: titleSize, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your bank information for payment processing.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  //   ),
                  // child: Column(
                  //   children: [
                  //     Text("Plan Selected: ${widget.formData.plan}",
                  //         style:
                  //             const TextStyle(fontWeight: FontWeight.bold)),
                  //     const SizedBox(height: 4),
                  //     Text("Annual Premium: Ksh. $premium",
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headlineSmall
                  //             ?.copyWith(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.blue[800])),
                  //   ],
                  // ),
                  // ),
                  const SizedBox(height: 24),
                  LayoutBuilder(builder: (context, inner) {
                    return inner.maxWidth > 600
                        ? _buildTwoColumnFields(
                            // spacing: verticalSpacing, compact: isPhone)
                            spacing: 10,
                            compact: isPhone)
                        : _buildSingleColumnFields(
                            spacing: 10, compact: isPhone);
                  }),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BenoButton(
                        onPressed: widget.prevStep,
                        text: 'Back',
                        compact: isPhone,
                        isOutline: true,
                      ),
                      BenoButton(
                        onPressed: _onUpdate,
                        compact: isPhone,
                        text: 'Review & Confirm',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSingleColumnFields({double spacing = 16, bool compact = false}) {
    final entries = _controllers.entries.toList();
    return Column(
      children: List.generate((entries.length / 2).ceil(), (rowIndex) {
        final firstIndex = rowIndex * 2;
        final secondIndex = firstIndex + 1;
        return Padding(
          padding: EdgeInsets.only(bottom: spacing / 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                    entries[firstIndex].key, entries[firstIndex].value,
                    compact: compact),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: secondIndex < entries.length
                    ? _buildTextField(
                        entries[secondIndex].key, entries[secondIndex].value,
                        compact: compact)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTwoColumnFields({double spacing = 16, bool compact = false}) {
    final entries = _controllers.entries.toList();
    return Column(
      children: List.generate((entries.length / 2).ceil(), (rowIndex) {
        final firstIndex = rowIndex * 2;
        final secondIndex = firstIndex + 1;
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                    entries[firstIndex].key, entries[firstIndex].value,
                    compact: compact),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: secondIndex < entries.length
                    ? _buildTextField(
                        entries[secondIndex].key, entries[secondIndex].value,
                        compact: compact)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String key, TextEditingController controller,
      {required bool compact}) {
    final label = key
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
        .capitalize();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          isDense: compact,
          contentPadding: compact
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
              : null,
        ),
        keyboardType:
            key == 'accountNumber' || key == 'bankCode' || key == 'branchCode'
                ? TextInputType.number
                : TextInputType.text,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  // Widget _buildTextField(
  //     String label, TextEditingController controller, bool isCompact,
  //     {TextInputType? keyboardType}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16.0),
  //     child: TextFormField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         isDense: isCompact,
  //         contentPadding: isCompact
  //             ? const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
  //             : null,
  //       ),
  //       keyboardType: keyboardType,
  //     ),
  //   );
  // }
}

// // components/steps/beno_payment_step.dart
// // NOTE: This is for the multi-step form, not the standalone payment page.
// import 'package:flutter/material.dart';
// import '../../models/beno_project_model.dart';
// import '../ui/beno_ui_components.dart';

// class BenoPaymentStep extends StatelessWidget {
//   final BenoPaymentDetails paymentDetails;
//   final Function(BenoPaymentDetails) onUpdate;
//   final VoidCallback nextStep;
//   final VoidCallback prevStep;

//   const BenoPaymentStep({
//     super.key,
//     required this.paymentDetails,
//     required this.onUpdate,
//     required this.nextStep,
//     required this.prevStep,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BenoCard(
//       maxWidth: 600,
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Step 3: Payment Details',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 8),
//             Text('Enter your payment information to cover the annual premium.',
//                 style: Theme.of(context).textTheme.bodyMedium),
//             const SizedBox(height: 24),
//             TextFormField(
//               initialValue: paymentDetails.cardName,
//               decoration: const InputDecoration(labelText: "Name on Card"),
//               onChanged: (val) => onUpdate(BenoPaymentDetails(
//                   cardName: val,
//                   cardNumber: paymentDetails.cardNumber,
//                   expiryDate: paymentDetails.expiryDate,
//                   cvc: paymentDetails.cvc)),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               initialValue: paymentDetails.cardNumber,
//               decoration: const InputDecoration(labelText: "Card Number"),
//               onChanged: (val) => onUpdate(BenoPaymentDetails(
//                   cardName: paymentDetails.cardName,
//                   cardNumber: val,
//                   expiryDate: paymentDetails.expiryDate,
//                   cvc: paymentDetails.cvc)),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     initialValue: paymentDetails.expiryDate,
//                     decoration:
//                         const InputDecoration(labelText: "Expiry Date (MM/YY)"),
//                     onChanged: (val) => onUpdate(BenoPaymentDetails(
//                         cardName: paymentDetails.cardName,
//                         cardNumber: paymentDetails.cardNumber,
//                         expiryDate: val,
//                         cvc: paymentDetails.cvc)),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: TextFormField(
//                     initialValue: paymentDetails.cvc,
//                     decoration: const InputDecoration(labelText: "CVC"),
//                     onChanged: (val) => onUpdate(BenoPaymentDetails(
//                         cardName: paymentDetails.cardName,
//                         cardNumber: paymentDetails.cardNumber,
//                         expiryDate: paymentDetails.expiryDate,
//                         cvc: val)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BenoButton(onPressed: prevStep, text: 'Back', isOutline: true),
//                 BenoButton(onPressed: nextStep, text: 'Review & Confirm'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
