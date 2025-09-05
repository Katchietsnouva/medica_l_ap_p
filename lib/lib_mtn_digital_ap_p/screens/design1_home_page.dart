// screens/design1_home_page.dart
// This is the main stateful widget that acts as a router, deciding which page to show.
// import 'package:benevolent_app/lib_mtn_digital_ap_p/screens/home_content.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/screens/beno_signup_page.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/screens/home_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/beno_mock_user_database.dart';
import '../models/beno_project_model.dart';
import 'beno_login_page.dart';
import 'beno_payment_page.dart';
import '../widgets/loading_indicator.dart';

import '../logic/auth_provider.dart';

class Design1HomePage extends StatefulWidget {
  const Design1HomePage({super.key});

  @override
  State<Design1HomePage> createState() => _Design1HomePageState();
}

// mtn_digital
class _Design1HomePageState extends State<Design1HomePage> {
  BenoMockUserDataType? _currentUser;
  late Map<String, BenoMockUserDataType> _appData;
  bool _isLoading = true;
  final GlobalKey _registrationFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _appData = benoMockUserDatabase;
    // _loadCurrentUser();
    // Let the UI build first before loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentUser();
    });
  }

  Future<void> _loadCurrentUser() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final loggedInUserId = prefs.getString('loggedInUserId');
      if (loggedInUserId != null && _appData.containsKey(loggedInUserId)) {
        _currentUser = _appData[loggedInUserId];
      } else {
        _currentUser = null;
      }
    } catch (e) {
      debugPrint("Error loading prefs: $e");
      _currentUser = null;
    }
    // await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoading = false);
  }

  Future<void> _handleLogin(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUserId', userId);
    setState(() {
      _currentUser = _appData[userId];
    });
  }

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUserId');
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _currentUser = null;
      _isLoading = false;
    });
  }

  void _handleForgotPassword(String idNumber) {
    if (idNumber.isEmpty) {
      _showAlertDialog("Please enter your National ID number first.");
      return;
    }
    final user = _appData[idNumber];
    if (user != null) {
      _showAlertDialog(
          "A password reset link has been sent to the phone number associated with this ID. Your default password is your ID number: $idNumber");
    } else {
      _showAlertDialog("This ID number is not registered in the system.");
    }
  }

  void _handlePaymentSuccess() {
    final userId = _currentUser?.formData.sectionA.idNo;
    if (userId != null) {
      setState(() {
        _appData[userId]!.hasPaid = true;
        _currentUser = _appData[userId];
      });
    }
  }

  void _handleFormUpdate(BenoFormDataType updatedFormData) {
    final userId = _currentUser?.formData.sectionA.idNo;
    if (userId != null) {
      setState(() {
        _appData[userId]!.formData = updatedFormData;
        _currentUser = _appData[userId];
      });
      _showAlertDialog("Your details have been successfully updated!");
    }
  }

  void _scrollToRegistration() {
    Scrollable.ensureVisible(_registrationFormKey.currentContext!,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: LoadingIndicator());
    }

    if (_currentUser == null) {
      return BenoLoginPage(
        onLogin: _handleLogin,
        onForgotPassword: _handleForgotPassword,
        // onSignUp: () {},
        onSignUp: () {
          // This is the second instance of the fix
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ),
          );
        },
      );
    }

    if (!_currentUser!.hasPaid) {
      return BenoPaymentPage(
        onPaymentSuccess: _handlePaymentSuccess,
        currentUser: _currentUser!.formData,
      );
    }

    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.isLoading) {
          return const Scaffold(body: LoadingIndicator());
        }
        if (!auth.isLoggedIn) {
          // return BenoLoginPage(
          //   onLogin: (String id) {
          //     return Future.value();
          //   },
          //   // onLogin: (String id) async {
          //   //   // temporary logic or no-op
          //   //   return;
          //   // },
          //   onForgotPassword: (String id) {},
          // );
          return BenoLoginPage(
            onLogin: (id) => auth.login(id),
            // onForgotPassword: (id) => auth.forgotPassword(id),
            onForgotPassword: (String id) {},
            onSignUp: () {
              // This is where you handle navigation to the sign-up page
              // For example, using Navigator to push a new route
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const SignUpPage(), // Assuming you have a SignUpPage widget
                ),
              );
            },
          );
        }
        if (!auth.currentUser!.hasPaid) {
          return BenoPaymentPage(
            onPaymentSuccess: auth.handlePaymentSuccess,
            currentUser: auth.currentUser!.formData,
          );
        }

        return HomeContent(
          onLogout: _handleLogout,
          currentUser: _currentUser!,
          onFormUpdate: _handleFormUpdate,
          onRefresh: _loadCurrentUser,
          registrationFormKey: _registrationFormKey,
          onScrollToRegister: _scrollToRegistration,
        );
        // return Scaffold(
        //   body: RefreshIndicator(
        //     onRefresh: _loadCurrentUser,
        //     child: CustomScrollView(
        //       slivers: [
        //         BenoHeader(
        //           onLogout: _handleLogout,
        //           currentUser: _currentUser!.formData.personalDetails,
        //           onScrollToRegister: () {},
        //         ),
        //         SliverList(
        //           delegate: SliverChildListDelegate([
        //             const HeroSection(),
        //             BenoRegistrationForm(
        //               currentUserData: _currentUser!.formData,
        //               onUpdate: _handleFormUpdate,
        //             ),
        //             const FeaturesSection(),
        //             const PricingSection(),
        //             const BenoFooter(),
        //           ]),
        //         ),
        //       ],
        //     ),
        //   ),
        // );

//   }
// }
      },
    );
  }
}
