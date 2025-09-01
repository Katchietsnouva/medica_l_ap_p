// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

enum CoverType { none, me, spouse, family }

class AppProvider extends ChangeNotifier {
  CoverType _selectedCoverType = CoverType.none;
  DateTime? _myDob;
  DateTime? _spouseDob;
  int _childCount = 0;
  int? _selectedCoverAmount;
  bool _isDetailsSectionVisible = false;
  bool _isCoverAmountSectionVisible = false;
  bool _isPaymentFormVisible = false;

  CoverType get selectedCoverType => _selectedCoverType;
  DateTime? get myDob => _myDob;
  DateTime? get spouseDob => _spouseDob;
  int get childCount => _childCount;
  int? get selectedCoverAmount => _selectedCoverAmount;
  bool get isPaymentFormVisible => _isPaymentFormVisible;

  bool get isDetailsSectionVisible => _selectedCoverType != CoverType.none;
  bool get isCoverAmountSectionVisible =>
      _myDob != null &&
      (_selectedCoverType == CoverType.me || _spouseDob != null);

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
    _isPaymentFormVisible = false;

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
    // _isPaymentFormVisible = false;
    _isPaymentFormVisible = true;
    notifyListeners();
  }

  void showPaymentForm() {
    if (_selectedCoverAmount != null) {
      _isPaymentFormVisible = true;
      notifyListeners();
    }
  }

// ####################################

  void showDetailsSection(VoidCallback scrollToDetails) {
    _isDetailsSectionVisible = true;
    notifyListeners();
    scrollToDetails();
  }

  void showCoverAmountSection(VoidCallback scrollToCoverAmount) {
    _isCoverAmountSectionVisible = true;
    notifyListeners();
    scrollToCoverAmount();
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
}
