// widgets/universal_page_layout.dart (✅ NEW FILE)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/footer_header/beno_header.dart';
import '../components/footer_header/mobile_nav_panel.dart';
import '../logic/auth_provider.dart';

class UniversalPageLayout extends StatelessWidget {
  final List<Widget> slivers;
  final VoidCallback? onScrollToRegister;

  const UniversalPageLayout({
    super.key,
    required this.slivers,
    this.onScrollToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.currentUser == null) {
          // This case should ideally not be hit if routing is correct,
          // but it's a good fallback.
          return const Scaffold(body: Center(child: Text("Not logged in.")));
        }
        return Scaffold(
          endDrawer: MobileNavPanel(
            currentUser: auth.currentUser!.formData.sectionA,
            onLogout: () {
              Navigator.pop(context); // Close drawer first
              auth.logout();
            },
          ),
          body: CustomScrollView(
            slivers: [
              BenoHeader(
                onLogout: auth.logout,
                currentUser: auth.currentUser!.formData.sectionA,
                onScrollToRegister: onScrollToRegister ?? () {},
              ),
              ...slivers,
            ],
          ),
        );
      },
    );
  }
}
