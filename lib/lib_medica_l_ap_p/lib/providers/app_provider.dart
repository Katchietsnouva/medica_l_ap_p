// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

enum CoverType { none, me, spouse, family }

class AppProvider extends ChangeNotifier {
  CoverType _selectedCoverType = CoverType.none;
  DateTime? _myDob;
  DateTime? _spouseDob;
  int _childCount = 0;
  int? _selectedCoverAmount;

  CoverType get selectedCoverType => _selectedCoverType;
  DateTime? get myDob => _myDob;
  DateTime? get spouseDob => _spouseDob;
  int get childCount => _childCount;
  int? get selectedCoverAmount => _selectedCoverAmount;

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
    notifyListeners();
  }
}
