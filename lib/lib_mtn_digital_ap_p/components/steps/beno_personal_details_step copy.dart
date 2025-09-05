// components/steps/beno_personal_details_step.dart
import 'package:flutter/material.dart';
import '../../models/beno_project_model.dart';
import '../ui/beno_ui_components.dart';

class PersonalDetailsStep extends StatefulWidget {
  final BenoPersonalDetailsType personalDetails;
  final Function(BenoPersonalDetailsType) onUpdate;
  final VoidCallback nextStep;

  const PersonalDetailsStep({
    super.key,
    required this.personalDetails,
    required this.onUpdate,
    required this.nextStep,
  });

  @override
  _PersonalDetailsStepState createState() => _PersonalDetailsStepState();
}

class _PersonalDetailsStepState extends State<PersonalDetailsStep> {
  late BenoPersonalDetailsType _details;

  @override
  void initState() {
    super.initState();
    _details = widget.personalDetails;
  }

  void _handleChange(String field, String value) {
    setState(() {
      // This is a bit verbose in Dart without reflection, but it's clear.
      switch (field) {
        case 'fullName':
          _details.fullName = value;
          break;
        case 'dob':
          _details.dob = value;
          break;
        case 'gender':
          _details.gender = value;
          break;
        case 'idNumber':
          _details.idNumber = value;
          break;
        case 'email':
          _details.email = value;
          break;
        case 'address':
          _details.address = value;
          break;
        case 'churchBranch':
          _details.churchBranch = value;
          break;
        case 'phone':
          _details.phone = value;
          break;
      }
    });
    widget.onUpdate(_details);
  }

  @override
  Widget build(BuildContext context) {
    return BenoCard(
      maxWidth: 800,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 1: Personal Details',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
                'Your information is pre-filled. Please verify and update if necessary.',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            // A more Flutter-like way to build the form
            _buildTextField('Full Name', 'fullName', _details.fullName),
            _buildTextField('Date of Birth', 'dob', _details.dob, isDate: true),
            _buildTextField('Gender', 'gender', _details.gender),
            _buildTextField('ID Number', 'idNumber', _details.idNumber),
            _buildTextField('Email', 'email', _details.email),
            _buildTextField('Address', 'address', _details.address),
            _buildTextField(
                'Church Branch', 'churchBranch', _details.churchBranch),
            _buildTextField('Phone', 'phone', _details.phone),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: BenoButton(onPressed: widget.nextStep, text: 'Next Step'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String field, String value,
      {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        onChanged: (val) => _handleChange(field, val),
        keyboardType: isDate ? TextInputType.datetime : TextInputType.text,
      ),
    );
  }
}
