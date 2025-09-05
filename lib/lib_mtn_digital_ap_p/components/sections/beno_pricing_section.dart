// components/sections/beno_pricing_section.dart
import 'package:flutter/material.dart';
import '../ui/beno_ui_components.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text("Benefit Details Coverage",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 32),
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: PricingCard(isPremium: false)),
                      SizedBox(width: 24),
                      Expanded(child: PricingCard(isPremium: true)),
                    ],
                  );
                }
                return Column(
                  children: const [
                    PricingCard(isPremium: false),
                    SizedBox(height: 24),
                    PricingCard(isPremium: true),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final bool isPremium;
  const PricingCard({super.key, required this.isPremium});

  @override
  Widget build(BuildContext context) {
    final planName = isPremium ? "Premium Plan" : "Standard Plan";
    final price = isPremium ? "100,000" : "50,000";
    final features = isPremium
        ? [
            "Ksh. 2,560/-",
            "Full family coverage",
            "Annual premium payment",
            "Extra dependent cover",
            "Priority Support"
          ]
        : [
            "Ksh. 1,560/-",
            "Basic family coverage",
            "Annual premium payment",
            "Instant Cover",
            "Health Checkup"
          ];

    return BenoCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planName, style: Theme.of(context).textTheme.headlineSmall),
            Text("Coverage Amount",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text("Ksh. $price/-",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            BenoButton(
                onPressed: () {}, text: "Select Plan", isFullWidth: true),
          ],
        ),
      ),
    );
  }
}
