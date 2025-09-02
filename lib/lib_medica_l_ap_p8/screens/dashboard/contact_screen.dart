import 'package:flutter/material.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/universal_page_layout.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UniversalPageLayout(
      slivers: [],
      child: const Center(
        child: Text('Contact Screen.'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ContactScreen extends StatelessWidget {
//   const ContactScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
