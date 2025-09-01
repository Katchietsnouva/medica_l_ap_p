// lib/lib_medica_l_ap_p/widgets/payment_widget.dart
import 'package:flutter/material.dart';
// import '../models/beno_project_model.dart';
// import '../components/ui/beno_ui_components.dart';
import '../widgets/loading_indicator.dart';
// lib/widgets/payment_widget.dart
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPaying = false;
  String _paymentStatus = '';

  // Dummy Premium Calculation Logic
  double _calculatePremium(int? coverAmount) {
    if (coverAmount == null) return 0.0;
    // Example logic: Premium is 0.15% of the cover amount per year
    return (coverAmount * 0.0015);
  }

  Future<void> _handlePayment() async {
    if (!_formKey.currentState!.validate()) {
      return; // Don't proceed if phone number is invalid
    }

    setState(() {
      _isPaying = true;
      _paymentStatus = 'Sending payment request to your phone...';
    });

    // Simulate M-Pesa STK Push
    await Future.delayed(const Duration(seconds: 4));

    // Simulate success or failure
    final bool paymentSucceeded = true; // Change to false to test failure

    if (paymentSucceeded) {
      setState(
          () => _paymentStatus = 'Payment successful! Welcome to Royal Med.');
      // You could navigate to the dashboard here after a short delay
    } else {
      setState(() {
        _paymentStatus = 'Payment failed. Please try again.';
        _isPaying = false;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
            const SizedBox(height: 24),

            // M-Pesa Input
            Form(
              key: _formKey,
              child: TextFormField(
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
            ),
            const SizedBox(height: 24),

            // Pay Button or Loading Indicator
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
                  backgroundColor: AppTheme
                      .backgroundColor, // A vibrant color for the pay button
                ),
                child: Text('Pay ${currencyFormat.format(premium)}'),
              ),

            // Status message for failures
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
