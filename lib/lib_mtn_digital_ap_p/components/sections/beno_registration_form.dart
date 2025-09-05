// components/sections/beno_registration_form.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/beno_project_model.dart';
import '../steps/beno_personal_details_step.dart';
import '../steps/beno_dependants_step.dart';
import '../steps/beno_payment_step.dart';
import '../steps/beno_confirm_step.dart';
import '../steps/beno_form_stepper.dart';

class BenoRegistrationForm extends StatefulWidget {
  final BenoFormDataType currentUserData;
  final Function(BenoFormDataType) onUpdate;

  const BenoRegistrationForm({
    super.key,
    required this.currentUserData,
    required this.onUpdate,
  });

  @override
  _BenoRegistrationFormState createState() => _BenoRegistrationFormState();
}

class _BenoRegistrationFormState extends State<BenoRegistrationForm> {
  int _currentStep = 1;
  late BenoFormDataType _formData;
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _formData = widget.currentUserData;
  }

  void _nextStep() =>
      setState(() => _currentStep = (_currentStep < 4) ? _currentStep + 1 : 4);
  void _prevStep() =>
      setState(() => _currentStep = (_currentStep > 1) ? _currentStep - 1 : 1);

  // void _updatePersonalDetails(BenoPersonalDetailsType details) {
  //   setState(() => _formData.personalDetails = details);
  // }

  void _updatePlan(String plan) {
    setState(() => _formData.plan = plan);
  }

  // void _updateDependants(List<BenoDependant> dependants) {
  //   setState(() => _formData.dependants = dependants);
  // }

  // void _addDependant() {
  //   final newDependant = BenoDependant(
  //       id: _uuid.v4(),
  //       name: '',
  //       dob: '',
  //       relationship: 'Spouse',
  //       idNumber: '');
  //   setState(() => _formData.dependants.add(newDependant));
  // }

  // void _removeDependant(String id) {
  //   setState(() => _formData.dependants.removeWhere((d) => d.id == id));
  // }

  void _updateSectionA(SectionA sectionA) {
    setState(() => _formData.sectionA = sectionA);
  }

  void _updateSectionC(SectionC sectionC) {
    setState(() => _formData.sectionC = sectionC);
  }

  void _updateFormData(BenoFormDataType formData) {
    setState(() => _formData = formData);
  }

  void _handleSubmit() {
    widget.onUpdate(_formData);
    setState(() => _currentStep = 1);
  }

  // void _updatePaymentDetails(BenoPaymentDetails details) {
  void _updatePaymentDetails(BenoFormDataType details) {
    // setState(() => _formData.paymentDetails = details);
    // setState(() => _formData.paymentDetails = details as BenoPaymentDetails);
    setState(() {
      // _formData.paymentDetails = details;
      _formData = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.2)
          // : Colors.grey[100],
          : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              BenoFormStepper(
                currentStep: _currentStep,
                // steps: const [ "Personal Details", "Dependants", "Payment", "Confirm & Submit" ],
                steps: [
                  "Personal Details",
                  "Beneficiaries & Guardians",
                  "Bank Details",
                  "Confirm & Submit"
                ],
              ),
              const SizedBox(height: 32),
              _buildStep(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_currentStep) {
      case 1:
        return PersonalDetailsStep(
          // personalDetails: _formData.personalDetails,
          sectionA: _formData.sectionA,
          // onUpdate: _updatePersonalDetails,
          onUpdate: _updateSectionA,
          nextStep: _nextStep,
        );
      case 2:
        return BenoDependantsStep(
          plan: _formData.plan,
          onPlanChange: _updatePlan,
          // dependants: _formData.dependants,
          // onDependantsChange: _updateDependants,
          // onAddDependant: _addDependant,
          // onRemoveDependant: _removeDependant,
          sectionC: _formData.sectionC,
          onSectionCChange: _updateSectionC,
          nextStep: _nextStep,
          prevStep: _prevStep,
          // onRemoveDependant: (String) {},
        );
      case 3:
        return BenoPaymentStep(
          // paymentDetails: _formData.paymentDetails,
          formData: _formData,
          // onUpdate: _updatePaymentDetails,
          onUpdate: _updateFormData,
          nextStep: _nextStep,
          prevStep: _prevStep,
        );
      case 4:
        return BenoConfirmStep(
          formData: _formData,
          prevStep: _prevStep,
          handleSubmit: _handleSubmit,
        );
      default:
        return Container();
    }
  }
}
