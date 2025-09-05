import 'package:flutter/material.dart';
import '../ui/beno_ui_components.dart';

class BenoFooter extends StatelessWidget {
  const BenoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final footerColor = isDarkMode ? Colors.black : const Color(0xFF111827);
    final textColor = Colors.grey[400];
    final titleColor = Colors.white;

    return Container(
      color: footerColor,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // <=== Fix: Align children to the left on small screens
                  children:
                      _buildFooterContent(context, titleColor, textColor, true),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    _buildFooterContent(context, titleColor, textColor, false)
                        .map((w) => Expanded(child: w))
                        .toList(),
              );
            },
          ),
          const SizedBox(height: 48),
          Text(
            '© ${DateTime.now().year} Jubilee Insurance. All rights reserved.',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFooterContent(BuildContext context, Color? titleColor,
      Color? textColor, bool isVertical) {
    final verticalSpacing =
        isVertical ? const SizedBox(height: 32) : Container();
    return [
      _buildInfoColumn(titleColor, textColor),
      verticalSpacing,
      // _buildLinksColumn('Quick Links',
      //     ['About Us', 'Services', 'Contact', 'Login'], titleColor, textColor),
      verticalSpacing,
      _buildLinksColumn(
          'Contact Info',
          [
            '123 Church Street, Nairobi',
            '+254 123 456 789',
            'info@deliverancechurch.org'
          ],
          titleColor,
          textColor),
      verticalSpacing,
      // _buildNewsletterColumn(context, titleColor, textColor),
    ];
  }

  Widget _buildInfoColumn(Color? titleColor, Color? textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // const Icon(Icons.church, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            // Text('Deliverance Church',
            //     style: TextStyle(
            //         color: titleColor,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold)),
            Image(
              image: AssetImage('assets/mtn_digital/images/logo.png'),
              height: 48,
            ),
            SizedBox(width: 12),
            Text(
              'Jubilee Insurance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Securing your family's future through faith and fellowship.",
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }

  Widget _buildLinksColumn(
      String title, List<String> links, Color? titleColor, Color? textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: titleColor, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(link, style: TextStyle(color: textColor)),
            )),
      ],
    );
  }

  Widget _buildNewsletterColumn(
      BuildContext context, Color? titleColor, Color? textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Newsletter',
            style: TextStyle(
                color: titleColor, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('Subscribe to our newsletter for updates.',
            style: TextStyle(color: textColor)),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(
                child: TextField(
                    decoration: InputDecoration(hintText: 'Enter your email'))),
            ElevatedButton(onPressed: () {}, child: const Text('Subscribe')),
          ],
        ),
      ],
    );
  }
}
