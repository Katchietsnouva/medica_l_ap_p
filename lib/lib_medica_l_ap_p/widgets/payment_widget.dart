import 'package:flutter/material.dart';
// import '../models/beno_project_model.dart';
// import '../components/ui/beno_ui_components.dart';
import '../widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';

void popupfxn_with_msg(BuildContext context, String message,
    {bool isError = false, VoidCallback? onClose}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // Auto-navigate to dashboard after 5 seconds for success messages
      if (!isError) {
        Future.delayed(const Duration(seconds: 5), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Close dialog
            Navigator.pushNamed(context, '/dashboard'); // Navigate to dashboard
          }
        });
      }
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: isError ? Colors.red : Colors.green,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              if (!isError && onClose != null) {
                onClose(); // Trigger navigation for success
              }
            },
            child: Text(isError ? 'Close' : 'Go to Dashboard'),
          ),
        ],
      );
    },
  );
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _phoneController = TextEditingController();
  final _partialPaymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPaying = false;
  String _paymentStatus = '';
  double? _remainingBalance; // 💰 Track remaining balance

  // Dummy Premium Calculation Logic
  double _calculatePremium(int? coverAmount) {
    if (coverAmount == null) return 0.0;
    // Example logic: Premium is 0.15% of the cover amount per year
    return (coverAmount * 0.0015);
  }

  Future<void> _handlePayment() async {
    if (!_formKey.currentState!.validate()) {
      return; // Don't proceed if form is invalid
    }

    setState(() {
      _isPaying = true;
      _paymentStatus = 'Sending payment request to your phone...';
    });

    // Simulate M-Pesa STK Push
    await Future.delayed(const Duration(seconds: 4));

    // Simulate success or failure
    final bool paymentSucceeded = true; // Change to false to test failure
    final provider = context.read<AppProvider>();
    final premium = provider.premium;
    final partialPayment =
        double.tryParse(_partialPaymentController.text.trim()) ?? 0.0;
    final remainingAmount = premium - partialPayment;

    if (paymentSucceeded) {
      // setState(() => _paymentStatus =
      //     'Payment of ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(partialPayment)} successful! Remaining: ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(remainingAmount)}. Welcome to Royal Med.');
      // // You could navigate to the dashboard here after a short delay
      popupfxn_with_msg(
        context,
        'Payment of ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(partialPayment)} successful! Remaining: ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(remainingAmount)}. Welcome to Royal Med.',
        onClose: () => Navigator.pushNamed(context, '/dashboard'),
      );
    } else {
      setState(() {
        _paymentStatus = 'Payment failed. Please try again.';
        _isPaying = false;
      });
      popupfxn_with_msg(
        context,
        'Payment failed. Please try again.',
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _partialPaymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Read data directly from the provider
    final provider = context.watch<AppProvider>();
    // final premium = _calculatePremium(provider.selectedCoverAmount);
    final premium = provider.premium;
    final currencyFormat =
        NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ');

    return Container(
      // elevation: 4,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.secondaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryColor.withOpacity(0.85),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),
      margin: const EdgeInsets.only(top: 32),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Complete Your Payment',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
                'To activate your cover, please complete the annual premium payment via M-Pesa.',
                style: Theme.of(context).textTheme.bodyMedium),
            const Divider(height: 40),
            // // Display the selected plan details
            // _buildDetailRow('Selected Cover:',
            //     '${NumberFormat.compact().format(provider.selectedCoverAmount)}'),
            // const SizedBox(height: 8),
            // _buildDetailRow('Annual Premium:', currencyFormat.format(premium),
            //     isHighlight: true),
            _buildDetailRow('Selected Cover:',
                '${NumberFormat.compact().format(provider.selectedCoverAmount)}'),
            const SizedBox(height: 8),
            _buildDetailRow('Annual Premium:', currencyFormat.format(premium),
                isHighlight: true),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'M-Pesa Phone Number',
                      prefixIcon: Icon(Icons.phone_android),
                      hintText: 'e.g., 0712345678',
                    ),
                    keyboardType: TextInputType.phone,
                    enabled: !_isPaying,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(r'^(0)[17]\d{8}$').hasMatch(value)) {
                        return 'Please enter a valid Safaricom number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _partialPaymentController,
                    decoration: const InputDecoration(
                      labelText: 'Amount to Pay Now (Ksh)',
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      hintText: 'e.g., 1000',
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !_isPaying,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Enter a valid positive amount';
                      }
                      if (amount > premium) {
                        return 'Amount cannot exceed premium (${currencyFormat.format(premium)})';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final paidNow = double.tryParse(value.trim()) ?? 0;
                      setState(() {
                        _remainingBalance = premium - paidNow;
                      });
                    },
                  ),
                  // if (_remainingBalance != null) ...[
                  //   const SizedBox(height: 12),
                  //   Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Remaining Balance: ${currencyFormat.format(_remainingBalance)}',
                  //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //             color: Colors.orange[800],
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //     ),
                  //   ),
                  // ],
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Remaining Balance: ${_remainingBalance != null ? currencyFormat.format(_remainingBalance) : premium}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_isPaying)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(_paymentStatus, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: _handlePayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.backgroundColor,
                ),
                child: Text(
                    'Pay ${currencyFormat.format(double.tryParse(_partialPaymentController.text) ?? premium)}'),
              ),
            if (!_isPaying && _paymentStatus.contains('failed'))
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _paymentStatus,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            if (!_isPaying && _partialPaymentController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Remaining: ${currencyFormat.format(premium - (double.tryParse(_partialPaymentController.text) ?? 0.0))}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                const TextStyle(color: AppTheme.subtleTextColor, fontSize: 16)),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? AppTheme.primaryColor : AppTheme.textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// // import '../models/beno_project_model.dart';
// // import '../components/ui/beno_ui_components.dart';
// import '../widgets/loading_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import '../providers/app_provider.dart';
// import '../utils/app_theme.dart';

// class PaymentWidget extends StatefulWidget {
//   const PaymentWidget({super.key});

//   @override
//   State<PaymentWidget> createState() => _PaymentWidgetState();
// }

// class _PaymentWidgetState extends State<PaymentWidget> {
//   final _phoneController = TextEditingController();
//   final _partialPaymentController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isPaying = false;
//   String _paymentStatus = '';

//   // Dummy Premium Calculation Logic
//   double _calculatePremium(int? coverAmount) {
//     if (coverAmount == null) return 0.0;
//     // Example logic: Premium is 0.15% of the cover amount per year
//     return (coverAmount * 0.0015);
//   }

//   Future<void> _handlePayment() async {
//     if (!_formKey.currentState!.validate()) {
//       return; // Don't proceed if form is invalid
//     }

//     setState(() {
//       _isPaying = true;
//       _paymentStatus = 'Sending payment request to your phone...';
//     });

//     // Simulate M-Pesa STK Push
//     await Future.delayed(const Duration(seconds: 4));

//     // Simulate success or failure
//     final bool paymentSucceeded = true; // Change to false to test failure
//     final provider = context.read<AppProvider>();
//     final premium = provider.premium;
//     final partialPayment =
//         double.tryParse(_partialPaymentController.text.trim()) ?? 0.0;
//     final remainingAmount = premium - partialPayment;

//     if (paymentSucceeded) {
//       setState(() => _paymentStatus =
//           'Payment of ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(partialPayment)} successful! Remaining: ${NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ').format(remainingAmount)}. Welcome to Royal Med.');
//       // You could navigate to the dashboard here after a short delay
//     } else {
//       setState(() {
//         _paymentStatus = 'Payment failed. Please try again.';
//         _isPaying = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _partialPaymentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Read data directly from the provider
//     final provider = context.watch<AppProvider>();
//     // final premium = _calculatePremium(provider.selectedCoverAmount);
//     final premium = provider.premium;
//     final currencyFormat =
//         NumberFormat.currency(locale: 'en_KE', symbol: 'Ksh ');

//     return Container(
//       // elevation: 4,
//       padding: const EdgeInsets.all(32.0),
//       decoration: BoxDecoration(
//         color: AppTheme.surfaceColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppTheme.secondaryColor, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: AppTheme.secondaryColor.withOpacity(0.85),
//             blurRadius: 12,
//             offset: const Offset(0, 5),
//           )
//         ],
//       ),
//       margin: const EdgeInsets.only(top: 32),
//       child: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Complete Your Payment',
//                 style: Theme.of(context).textTheme.headlineMedium),
//             const SizedBox(height: 8),
//             Text(
//                 'To activate your cover, please complete the annual premium payment via M-Pesa.',
//                 style: Theme.of(context).textTheme.bodyMedium),
//             const Divider(height: 40),
//             // // Display the selected plan details
//             // _buildDetailRow('Selected Cover:',
//             //     '${NumberFormat.compact().format(provider.selectedCoverAmount)}'),
//             // const SizedBox(height: 8),
//             // _buildDetailRow('Annual Premium:', currencyFormat.format(premium),
//             //     isHighlight: true),
//             _buildDetailRow('Selected Cover:',
//                 '${NumberFormat.compact().format(provider.selectedCoverAmount)}'),
//             const SizedBox(height: 8),
//             _buildDetailRow('Annual Premium:', currencyFormat.format(premium),
//                 isHighlight: true),
//             const SizedBox(height: 24),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _phoneController,
//                     decoration: const InputDecoration(
//                       labelText: 'M-Pesa Phone Number',
//                       prefixIcon: Icon(Icons.phone_android),
//                       hintText: 'e.g., 0712345678',
//                     ),
//                     keyboardType: TextInputType.phone,
//                     enabled: !_isPaying,
//                     validator: (value) {
//                       if (value == null ||
//                           !RegExp(r'^(0)[17]\d{8}$').hasMatch(value)) {
//                         return 'Please enter a valid Safaricom number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _partialPaymentController,
//                     decoration: const InputDecoration(
//                       labelText: 'Amount to Pay Now (Ksh)',
//                       prefixIcon: Icon(Icons.monetization_on_outlined),
//                       hintText: 'e.g., 1000',
//                     ),
//                     keyboardType: TextInputType.number,
//                     enabled: !_isPaying,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an amount';
//                       }
//                       final amount = double.tryParse(value);
//                       if (amount == null || amount <= 0) {
//                         return 'Enter a valid positive amount';
//                       }
//                       if (amount > premium) {
//                         return 'Amount cannot exceed premium (${currencyFormat.format(premium)})';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             if (_isPaying)
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const CircularProgressIndicator(),
//                       const SizedBox(height: 16),
//                       Text(_paymentStatus, textAlign: TextAlign.center),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               ElevatedButton(
//                 onPressed: _handlePayment,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: AppTheme.backgroundColor,
//                 ),
//                 child: Text(
//                     'Pay ${currencyFormat.format(double.tryParse(_partialPaymentController.text) ?? premium)}'),
//               ),
//             if (!_isPaying && _paymentStatus.contains('failed'))
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Text(
//                   _paymentStatus,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       color: Colors.red, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             if (!_isPaying && _partialPaymentController.text.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Text(
//                   'Remaining: ${currencyFormat.format(premium - (double.tryParse(_partialPaymentController.text) ?? 0.0))}',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value,
//       {bool isHighlight = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style:
//                 const TextStyle(color: AppTheme.subtleTextColor, fontSize: 16)),
//         Text(
//           value,
//           style: TextStyle(
//             color: isHighlight ? AppTheme.primaryColor : AppTheme.textColor,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
