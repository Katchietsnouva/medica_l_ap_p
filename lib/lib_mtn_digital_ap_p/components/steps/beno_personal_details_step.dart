// components/steps/beno_personal_details_step.dart
import 'dart:math' as math;

import 'package:medica_l_ap_p/lib_beno_app/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import '../../models/beno_project_model.dart';
import '../ui/beno_ui_components.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// const Color primaryColor = Color(0xFFD02030);

class PersonalDetailsStep extends StatefulWidget {
  final SectionA sectionA;
  final Function(SectionA) onUpdate;
  final VoidCallback nextStep;

  const PersonalDetailsStep(
      {super.key,
      required this.sectionA,
      required this.onUpdate,
      required this.nextStep});
  @override
  _PersonalDetailsStepState createState() => _PersonalDetailsStepState();
}

class _PersonalDetailsStepState extends State<PersonalDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _controllers;
  // late List<TextEditingController> _phoneControllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'employerName': TextEditingController(text: widget.sectionA.employerName),
      'occupation': TextEditingController(text: widget.sectionA.occupation),
      'memberFullName':
          TextEditingController(text: widget.sectionA.memberFullName),
      'memberNumber': TextEditingController(text: widget.sectionA.memberNumber),
      'dateOfBirth': TextEditingController(text: widget.sectionA.dateOfBirth),
      'dateOfAppointment':
          TextEditingController(text: widget.sectionA.dateOfAppointment),
      'dateOfAdmission':
          TextEditingController(text: widget.sectionA.dateOfAdmission),
      'dateOfCommencement':
          TextEditingController(text: widget.sectionA.dateOfCommencement),
      'kraPin': TextEditingController(text: widget.sectionA.kraPin),
      'idNo': TextEditingController(text: widget.sectionA.idNo),
      'phone': TextEditingController(text: widget.sectionA.phone),
      'email': TextEditingController(text: widget.sectionA.email),
      'voluntaryAmount': TextEditingController(
          text: widget.sectionA.voluntaryAmount?.toString()),
      'voluntaryPercent': TextEditingController(
          text: widget.sectionA.voluntaryPercent?.toString()),
    };
    // Initialize controllers for phone numbers
    // _phoneControllers = widget.personalDetails.phoneNumbers
    //     .map((phoneNumber) => TextEditingController(text: phoneNumber))
    //     .toList();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    // _phoneControllers.forEach((controller) => controller.dispose());

    super.dispose();
  }

  void _onUpdate() {
    // List<String> phoneNumbers =
    //     _phoneControllers.map((controller) => controller.text).toList();

    // widget.onUpdate(BenoPersonalDetailsType(
    //   fullName: _controllers['fullName']!.text,
    //   dob: _controllers['dob']!.text,
    //   phoneNumbers: phoneNumbers,
    // ));

    if (_formKey.currentState!.validate()) {
      widget.onUpdate(SectionA(
        employerName: _controllers['employerName']!.text,
        occupation: _controllers['occupation']!.text,
        memberFullName: _controllers['memberFullName']!.text,
        memberNumber: _controllers['memberNumber']!.text,
        dateOfBirth: _controllers['dateOfBirth']!.text,
        dateOfAppointment: _controllers['dateOfAppointment']!.text,
        dateOfAdmission: _controllers['dateOfAdmission']!.text,
        dateOfCommencement: _controllers['dateOfCommencement']!.text,
        kraPin: _controllers['kraPin']!.text,
        idNo: _controllers['idNo']!.text,
        phone: _controllers['phone']!.text,
        email: _controllers['email']!.text,
        voluntaryAmount: int.tryParse(_controllers['voluntaryAmount']!.text),
        voluntaryPercent:
            double.tryParse(_controllers['voluntaryPercent']!.text),
      ));
      widget.nextStep();
    }
  }

  void _removePhoneNumber(int index) {
    setState(() {
      // if (_phoneControllers.length > 1) {
      //   _phoneControllers.removeAt(index);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 600;
      final isPhone = constraints.maxWidth < 420;

      final double maxFormWidth = isNarrow
          ? math.min(constraints.maxWidth, 420)
          : math.min(constraints.maxWidth, 900);

      final double horizontalPadding =
          isPhone ? 12.0 : (isNarrow ? 16.0 : 32.0);
      final double verticalSpacing = isPhone ? 10.0 : (isNarrow ? 14.0 : 16.0);
      final double titleSize = responsiveFontSize(context,
          baseSize: isPhone ? 20 : (isNarrow ? 22 : 24));

      return Center(
        child: BenoCard(
          maxWidth: maxFormWidth + horizontalPadding * 2,
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxFormWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step 1: Personal Details",
                      style: TextStyle(
                          fontSize: titleSize, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: verticalSpacing / 2),
                    Text('Please verify and update your information.',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey)),
                    SizedBox(height: verticalSpacing / 1.5),
                    LayoutBuilder(builder: (context, inner) {
                      if (inner.maxWidth > 600) {
                        return _buildTwoColumnLayout(spacing: verticalSpacing);
                      }
                      return _buildSingleColumnLayout(
                          spacing: verticalSpacing, compact: isPhone);
                    }),
                    // const SizedBox(height: 32),
                    SizedBox(height: verticalSpacing / 1.5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BenoButton(
                        onPressed: () {
                          // First, check if the form is valid
                          if (_formKey.currentState!.validate()) {
                            // If it is, then update the data and move on
                            _onUpdate();
                            widget.nextStep();
                          }
                        },
                        compact: isPhone ? true : false,
                        text: 'Next Step',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Widget _buildSingleColumnLayout() {
  Widget _buildSingleColumnLayout({double spacing = 0, bool compact = false}) {
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
                    compact: compact, spacing: spacing)),
            const SizedBox(width: 8),
            Expanded(
              child: secondIndex < entries.length
                  ? _buildTextField(
                      entries[secondIndex].key, entries[secondIndex].value,
                      compact: compact, spacing: spacing)
                  // : Container(),
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    })
        // ..addAll(
        //   _phoneControllers.map((controller) {
        //     return _buildPhoneField(
        //       controller,
        //       spacing: spacing,
        //       compact: compact,
        //     );
        //   }).toList(),
        // )
        // ..add(
        //   Padding(
        //     padding: EdgeInsets.only(top: spacing),
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: BenoButton(
        //         onPressed:
        //             _addPhoneNumber, // Add a phone number when this button is clicked
        //         text: 'Add Phone Number',
        //         compact: compact, // <-- pass compact mode here

        //         backgroundColor:
        //             Colors.blue, // Optional: Customize the background color
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  // Widget _buildTwoColumnLayout() {
  Widget _buildTwoColumnLayout({double spacing = 16}) {
    final entries = _controllers.entries.toList();
    // arrange pairs into rows
    return Column(
        children: List.generate((entries.length / 2).ceil(), (rowIndex) {
      final firstIndex = rowIndex * 2;
      final secondIndex = firstIndex + 1;
      return Padding(
        // padding: const EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.only(bottom: spacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                // child: _buildTextField(entries[firstIndex].key, entries[firstIndex].value, compact: null)),
                child: _buildTextField(
                    entries[firstIndex].key, entries[firstIndex].value,
                    compact: false, spacing: spacing)),
            const SizedBox(width: 16),
            Expanded(
              child: secondIndex < entries.length
                  // ? _buildTextField( entries[secondIndex].key, entries[secondIndex].value)
                  ? _buildTextField(
                      entries[secondIndex].key, entries[secondIndex].value,
                      compact: false, spacing: spacing)
                  // : Container(),
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    })
        // ..addAll(
        //   _phoneControllers.map((controller) {
        //     return Padding(
        //       padding: EdgeInsets.only(bottom: spacing),
        //       child: Row(
        //         children: [
        //           Expanded(
        //               child: _buildPhoneField(
        //             controller,
        //             spacing: spacing,
        //           )),
        //         ],
        //       ),
        //     );
        //   }).toList(),
        // )
        // ..add(
        //   Padding(
        //     padding: EdgeInsets.only(top: spacing),
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: BenoButton(
        //         onPressed:
        //             _addPhoneNumber, // Add a phone number when this button is clicked
        //         text: 'Add Phone Number',
        //         backgroundColor:
        //             Colors.blue, // Optional: Customize the background color
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  Widget _buildTextField(String key, TextEditingController controller,
      {required bool compact, double spacing = 16}) {
    // Simple way to make label more readable
    final label = key
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
        .capitalize();

    // smaller decoration for compact mode
    final decoration = InputDecoration(
      labelText: label,
      isDense: compact,
      contentPadding: compact
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
    return Padding(
      // padding: const EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.only(bottom: spacing),
      child: Builder(
        builder: (context) {
          // 📧 Email field validation
          // if (key == 'email') {
          //   return TextFormField(
          //     controller: controller,
          //     decoration: decoration,
          //     keyboardType: TextInputType.emailAddress,
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter $label';
          //       }
          //       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          //       if (!emailRegex.hasMatch(value)) {
          //         return 'Please enter a valid email';
          //       }
          //       return null;
          //     },
          //   );
          // }
// ... inside _buildTextField method
          if (key == 'email') {
            return TextFormField(
              controller: controller,
              decoration: decoration,
              keyboardType: TextInputType.emailAddress,
              // This will validate as the user interacts with the field
              autovalidateMode:
                  AutovalidateMode.onUserInteraction, // <-- ADD THIS
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            );
          }
          // 📅 Date picker for 'dob'
          if (key == 'dob') {
            return InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 365 * 18)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  controller.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  // widget.onChanged(key, controller.text);
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    // isDense: widget.isCompact,
                    contentPadding: compact
                        ? const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter $label';
                    }
                    return null;
                  },
                ),
              ),
            );
          }

          // ♂ Gender dropdown example (if you add gender field in model)
          if (key == 'gender') {
            return DropdownButtonFormField<String>(
              value: controller.text.isEmpty ? null : controller.text,
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.text = value;
                  // widget.onUpdate(key, value);
                }
              },
              decoration: InputDecoration(
                labelText: label,
                contentPadding: compact
                    ? const EdgeInsets.symmetric(horizontal: 10, vertical: 0)
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select $label';
                }
                return null;
              },
            );
          }
          return TextFormField(
            controller: controller,
            // decoration: InputDecoration(labelText: label),
            decoration: decoration,
            keyboardType: key == 'dob'
                ? TextInputType.datetime
                : (key == 'phone' || key == 'idNumber'
                    ? TextInputType.number
                    : TextInputType.text),
          );
        },
      ),
    );
  }

  // Widget _buildPhoneField(TextEditingController controller, {double spacing = 16}) {
  Widget _buildPhoneField(TextEditingController controller,
      {double spacing = 16, bool compact = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // child: IntlPhoneField(
            child: TextFormField(
              controller: controller,
              // initialCountryCode: 'KE',
              decoration: InputDecoration(
                labelText: 'Phone Number',
                isDense: compact,
                contentPadding: compact
                    ? EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8) // Less padding for compact mode
                    : EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16), // Default padding
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              keyboardType: TextInputType.phone,
              // Optional: update your main data model as the number changes
              // onChanged: (phone) {
              //   print(phone.completeNumber); // e.g., +254712345678
              // },
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.remove_circle_outline, size: compact ? 20 : 24),
          //   onPressed: () =>
          //       _removePhoneNumber(_phoneControllers.indexOf(controller)),
          // ),
        ],
      ),
    );
  }

  void _addPhoneNumber() {
    // setState(() {
    //   _phoneControllers.add(TextEditingController());
    // });
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

// // components/steps/beno_personal_details_step.dart
// import 'package:flutter/material.dart';
// import '../../models/beno_project_model.dart';
// import '../ui/beno_ui_components.dart';

// class PersonalDetailsStep extends StatefulWidget {
//   final BenoPersonalDetailsType personalDetails;
//   final Function(BenoPersonalDetailsType) onUpdate;
//   final VoidCallback nextStep;

//   const PersonalDetailsStep({
//     super.key,
//     required this.personalDetails,
//     required this.onUpdate,
//     required this.nextStep,
//   });

//   @override
//   _PersonalDetailsStepState createState() => _PersonalDetailsStepState();
// }

// class _PersonalDetailsStepState extends State<PersonalDetailsStep> {
//   late BenoPersonalDetailsType _details;

//   @override
//   void initState() {
//     super.initState();
//     _details = widget.personalDetails;
//   }

//   void _handleChange(String field, String value) {
//     setState(() {
//       // This is a bit verbose in Dart without reflection, but it's clear.
//       switch (field) {
//         case 'fullName':
//           _details.fullName = value;
//           break;
//         case 'dob':
//           _details.dob = value;
//           break;
//         case 'gender':
//           _details.gender = value;
//           break;
//         case 'idNumber':
//           _details.idNumber = value;
//           break;
//         case 'email':
//           _details.email = value;
//           break;
//         case 'address':
//           _details.address = value;
//           break;
//         case 'churchBranch':
//           _details.churchBranch = value;
//           break;
//         case 'phone':
//           _details.phone = value;
//           break;
//       }
//     });
//     widget.onUpdate(_details);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BenoCard(
//       maxWidth: 800,
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Step 1: Personal Details',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 8),
//             Text(
//                 'Your information is pre-filled. Please verify and update if necessary.',
//                 style: Theme.of(context).textTheme.bodyMedium),
//             const SizedBox(height: 24),
//             // A more Flutter-like way to build the form
//             _buildTextField('Full Name', 'fullName', _details.fullName),
//             _buildTextField('Date of Birth', 'dob', _details.dob, isDate: true),
//             _buildTextField('Gender', 'gender', _details.gender),
//             _buildTextField('ID Number', 'idNumber', _details.idNumber),
//             _buildTextField('Email', 'email', _details.email),
//             _buildTextField('Address', 'address', _details.address),
//             _buildTextField(
//                 'Church Branch', 'churchBranch', _details.churchBranch),
//             _buildTextField('Phone', 'phone', _details.phone),
//             const SizedBox(height: 24),
//             Align(
//               alignment: Alignment.centerRight,
//               child: BenoButton(onPressed: widget.nextStep, text: 'Next Step'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, String field, String value,
//       {bool isDate = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: TextFormField(
//         initialValue: value,
//         decoration: InputDecoration(labelText: label),
//         onChanged: (val) => _handleChange(field, val),
//         keyboardType: isDate ? TextInputType.datetime : TextInputType.text,
//       ),
//     );
//   }
// }
