// lib/data/models/quote_model.dart
class Quote {
  final String id;
  final String coverType;
  final int coverAmount;
  final double premium;
  final DateTime quoteDate;
  final String status; // e.g., "Pending Payment", "Active"

  Quote({
    required this.id,
    required this.coverType,
    required this.coverAmount,
    required this.premium,
    required this.quoteDate,
    this.status = "Pending Payment",
  });
}
