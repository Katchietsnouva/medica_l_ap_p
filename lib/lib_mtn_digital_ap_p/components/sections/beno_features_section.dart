// components/sections/beno_features_section.dart
import 'package:flutter/material.dart';
import '../ui/beno_ui_components.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder - implement with real data
    return Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.2)
            : Colors.grey[100],
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          children: [
            Text("Our Benefits",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 32),
            const Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                FeatureCard(
                    icon: Icons.shield_outlined,
                    title: "Coverage Benefits",
                    description:
                        "Comprehensive benefits for you and your family members."),
                FeatureCard(
                    icon: Icons.edit_document,
                    title: "Easy Registration",
                    description:
                        "Simple and straightforward registration process."),
                FeatureCard(
                    icon: Icons.lock_outline,
                    title: "Secure Payment",
                    description: "Safe and secure online payment processing."),
              ],
            )
          ],
        ));
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: primaryColor[100],
            child: Icon(icon, size: 32, color: primaryColor),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
