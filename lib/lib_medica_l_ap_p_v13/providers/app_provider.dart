// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

enum CoverType { none, me, spouse, family }

// enum PlanType { none, Royal Pre, Royalmed Exe, }
enum PlanType { none, royalPre, royalmedExe }

class AppProvider extends ChangeNotifier {
  CoverType _selectedCoverType = CoverType.none;
  PlanType _selectedPlanType = PlanType.none;
  DateTime? _myDob;
  DateTime? _spouseDob;
  int _childCount = 0;
  int? _selectedCoverAmount;
  int? _selectedPlanAmount;
  bool _isPersonOrFamilyDetailsCardVisible = false;
  bool _isCoverAmountCardVisible = false;
  bool _isCoverPlansCardVisible = false;
  bool _isPaymentFormVisible = false;
  bool _isMpesaComponentVisible = false;

  CoverType get selectedCoverType => _selectedCoverType;
  PlanType get selectedPlanType =>
      _selectedPlanType; // Replace selectedPlanAmount
  DateTime? get myDob => _myDob;
  DateTime? get spouseDob => _spouseDob;
  int get childCount => _childCount;
  int? get selectedCoverAmount => _selectedCoverAmount;
  int? get selectedPlanAmount => _selectedPlanAmount;
  bool get isPaymentFormVisible => _isPaymentFormVisible;
  bool get isMpesaComponentVisible => _isMpesaComponentVisible;

  bool get isPersonOrFamilyDetailsCardVisible =>
      _selectedCoverType != CoverType.none;
  bool get isCoverAmountCardVisible =>
      _myDob != null &&
      (_selectedCoverType == CoverType.me || _spouseDob != null);

  bool get isCoverPlansCardVisible => _isCoverPlansCardVisible;

  void selectCoverType(CoverType type) {
    if (_selectedCoverType == type) {
      // If clicking the same card, deselect and reset
      _selectedCoverType = CoverType.none;
    } else {
      _selectedCoverType = type;
    }
    // Reset downstream data when selection changes
    _myDob = null;
    _spouseDob = null;
    _childCount = 0;
    _selectedCoverAmount = null;
    _selectedPlanAmount = null;
    _selectedPlanType = PlanType.none; // Reset plan type
    _isPaymentFormVisible = false;
    _isCoverPlansCardVisible = false;
    _isMpesaComponentVisible = false;

    notifyListeners();
  }

  void setMyDob(DateTime date) {
    _myDob = date;
    notifyListeners();
  }

  void setSpouseDob(DateTime date) {
    _spouseDob = date;
    notifyListeners();
  }

  void setChildCount(int count) {
    _childCount = count;
    notifyListeners();
  }

  void selectCoverAmount(int amount) {
    _selectedCoverAmount = amount;
    _isPaymentFormVisible = false;
    // _isPaymentFormVisible = true;
    notifyListeners();
  }

  // void selectPlanAmount(int amount) {
  //   _selectedPlanAmount = amount;
  //   _isPaymentFormVisible = false;
  //   // _isPaymentFormVisible = true;
  //   notifyListeners();
  // }

  void selectPlanType(PlanType type, int premium) {
    _selectedPlanAmount = premium;
    _selectedPlanType = type;
    _isPaymentFormVisible = false;
    print(
        'Selected Plan Type: $_selectedPlanType, Amount: $_selectedPlanAmount');
    notifyListeners();
  }

  void showPaymentForm() {
    // if (_selectedCoverAmount != null && _selectedPlanAmount != null) {
    if (_selectedCoverAmount != null && _selectedPlanType != PlanType.none) {
      // if (_selectedCoverAmount != null) {
      _isPaymentFormVisible = true;
      notifyListeners();
    }
  }

// ####################################

  void showDetailsSection(VoidCallback scrollToDetails) {
    _isPersonOrFamilyDetailsCardVisible = true;
    notifyListeners();
    scrollToDetails();
  }

  void showCoverAmountSection(VoidCallback scrollToCoverAmount) {
    _isCoverAmountCardVisible = true;
    notifyListeners();
    scrollToCoverAmount();
  }

  void showCoverPlansCard(VoidCallback scrollToCoverPlansCards) {
    _isCoverPlansCardVisible = true;
    notifyListeners();
    scrollToCoverPlansCards();
  }

  void showPaymentForm_(VoidCallback scrollToPayment) {
    _isPaymentFormVisible = true;
    notifyListeners();
    scrollToPayment();
  }

  // ADD THIS GETTER FOR THE CENTRALIZED PREMIUM
  double get premium {
    if (_selectedCoverAmount == null) return 0.0;
    // This is now the ONLY place the premium is calculated.
    // Example logic: Premium is 0.15% of the cover amount per year.
    // Adjust the formula here if you need to.
    // return (_selectedCoverAmount! * 0.0015);
    return (_selectedCoverAmount! * 1);
  }

  // get payload => null;
  Map<String, dynamic> buildPlanPayload() {
    return {
      // "insurer": 1,
      // "principal_dob": _myDob?.toIso8601String() ?? "1990-01-01",
      // "spouse_age": _spouseDob?.toIso8601String() ?? "1980-01-01",
      // "children": _childCount,
      // // "limit": _selectedCoverAmount ?? 0,
      // "limit": 1000000,
      // "ipp": false,
      // "ips": true,
      // "op": false,
      // "ops": false,
      // "meternity": false,
      // "dental": false,
      // "optical": false,
      // "lastexpense": false,
      // "pa": false,

      "insurer": 1,
      "principal_dob": "1990-01-01",
      "spouse_age": "1980-01-01",
      "children": 1,
      "limit": 1000000,
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
  }

  void showMpesaCard(VoidCallback scrollToMpesasComponent) {
    _isMpesaComponentVisible = true;
    notifyListeners();
    scrollToMpesasComponent();
  }
}
