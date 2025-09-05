// screens/beno_payment_page.dart
import 'package:flutter/material.dart';
import '../models/beno_project_model.dart';
import '../components/ui/beno_ui_components.dart';
import '../widgets/loading_indicator.dart';

class BenoPaymentPage extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  final BenoFormDataType currentUser;

  const BenoPaymentPage({
    super.key,
    required this.onPaymentSuccess,
    required this.currentUser,
  });

  @override
  _BenoPaymentPageState createState() => _BenoPaymentPageState();
}

class _BenoPaymentPageState extends State<BenoPaymentPage> {
  late String _selectedPlan;
  late TextEditingController _phoneController;
  bool _isPaying = false;
  String _paymentStatus = '';

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.currentUser.plan;
    _phoneController =
        TextEditingController(text: widget.currentUser.sectionA.phone);
  }

  Future<void> _handlePayment() async {
    // Basic validation for Kenyan phone number
    if (!_phoneController.text.contains(RegExp(r'^(?:\+254|0)[17]\d{8}$'))) {
      setState(
          () => _paymentStatus = 'Please enter a valid Kenyan phone number.');
      return;
    }

    setState(() {
      _isPaying = true;
      _paymentStatus = 'Sending payment request to your phone...';
    });

    // Simulate M-Pesa STK Push
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _paymentStatus = 'Payment successful! Redirecting...');
    await Future.delayed(const Duration(milliseconds: 1500));
    widget.onPaymentSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final amount = _selectedPlan == 'Premium' ? '5,200' : '3,200';

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BenoCard(
            maxWidth: 500,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Complete Your Registration',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(
                      'An annual payment is required to activate your benefits. Please select a plan and pay with M-Pesa.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                          child: PlanCard(
                        title: 'Standard Plan',
                        // price: '1,500',
                        price: '3,200',
                        coverage: '50,000',
                        isSelected: _selectedPlan == 'Basic',
                        onTap: () => setState(() => _selectedPlan = 'Basic'),
                      )),
                      const SizedBox(width: 16),
                      Expanded(
                          child: PlanCard(
                        title: 'Premium Plan',
                        price: '5,200',
                        // price: '2,500',
                        coverage: '100,000',
                        isSelected: _selectedPlan == 'Premium',
                        onTap: () => setState(() => _selectedPlan = 'Premium'),
                      )),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _phoneController,
                    decoration:
                        const InputDecoration(labelText: 'M-Pesa Phone Number'),
                    enabled: !_isPaying,
                  ),
                  const SizedBox(height: 24),
                  _isPaying
                      ? const LoadingIndicator()
                      : BenoButton(
                          onPressed: _handlePayment,
                          text: 'Pay Ksh. $amount',
                          isFullWidth: true,
                        ),
                  if (_paymentStatus.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(_paymentStatus,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title, price, coverage;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard(
      {super.key,
      required this.title,
      required this.price,
      required this.coverage,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: isSelected ? Colors.blue : theme.dividerColor),
          color: isSelected ? Colors.blue.withOpacity(0.1) : null,
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Ksh. $price', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Ksh. $coverage Coverage', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
