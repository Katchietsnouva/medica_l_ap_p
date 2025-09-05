// screens/beno_login_page.dart
import 'package:flutter/material.dart';
import '../components/ui/beno_ui_components.dart';
import '../widgets/loading_indicator.dart';
import '../data/beno_mock_user_database.dart';

class BenoLoginPage extends StatefulWidget {
  final Future<void> Function(String id) onLogin;
  final void Function(String id) onForgotPassword;
  final VoidCallback onSignUp;

  const BenoLoginPage({
    super.key,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onSignUp,
  });

  @override
  State<BenoLoginPage> createState() => _BenoLoginPageState();
}

class _BenoLoginPageState extends State<BenoLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  final _idFocus = FocusNode();
  final _passwordFocus = FocusNode();

  String _error = '';
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _idFocus.requestFocus();
    });
  }

  Future<void> _handleLogin() async {
    setState(() => _error = '');

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final user = benoMockUserDatabase[_idController.text];
    if (user != null && user.password == _passwordController.text) {
      try {
        await widget.onLogin(_idController.text);
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _error = 'Login failed. Please try again.';
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Invalid National ID or Password.';
        });
      }
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _idFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validateId(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your National ID';
    if (v.trim().length < 6) return 'Please enter a valid ID';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password';
    if (v.length < 4) return 'Password must be at least 4 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headline = theme.textTheme.headlineSmall;
    final body = theme.textTheme.bodyMedium;
    const Color jubileeRed = Color(0xFFc21b2d);
    const Color jubileeGrey = Color(0xFFf0f0f0);

    return Scaffold(
      backgroundColor: jubileeGrey,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36.0),
          child: BenoCard(
            maxWidth: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Umbrella Scheme Header
                Container(
                  color: jubileeRed,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Text(
                    'UMBRELLA SCHEME',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Jubilee Logo
                        const SizedBox(height: 10),
                        const Text(
                          'Jubilee Life Insurance Limited',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        //

                        Text('Member Login',
                            style: headline?.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          'Access the Jubilee Umbrella Scheme.',
                          style: body,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 22),

                        // National ID
                        TextFormField(
                          controller: _idController,
                          focusNode: _idFocus,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'National ID Number',
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: 'e.g. 12345678',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 10.0),
                          ),
                          validator: _validateId,
                          onFieldSubmitted: (_) {
                            _passwordFocus.requestFocus();
                          },
                        ),
                        const SizedBox(height: 14),

                        // Password with show/hide
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 10.0),
                            suffixIcon: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(
                                    () => _obscurePassword = !_obscurePassword);
                              },
                            ),
                          ),
                          validator: _validatePassword,
                          onFieldSubmitted: (_) => _handleLogin(),
                        ),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () =>
                                widget.onForgotPassword(_idController.text),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue[800],
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text('Forgot Password?'),
                          ),
                        ),

                        // Error message
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: _error.isNotEmpty
                              ? Row(
                                  key: const ValueKey('error'),
                                  children: [
                                    const Icon(Icons.error_outline,
                                        color: jubileeRed, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _error,
                                        style: const TextStyle(
                                            color: jubileeRed, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(
                                  key: ValueKey('no-error'),
                                ),
                        ),

                        const SizedBox(height: 18),

                        // Login button (animated)
                        SizedBox(
                          width: double.infinity,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _isLoading
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: LoadingIndicator(size: 24),
                                  )
                                : ElevatedButton(
                                    key: const ValueKey('login-btn'),
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: jubileeRed,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Create Account button
                        TextButton(
                          onPressed: widget.onSignUp,
                          child: const Text('Create an Account'),
                        ),

                        const SizedBox(height: 8),

                        // small info text
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login with your National ID number. By default your password is your National ID number',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // screens/beno_login_page.dart
// import 'package:flutter/material.dart';
// import '../components/ui/beno_ui_components.dart';
// import '../widgets/loading_indicator.dart';
// import '../data/beno_mock_user_database.dart';

// class BenoLoginPage extends StatefulWidget {
//   final Future<void> Function(String id) onLogin;
//   final void Function(String id) onForgotPassword;

//   const BenoLoginPage({
//     super.key,
//     required this.onLogin,
//     required this.onForgotPassword,
//   });

//   @override
//   State<BenoLoginPage> createState() => _BenoLoginPageState();
// }

// class _BenoLoginPageState extends State<BenoLoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _idController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final _idFocus = FocusNode();
//   final _passwordFocus = FocusNode();

//   String _error = '';
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();
//     // put focus on the ID field when the page opens
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _idFocus.requestFocus();
//     });
//   }

//   Future<void> _handleLogin() async {
//     // clear previous error
//     setState(() => _error = '');

//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//     });

//     // simulate small latency (keep existing behavior)
//     await Future.delayed(const Duration(seconds: 1));

//     final user = benoMockUserDatabase[_idController.text];
//     if (user != null && user.password == _passwordController.text) {
//       // successful login
//       try {
//         await widget.onLogin(_idController.text);
//       } catch (e) {
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//             _error = 'Login failed. Please try again.';
//           });
//         }
//       }
//     } else {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _error = 'Invalid National ID or Password.';
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _idController.dispose();
//     _passwordController.dispose();
//     _idFocus.dispose();
//     _passwordFocus.dispose();
//     super.dispose();
//   }

//   String? _validateId(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Please enter your National ID';
//     if (v.trim().length < 6) return 'Please enter a valid ID';
//     return null;
//   }

//   String? _validatePassword(String? v) {
//     if (v == null || v.isEmpty) return 'Please enter your password';
//     if (v.length < 4) return 'Password must be at least 4 characters';
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final headline = theme.textTheme.headlineSmall;
//     final body = theme.textTheme.bodyMedium;
//     const Color jubileeRed = Color(0xFFc21b2d);
//     const Color jubileeGrey = Color(0xFFf0f0f0);

//     return Scaffold(
//       backgroundColor: jubileeGrey,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36.0),
//           child: BenoCard(
//             maxWidth: 480,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Umbrella Scheme Header
//                 Container(
//                   color: jubileeRed,
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   child: const Text(
//                     'UMBRELLA SCHEME',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Jubilee Logo
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Jubilee Life Insurance Limited',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         //
//                         Text('Member Login',
//                             style: headline?.copyWith(
//                                 fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Access the Jubilee Umbrella Scheme.',
//                           style: body,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 22),

//                         // National ID
//                         TextFormField(
//                           controller: _idController,
//                           focusNode: _idFocus,
//                           textInputAction: TextInputAction.next,
//                           decoration: const InputDecoration(
//                             labelText: 'National ID Number',
//                             prefixIcon: Icon(Icons.person_outline),
//                             hintText: 'e.g. 12345678',
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 14.0, horizontal: 10.0),
//                           ),
//                           validator: _validateId,
//                           onFieldSubmitted: (_) {
//                             _passwordFocus.requestFocus();
//                           },
//                         ),
//                         const SizedBox(height: 14),

//                         // Password with show/hide
//                         TextFormField(
//                           controller: _passwordController,
//                           focusNode: _passwordFocus,
//                           obscureText: _obscurePassword,
//                           textInputAction: TextInputAction.done,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             border: const OutlineInputBorder(),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 14.0, horizontal: 10.0),
//                             suffixIcon: IconButton(
//                               tooltip: _obscurePassword
//                                   ? 'Show password'
//                                   : 'Hide password',
//                               icon: Icon(
//                                 _obscurePassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               onPressed: () {
//                                 setState(
//                                     () => _obscurePassword = !_obscurePassword);
//                               },
//                             ),
//                           ),
//                           validator: _validatePassword,
//                           onFieldSubmitted: (_) => _handleLogin(),
//                         ),

//                         // Forgot password
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: TextButton(
//                             onPressed: () =>
//                                 widget.onForgotPassword(_idController.text),
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.blue[800],
//                               padding: EdgeInsets.zero,
//                               alignment: Alignment.centerLeft,
//                             ),
//                             child: const Text('Forgot Password?'),
//                           ),
//                         ),

//                         // Error message
//                         const SizedBox(height: 12),
//                         AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 250),
//                           child: _error.isNotEmpty
//                               ? Row(
//                                   key: const ValueKey('error'),
//                                   children: [
//                                     const Icon(Icons.error_outline,
//                                         color: jubileeRed, size: 18),
//                                     const SizedBox(width: 8),
//                                     Expanded(
//                                       child: Text(
//                                         _error,
//                                         style: const TextStyle(
//                                             color: jubileeRed, fontSize: 13),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : const SizedBox.shrink(
//                                   key: ValueKey('no-error'),
//                                 ),
//                         ),

//                         const SizedBox(height: 18),

//                         // Login button (animated)
//                         SizedBox(
//                           width: double.infinity,
//                           child: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 200),
//                             child: _isLoading
//                                 ? const Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 8.0),
//                                     child: LoadingIndicator(size: 24),
//                                   )
//                                 : ElevatedButton(
//                                     key: const ValueKey('login-btn'),
//                                     onPressed: _handleLogin,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: jubileeRed,
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 16.0),
//                                       shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.zero,
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Login',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         // small info text
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Login with your National ID number. By default your password is your National ID number',
//                             style: theme.textTheme.bodySmall?.copyWith(
//                               color: Colors.grey[600],
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // // screens/beno_login_page.dart
// // import 'package:flutter/material.dart';
// // import '../components/ui/beno_ui_components.dart';
// // import '../widgets/loading_indicator.dart';
// // import '../data/beno_mock_user_database.dart';

// // class BenoLoginPage extends StatefulWidget {
// //   final Future<void> Function(String id) onLogin;
// //   final void Function(String id) onForgotPassword;

// //   const BenoLoginPage({
// //     super.key,
// //     required this.onLogin,
// //     required this.onForgotPassword,
// //   });

// //   @override
// //   State<BenoLoginPage> createState() => _BenoLoginPageState();
// // }

// // class _BenoLoginPageState extends State<BenoLoginPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _idController = TextEditingController();
// //   final _passwordController = TextEditingController();

// //   final _idFocus = FocusNode();
// //   final _passwordFocus = FocusNode();

// //   String _error = '';
// //   bool _isLoading = false;
// //   bool _obscurePassword = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // put focus on the ID field when the page opens
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _idFocus.requestFocus();
// //     });
// //   }

// //   Future<void> _handleLogin() async {
// //     // clear previous error
// //     setState(() => _error = '');

// //     if (!_formKey.currentState!.validate()) return;

// //     setState(() {
// //       _isLoading = true;
// //     });

// //     // simulate small latency (keep existing behavior)
// //     await Future.delayed(const Duration(seconds: 1));

// //     final user = benoMockUserDatabase[_idController.text];
// //     if (user != null && user.password == _passwordController.text) {
// //       // successful login
// //       try {
// //         await widget.onLogin(_idController.text);
// //       } catch (e) {
// //         if (mounted) {
// //           setState(() {
// //             _isLoading = false;
// //             _error = 'Login failed. Please try again.';
// //           });
// //         }
// //       }
// //     } else {
// //       if (mounted) {
// //         setState(() {
// //           _isLoading = false;
// //           _error = 'Invalid National ID or Password.';
// //         });
// //       }
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _idController.dispose();
// //     _passwordController.dispose();
// //     _idFocus.dispose();
// //     _passwordFocus.dispose();
// //     super.dispose();
// //   }

// //   String? _validateId(String? v) {
// //     if (v == null || v.trim().isEmpty) return 'Please enter your National ID';
// //     if (v.trim().length < 6) return 'Please enter a valid ID';
// //     return null;
// //   }

// //   String? _validatePassword(String? v) {
// //     if (v == null || v.isEmpty) return 'Please enter your password';
// //     if (v.length < 4) return 'Password must be at least 4 characters';
// //     return null;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final headline = theme.textTheme.headlineSmall;
// //     final body = theme.textTheme.bodyMedium;

// //     return Scaffold(
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36.0),
// //           child: BenoCard(
// //             maxWidth: 480,
// //             child: Padding(
// //               padding: const EdgeInsets.all(24.0),
// //               child: Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     // header
// //                     const Icon(Icons.church, size: 56, color: Colors.blue),
// //                     const SizedBox(height: 14),
// //                     Text('Member Login', style: headline),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       'Access the Benevolent Ministry Scheme.',
// //                       style: body,
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     const SizedBox(height: 22),

// //                     // National ID
// //                     TextFormField(
// //                       controller: _idController,
// //                       focusNode: _idFocus,
// //                       textInputAction: TextInputAction.next,
// //                       decoration: const InputDecoration(
// //                         labelText: 'National ID Number',
// //                         prefixIcon: Icon(Icons.badge),
// //                         hintText: 'e.g. 12345678',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       validator: _validateId,
// //                       onFieldSubmitted: (_) {
// //                         _passwordFocus.requestFocus();
// //                       },
// //                     ),
// //                     const SizedBox(height: 14),

// //                     // Password with show/hide
// //                     TextFormField(
// //                       controller: _passwordController,
// //                       focusNode: _passwordFocus,
// //                       obscureText: _obscurePassword,
// //                       textInputAction: TextInputAction.done,
// //                       decoration: InputDecoration(
// //                         labelText: 'Password',
// //                         prefixIcon: const Icon(Icons.lock),
// //                         border: const OutlineInputBorder(),
// //                         suffixIcon: IconButton(
// //                           tooltip: _obscurePassword
// //                               ? 'Show password'
// //                               : 'Hide password',
// //                           icon: Icon(
// //                             _obscurePassword
// //                                 ? Icons.visibility
// //                                 : Icons.visibility_off,
// //                           ),
// //                           onPressed: () {
// //                             setState(
// //                                 () => _obscurePassword = !_obscurePassword);
// //                           },
// //                         ),
// //                       ),
// //                       validator: _validatePassword,
// //                       onFieldSubmitted: (_) => _handleLogin(),
// //                     ),

// //                     // Error message
// //                     const SizedBox(height: 12),
// //                     AnimatedSwitcher(
// //                       duration: const Duration(milliseconds: 250),
// //                       child: _error.isNotEmpty
// //                           ? Row(
// //                               key: const ValueKey('error'),
// //                               children: [
// //                                 const Icon(Icons.error_outline,
// //                                     color: Colors.red, size: 18),
// //                                 const SizedBox(width: 8),
// //                                 Expanded(
// //                                   child: Text(
// //                                     _error,
// //                                     style: const TextStyle(
// //                                         color: Colors.red, fontSize: 13),
// //                                   ),
// //                                 ),
// //                               ],
// //                             )
// //                           : const SizedBox.shrink(
// //                               key: ValueKey('no-error'),
// //                             ),
// //                     ),

// //                     const SizedBox(height: 18),

// //                     // Login button (animated)
// //                     SizedBox(
// //                       width: double.infinity,
// //                       child: AnimatedSwitcher(
// //                         duration: const Duration(milliseconds: 200),
// //                         child: _isLoading
// //                             ? const Padding(
// //                                 padding: EdgeInsets.symmetric(vertical: 8.0),
// //                                 child: LoadingIndicator(size: 24),
// //                               )
// //                             : BenoButton(
// //                                 key: const ValueKey('login-btn'),
// //                                 onPressed: _handleLogin,
// //                                 text: 'Login',
// //                                 isFullWidth: true,
// //                               ),
// //                       ),
// //                     ),

// //                     // Forgot password
// //                     Align(
// //                       alignment: Alignment.centerRight,
// //                       child: TextButton(
// //                         onPressed: () =>
// //                             widget.onForgotPassword(_idController.text),
// //                         child: const Text('Forgot Password?'),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 8),

// //                     // divider + small info text
// //                     const Divider(height: 20),
// //                     Align(
// //                       alignment: Alignment.centerLeft,
// //                       child: Text(
// //                         'Login with your National ID number. By default your password is your National ID number',
// //                         style: theme.textTheme.bodySmall?.copyWith(
// //                           color: Colors.grey[600],
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
