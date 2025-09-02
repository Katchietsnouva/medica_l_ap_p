// lib/providers/dashboard_provider.dart
import 'package:flutter/material.dart';
import 'package:broka/lib_medica_l_ap_p/data/models/quote_model.dart';

class DashboardProvider extends ChangeNotifier {
  // Mock data
  final List<Quote> _quotes = [
    Quote(
      id: 'Q-123',
      coverType: 'My Family',
      coverAmount: 2000000,
      premium: 450.00,
      quoteDate: DateTime.now().subtract(const Duration(days: 10)),
      status: 'Active',
    ),
    Quote(
      id: 'Q-124',
      coverType: 'Me & Spouse',
      coverAmount: 1000000,
      premium: 280.00,
      quoteDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Pending Payment',
    )
  ];

  List<Quote> get quotes => _quotes;
  Quote get activeCover => _quotes.firstWhere((q) => q.status == 'Active');
  double get totalBalance => _quotes
      .where((q) => q.status == 'Pending Payment')
      .fold(0, (sum, item) => sum + item.premium);

  // Add more mock data and methods as needed for payments, profile, etc.
}
