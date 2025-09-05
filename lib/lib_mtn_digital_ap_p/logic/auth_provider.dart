// logic/auth_provider.dart (✅ NEW FILE)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/beno_mock_user_database.dart';
import '../models/beno_project_model.dart';

class AuthProvider with ChangeNotifier {
  BenoMockUserDataType? _currentUser;
  BenoMockUserDataType? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  AuthProvider() {
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final loggedInUserId = prefs.getString('loggedInUserId');
    if (loggedInUserId != null &&
        benoMockUserDatabase.containsKey(loggedInUserId)) {
      _currentUser = benoMockUserDatabase[loggedInUserId];
    } else {
      _currentUser = null;
    }
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading
    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUserId', userId);
    _currentUser = benoMockUserDatabase[userId];
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUserId');
    _currentUser = null;
    notifyListeners();
  }

  void handlePaymentSuccess() {
    final userId = _currentUser?.formData.sectionA.idNo;
    if (userId != null) {
      benoMockUserDatabase[userId]!.hasPaid = true;
      _currentUser = benoMockUserDatabase[userId];
      notifyListeners();
    }
  }

  void handleFormUpdate(BenoFormDataType updatedFormData) {
    final userId = _currentUser?.formData.sectionA.idNo;
    if (userId != null) {
      benoMockUserDatabase[userId]!.formData = updatedFormData;
      _currentUser = benoMockUserDatabase[userId];
      notifyListeners();
    }
  }
}
