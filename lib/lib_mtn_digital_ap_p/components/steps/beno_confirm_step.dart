import 'package:flutter/material.dart';
import '../../models/beno_project_model.dart';
import '../ui/beno_ui_components.dart';
import '../../helpers/responsive_helper.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class BenoConfirmStep extends StatelessWidget {
  final BenoFormDataType formData;
  final VoidCallback prevStep;
  final VoidCallback handleSubmit;

  const BenoConfirmStep({
    super.key,
    required this.formData,
    required this.prevStep,
    required this.handleSubmit,
  });

  // Future<void> _submitForm(BuildContext context) async {
  //   const url = 'https://demo.inscloud.net/api/jubilee_umbrella_enrollments';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(formData.toJson()),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Submission successful!')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content:
  //                 Text('Error: ${response.statusCode} - ${response.body}')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to submit: $e')),
  //     );
  //   }
  // }

  Future<void> _submitForm(BuildContext context) async {
    const url = 'https://mtn.inscloud.net/api/jubilee_umbrella_enrollments';

    try {
      final jsonBody = jsonEncode(formData.toJson());

      debugPrint('----> Submitting data to $url');
      debugPrint('----> Payload: $jsonBody');

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('----> Submission successful!')),
        );
        print('----> Submission successful!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${response.statusCode} - ${response.body}'),
          ),
        );
        print('❌ Submission failed with status ${response.statusCode}');
        print('❌ Error response body: ${response.body}');
      }
    } catch (error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🛑 Failed to submit: $error')),
      );
      print('🛑 Exception occurred during submission: $error');
      print('🧵 StackTrace:\n$stackTrace');

      log('Form submission error', error: error, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 600;
      final isPhone = constraints.maxWidth < 420;
      final double maxFormWidth = isNarrow
          ? math.min(constraints.maxWidth, 420)
          : math.min(constraints.maxWidth, 900);
      final double horizontalPadding = isPhone ? 8.0 : (isNarrow ? 16.0 : 32.0);
      final double verticalSpacing = isPhone ? 12.0 : (isNarrow ? 20.0 : 28.0);
      final double titleSize = responsiveFontSize(context,
          baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));

      return Center(
        child: BenoCard(
          maxWidth: maxFormWidth + horizontalPadding * 2,
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Step 4: Confirm & Submit",
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold)),
                SizedBox(height: verticalSpacing),
                Text("Please review your details before submitting.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey)),
                SizedBox(height: verticalSpacing),
                _buildSectionA(context),
                SizedBox(height: verticalSpacing),
                _buildSectionB(context),
                SizedBox(height: verticalSpacing),
                _buildSectionC(context),
                SizedBox(height: verticalSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BenoButton(
                      onPressed: prevStep,
                      text: 'Back',
                      isOutline: true,
                      compact: isPhone,
                    ),
                    BenoButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submitting...')),
                        );
                        await _submitForm(context);
                        handleSubmit();
                      },
                      text: 'Submit',
                      compact: isPhone,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSectionA(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Personal Details", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        _buildDetailRow("Employer Name", formData.sectionA.employerName),
        _buildDetailRow("Occupation", formData.sectionA.occupation),
        _buildDetailRow("Member Full Name", formData.sectionA.memberFullName),
        _buildDetailRow("Member Number", formData.sectionA.memberNumber),
        _buildDetailRow("Date of Birth", formData.sectionA.dateOfBirth),
        _buildDetailRow(
            "Date of Appointment", formData.sectionA.dateOfAppointment),
        _buildDetailRow("Date of Admission", formData.sectionA.dateOfAdmission),
        _buildDetailRow(
            "Date of Commencement", formData.sectionA.dateOfCommencement),
        _buildDetailRow("KRA PIN", formData.sectionA.kraPin),
        _buildDetailRow("ID No.", formData.sectionA.idNo),
        _buildDetailRow("Phone", formData.sectionA.phone),
        _buildDetailRow("Email", formData.sectionA.email),
        _buildDetailRow("Voluntary Amount",
            formData.sectionA.voluntaryAmount?.toString() ?? 'N/A'),
        _buildDetailRow("Voluntary Percent",
            formData.sectionA.voluntaryPercent?.toString() ?? 'N/A'),
      ],
    );
  }

  Widget _buildSectionB(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bank Details", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        _buildDetailRow("Account Name", formData.sectionB.accountName),
        _buildDetailRow("Bank Name", formData.sectionB.bankName),
        _buildDetailRow("Bank Branch", formData.sectionB.bankBranch),
        _buildDetailRow("Account Number", formData.sectionB.accountNumber),
        _buildDetailRow("Town/City", formData.sectionB.townCity),
        _buildDetailRow("Bank Code", formData.sectionB.bankCode),
        _buildDetailRow("Branch Code", formData.sectionB.branchCode),
        _buildDetailRow("Swift Code", formData.sectionB.swiftCode),
        _buildDetailRow("Sort Code/IBAN", formData.sectionB.sortCodeIban),
      ],
    );
  }

  Widget _buildSectionC(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Beneficiaries & Guardians",
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text("Beneficiaries", style: Theme.of(context).textTheme.titleMedium),
        if (formData.sectionC.beneficiaries.isEmpty)
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("No beneficiaries added."))
        else
          ...formData.sectionC.beneficiaries.asMap().entries.map((entry) {
            final index = entry.key;
            final ben = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Beneficiary ${index + 1}",
                    style: Theme.of(context).textTheme.titleSmall),
                _buildDetailRow("Name", ben.name),
                _buildDetailRow("Email", ben.email ?? 'N/A'),
                _buildDetailRow("Mobile", ben.mobile),
                _buildDetailRow("Date of Birth", ben.dateOfBirth),
                _buildDetailRow("ID No.", ben.idNo ?? 'N/A'),
                _buildDetailRow("Relationship", ben.relationshipToMember),
                _buildDetailRow("Share Percent", "${ben.sharePercent}%"),
                const SizedBox(height: 8),
              ],
            );
          }),
        Text("Guardians", style: Theme.of(context).textTheme.titleMedium),
        if (formData.sectionC.guardians.isEmpty)
          const Padding(
              padding: EdgeInsets.all(8.0), child: Text("No guardians added."))
        else
          ...formData.sectionC.guardians.asMap().entries.map((entry) {
            final index = entry.key;
            final guard = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Guardian ${index + 1}",
                    style: Theme.of(context).textTheme.titleSmall),
                _buildDetailRow("Name", guard.name),
                _buildDetailRow("Email", guard.email ?? 'N/A'),
                _buildDetailRow("Mobile", guard.mobile),
                _buildDetailRow("ID No.", guard.idNo ?? 'N/A'),
                _buildDetailRow("Relationship", guard.relationshipToMember),
                const SizedBox(height: 8),
              ],
            );
          }),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}

// // components/steps/beno_confirm_step.dart
// import 'package:flutter/material.dart';
// import '../../models/beno_project_model.dart';
// import '../ui/beno_ui_components.dart';
// import '../../helpers/responsive_helper.dart';
// import 'dart:math' as math;

// class BenoConfirmStep extends StatelessWidget {
//   final BenoFormDataType formData;
//   final VoidCallback prevStep;
//   final VoidCallback handleSubmit;

//   const BenoConfirmStep({
//     super.key,
//     required this.formData,
//     required this.prevStep,
//     required this.handleSubmit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final isNarrow = constraints.maxWidth < 600;
//       final isPhone = constraints.maxWidth < 420;
//       final double maxFormWidth = isNarrow
//           ? math.min(constraints.maxWidth, 420)
//           : math.min(constraints.maxWidth, 900);
//       final double horizontalPadding = isPhone ? 8.0 : (isNarrow ? 16.0 : 32.0);
//       final double verticalSpacing = isPhone ? 12.0 : (isNarrow ? 20.0 : 28.0);
//       final double titleSize = responsiveFontSize(context,
//           baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));

//       return Center(
//         child: BenoCard(
//           maxWidth: maxFormWidth + horizontalPadding * 2,
//           child: Padding(
//             padding: EdgeInsets.all(horizontalPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Step 4: Confirm & Submit",
//                     style: TextStyle(
//                         fontSize: titleSize, fontWeight: FontWeight.bold)),
//                 SizedBox(height: verticalSpacing),
//                 Text("Please review your details before submitting.",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge
//                         ?.copyWith(color: Colors.grey)),
//                 SizedBox(height: verticalSpacing),
//                 _buildSectionA(context),
//                 SizedBox(height: verticalSpacing),
//                 _buildSectionB(context),
//                 SizedBox(height: verticalSpacing),
//                 _buildSectionC(context),
//                 SizedBox(height: verticalSpacing),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     BenoButton(
//                       onPressed: prevStep,
//                       text: 'Back',
//                       isOutline: true,
//                       compact: isPhone,
//                     ),
//                     BenoButton(
//                       onPressed: handleSubmit,
//                       text: 'Submit',
//                       compact: isPhone,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildSectionA(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Personal Details", style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 8),
//         _buildDetailRow("Employer Name", formData.sectionA.employerName),
//         _buildDetailRow("Occupation", formData.sectionA.occupation),
//         _buildDetailRow("Member Full Name", formData.sectionA.memberFullName),
//         _buildDetailRow("Member Number", formData.sectionA.memberNumber),
//         _buildDetailRow("Date of Birth", formData.sectionA.dateOfBirth),
//         _buildDetailRow(
//             "Date of Appointment", formData.sectionA.dateOfAppointment),
//         _buildDetailRow("Date of Admission", formData.sectionA.dateOfAdmission),
//         _buildDetailRow(
//             "Date of Commencement", formData.sectionA.dateOfCommencement),
//         _buildDetailRow("KRA PIN", formData.sectionA.kraPin),
//         _buildDetailRow("ID No.", formData.sectionA.idNo),
//         _buildDetailRow("Phone", formData.sectionA.phone),
//         _buildDetailRow("Email", formData.sectionA.email),
//         _buildDetailRow("Voluntary Amount",
//             formData.sectionA.voluntaryAmount?.toString() ?? 'N/A'),
//         _buildDetailRow("Voluntary Percent",
//             formData.sectionA.voluntaryPercent?.toString() ?? 'N/A'),
//       ],
//     );
//   }

//   Widget _buildSectionB(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Bank Details", style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 8),
//         _buildDetailRow("Account Name", formData.sectionB.accountName),
//         _buildDetailRow("Bank Name", formData.sectionB.bankName),
//         _buildDetailRow("Bank Branch", formData.sectionB.bankBranch),
//         _buildDetailRow("Account Number", formData.sectionB.accountNumber),
//         _buildDetailRow("Town/City", formData.sectionB.townCity),
//         _buildDetailRow("Bank Code", formData.sectionB.bankCode),
//         _buildDetailRow("Branch Code", formData.sectionB.branchCode),
//         _buildDetailRow("Swift Code", formData.sectionB.swiftCode),
//         _buildDetailRow("Sort Code/IBAN", formData.sectionB.sortCodeIban),
//       ],
//     );
//   }

//   Widget _buildSectionC(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Beneficiaries & Guardians",
//             style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 8),
//         Text("Beneficiaries", style: Theme.of(context).textTheme.titleMedium),
//         if (formData.sectionC.beneficiaries.isEmpty)
//           const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text("No beneficiaries added."))
//         else
//           ...formData.sectionC.beneficiaries.asMap().entries.map((entry) {
//             final index = entry.key;
//             final ben = entry.value;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Beneficiary ${index + 1}",
//                     style: Theme.of(context).textTheme.titleSmall),
//                 _buildDetailRow("Name", ben.name),
//                 _buildDetailRow("Email", ben.email ?? 'N/A'),
//                 _buildDetailRow("Mobile", ben.mobile),
//                 _buildDetailRow("Date of Birth", ben.dateOfBirth),
//                 _buildDetailRow("ID No.", ben.idNo ?? 'N/A'),
//                 _buildDetailRow("Relationship", ben.relationshipToMember),
//                 _buildDetailRow("Share Percent", "${ben.sharePercent}%"),
//                 const SizedBox(height: 8),
//               ],
//             );
//           }),
//         Text("Guardians", style: Theme.of(context).textTheme.titleMedium),
//         if (formData.sectionC.guardians.isEmpty)
//           const Padding(
//               padding: EdgeInsets.all(8.0), child: Text("No guardians added."))
//         else
//           ...formData.sectionC.guardians.asMap().entries.map((entry) {
//             final index = entry.key;
//             final guard = entry.value;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Guardian ${index + 1}",
//                     style: Theme.of(context).textTheme.titleSmall),
//                 _buildDetailRow("Name", guard.name),
//                 _buildDetailRow("Email", guard.email ?? 'N/A'),
//                 _buildDetailRow("Mobile", guard.mobile),
//                 _buildDetailRow("ID No.", guard.idNo ?? 'N/A'),
//                 _buildDetailRow("Relationship", guard.relationshipToMember),
//                 const SizedBox(height: 8),
//               ],
//             );
//           }),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 2,
//               child: Text(label,
//                   style: const TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(flex: 3, child: Text(value)),
//         ],
//       ),
//     );
//   }
// }

// // // components/steps/beno_confirm_step.dart
// // import 'package:flutter/material.dart';
// // import '../../models/beno_project_model.dart';
// // import '../ui/beno_ui_components.dart';
// // import 'dart:math' as math;
// // import '../../helpers/responsive_helper.dart';

// // class BenoConfirmStep extends StatefulWidget {
// //   final BenoFormDataType formData;
// //   final VoidCallback prevStep;
// //   final VoidCallback handleSubmit;

// //   const BenoConfirmStep({
// //     super.key,
// //     required this.formData,
// //     required this.prevStep,
// //     required this.handleSubmit,
// //   });

// //   @override
// //   _BenoConfirmStepState createState() => _BenoConfirmStepState();
// // }

// // class _BenoConfirmStepState extends State<BenoConfirmStep> {
// //   bool _isConfirmed = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(builder: (context, constraints) {
// //       final isNarrow = constraints.maxWidth < 700;
// //       final isPhone = constraints.maxWidth < 420;
// //       final double maxFormWidth = isNarrow ? double.infinity : 900;
// //       final double horizontalPadding =
// //           isPhone ? 12.0 : (isNarrow ? 16.0 : 32.0);
// //       final double titleSize = responsiveFontSize(context,
// //           baseSize: isPhone ? 18 : (isNarrow ? 22 : 28));

// //       return Center(
// //         child: BenoCard(
// //           maxWidth: maxFormWidth,
// //           child: Padding(
// //             padding: EdgeInsets.all(horizontalPadding),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Step 4: Confirm & Submit',
// //                     style: TextStyle(
// //                         fontSize: titleSize, fontWeight: FontWeight.bold)),
// //                 const SizedBox(height: 24),
// //                 if (isNarrow)
// //                   _buildSingleColumnReview()
// //                 else
// //                   _buildTwoColumnReview(),
// //                 const SizedBox(height: 24),
// //                 _buildTermsSection(isPhone),
// //                 const SizedBox(height: 24),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     BenoButton(
// //                         onPressed: widget.prevStep,
// //                         text: 'Back',
// //                         compact: isPhone ? true : false,
// //                         isOutline: true),
// //                     BenoButton(
// //                       onPressed: _isConfirmed ? widget.handleSubmit : null,
// //                       compact: isPhone ? true : false,
// //                       text: 'Confirm & Submit',
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       );
// //     });
// //   }

// //   Widget _buildSingleColumnReview() {
// //     return Column(
// //       children: [
// //         _buildPlanAndDependantsCard(),
// //         const SizedBox(height: 16),
// //         _buildPersonalDetailsCard(),
// //         const SizedBox(height: 16), // ✅ Add payment details card
// //         _buildPaymentDetailsCard(),
// //       ],
// //     );
// //   }

// //   Widget _buildTwoColumnReview() {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       // children: [
// //       //   Expanded(child: _buildPersonalDetailsCard()),
// //       //   const SizedBox(width: 24),
// //       //   Expanded(child: _buildPlanAndDependantsCard()),
// //       // ],
// //       children: [
// //         Expanded(
// //             flex: 2, // Give more space to personal details
// //             child: _buildPersonalDetailsCard()),
// //         const SizedBox(width: 24),
// //         Expanded(
// //             flex: 3, // Give more space to plan and payment
// //             child: Column(
// //               children: [
// //                 _buildPlanAndDependantsCard(),
// //                 const SizedBox(height: 16),
// //                 _buildPaymentDetailsCard(), // ✅ Add payment details card
// //               ],
// //             )),
// //       ],
// //     );
// //   }

// //   Widget _buildPersonalDetailsCard() {
// //     final details = widget.formData.sectionA;
// //     return _ReviewCard(
// //       title: 'Personal Details',
// //       icon: Icons.person,
// //       children: [
// //         _ReviewTile(label: 'Full Name', value: details.nafullName),
// //         _ReviewTile(label: 'Date of Birth', value: details.dob),
// //         _ReviewTile(label: 'Email', value: details.email),
// //         // _ReviewTile(label: 'Phone', value: details.phoneNumbers),
// //         _ReviewTile(label: 'Address', value: details.address),
// //       ],
// //     );
// //   }

// //   Widget _buildPlanAndDependantsCard() {
// //     return _ReviewCard(
// //       title: 'Plan & Dependants',
// //       icon: Icons.family_restroom,
// //       children: [
// //         _ReviewTile(
// //             label: 'Selected Plan',
// //             value: widget.formData.plan,
// //             isHighlight: true),
// //         _ReviewTile(
// //             label: 'Coverage',
// //             value:
// //                 'Ksh. ${widget.formData.plan == 'Premium' ? '100,000' : '50,000'}',
// //             isHighlight: true),
// //         const Divider(height: 24),
// //         Text('Dependants',
// //             style: Theme.of(context)
// //                 .textTheme
// //                 .titleMedium
// //                 ?.copyWith(fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 8),
// //         if (widget.formData.dependants.isEmpty)
// //           const Text('No dependants added.')
// //         else
// //           ...widget.formData.sectionB
// //               .map((d) => Text('• ${d.name} (${d.relationship})')),
// //       ],
// //     );
// //   }

// //   // ✅ NEW: Widget to display payment details for review
// //   Widget _buildPaymentDetailsCard() {
// //     final paymentPhoneNumber =
// //         widget.formData.sectionA.idNo;
// //     return _ReviewCard(
// //       title: 'Payment Details',
// //       icon: Icons.payment,
// //       children: [
// //         _ReviewTile(
// //             label: 'Payment Method',
// //             value: paymentPhoneNumber != null && paymentPhoneNumber.isNotEmpty
// //                 ? 'M-Pesa'
// //                 : 'Card',
// //             isHighlight: true),
// //         if (paymentPhoneNumber != null && paymentPhoneNumber.isNotEmpty)
// //           _ReviewTile(label: 'Phone Number', value: paymentPhoneNumber),
// //         // You can add card details here if you want, but often it's omitted for security
// //         // e.g., _ReviewTile(label: 'Card', value: '**** **** **** 1234'),
// //       ],
// //     );
// //   }

// //   Widget _buildTermsSection(bool isPhone) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text('Terms, Conditions & Exclusions',
// //             style: Theme.of(context).textTheme.titleLarge),
// //         const SizedBox(height: 8),
// //         Container(
// //           height: 200,
// //           padding: const EdgeInsets.all(12),
// //           decoration: BoxDecoration(
// //               border: Border.all(color: Theme.of(context).dividerColor),
// //               borderRadius: BorderRadius.circular(8),
// //               color: Theme.of(context).cardColor.withOpacity(0.5)),
// //           child: const SingleChildScrollView(
// //             child: Text(
// //                 "1. When does the cover start?\n"
// //                 "2. What are the benefits? \n"
// //                 "3. Who is covered? \n"
// //                 "4. How do I register?\n"
// //                 ),
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         InkWell(
// //           onTap: () => setState(() => _isConfirmed = !_isConfirmed),
// //           borderRadius: BorderRadius.circular(8),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 8.0),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Checkbox(
// //                   value: _isConfirmed,
// //                   onChanged: (value) =>
// //                       setState(() => _isConfirmed = value ?? false),
// //                 ),
// //                 Expanded(
// //                   child: Text(
// //                     'I declare that the statements and particulars on this application are true and that I have read and understood the terms, conditions, and exclusions.',
// //                     style: Theme.of(context).textTheme.bodyMedium,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class _ReviewCard extends StatelessWidget {
// //   final String title;
// //   final IconData icon;
// //   final List<Widget> children;

// //   const _ReviewCard(
// //       {required this.title, required this.icon, required this.children});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 0,
// //       shape: RoundedRectangleBorder(
// //         side: BorderSide(color: Theme.of(context).dividerColor),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(icon, color: Colors.blue),
// //                 const SizedBox(width: 8),
// //                 Text(title,
// //                     style: Theme.of(context)
// //                         .textTheme
// //                         .titleLarge
// //                         ?.copyWith(fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //             const Divider(height: 24),
// //             ...children,
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _ReviewTile extends StatelessWidget {
// //   final String label;
// //   final String value;
// //   final bool isHighlight;

// //   const _ReviewTile(
// //       {required this.label, required this.value, this.isHighlight = false});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(label, style: TextStyle(color: Colors.grey[600])),
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               color: isHighlight ? Colors.blue : null,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
