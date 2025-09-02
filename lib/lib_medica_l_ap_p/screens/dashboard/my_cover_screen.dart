import 'package:flutter/material.dart';
import 'package:broka/lib_medica_l_ap_p/widgets/universal_page_layout.dart';

class MyCoverScreen extends StatefulWidget {
  const MyCoverScreen({super.key});

  @override
  State<MyCoverScreen> createState() => _MyCoverScreenState();
}

class _MyCoverScreenState extends State<MyCoverScreen> {
  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return UniversalPageLayout(
      slivers: [],
      child: const Center(
        child: Text('My Cover Screen Content Here'),
      ),
    );
  }
}
