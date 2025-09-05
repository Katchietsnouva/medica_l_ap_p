// screens/about_page.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/sections/beno_features_section.dart';
import 'package:flutter/material.dart';
import '../widgets/universal_page_layout.dart'; // Update import path if needed

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // appBar: AppBar(title: const Text("About Us")),
    // body: const Center(child: Text("About Page Content")));

    return UniversalPageLayout(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About the Benevolent Ministry',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The Benevolent Ministry Scheme was founded to support members of our church during times of hardship, especially surrounding loss and bereavement. Our mission is to promote a Christ-like spirit of compassion and community by providing spiritual and financial assistance to members in need.\n\nWe believe that no member should walk through difficult times alone, and our ministry is designed to ensure that every person is cared for and supported by the broader church family.',
                      style: TextStyle(height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Our Core Values',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    const BulletList(items: [
                      'Compassion and empathy in action',
                      'Transparency and accountability',
                      'Unity and community support',
                      'Dignity in grief and hardship',
                    ]),
                    const FeaturesSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 18)),
                    Expanded(
                        child: Text(item, style: const TextStyle(height: 1.5))),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
