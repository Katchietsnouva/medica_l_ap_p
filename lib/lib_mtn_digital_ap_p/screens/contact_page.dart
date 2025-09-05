// screens/contact_page.dart
import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_beno_app/widgets/universal_page_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(title: const Text("Contact Us")),
    //     body: const Center(child: Text("Contact Page Content")));
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
                      'Get in Touch',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'We are here to assist you. For any inquiries, questions about your membership, claims, or general concerns, feel free to contact us through the following channels:',
                      style: TextStyle(height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    const ContactItem(
                      icon: Icons.email,
                      title: 'Email',
                      detail: 'support@deliverancebenevolent.org',
                    ),
                    const ContactItem(
                      icon: Icons.phone,
                      title: 'Phone',
                      detail: '+254 700 123 456',
                    ),
                    const ContactItem(
                      icon: Icons.location_on,
                      title: 'Office Location',
                      detail: 'Deliverance Church, Umoja 2, Nairobi, Kenya',
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'We typically respond within 1–2 business days. Thank you for being a valued member of our ministry.',
                      style: TextStyle(height: 1.5),
                    ),
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

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const ContactItem({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(detail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
