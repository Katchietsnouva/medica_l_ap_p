// screens/home_content.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/components/footer_header/mobile_nav_panel.dart';
import 'package:flutter/material.dart';
import '../data/beno_mock_user_database.dart';
import '../models/beno_project_model.dart';
import '../components/sections/beno_hero_section.dart';
import '../components/sections/beno_features_section.dart';
import '../components/sections/beno_pricing_section.dart';
import '../components/sections/beno_registration_form.dart';
import '../components/footer_header/beno_footer.dart';
import '../components/footer_header/beno_header.dart';

class HomeContent extends StatelessWidget {
  final VoidCallback onLogout;
  final BenoMockUserDataType currentUser;
  final Function(BenoFormDataType) onFormUpdate;
  final Future<void> Function() onRefresh;
  final GlobalKey registrationFormKey;
  final VoidCallback onScrollToRegister;

  const HomeContent({
    super.key,
    required this.onLogout,
    required this.currentUser,
    required this.onFormUpdate,
    required this.onRefresh,
    required this.registrationFormKey,
    required this.onScrollToRegister,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1100;

    return Scaffold(
      // The endDrawer is our animated side panel.
      // endDrawer: MobileNavPanel(
      //   currentUser: currentUser.formData.personalDetails,
      //   onLogout: onLogout,
      // ),
      endDrawer: isMobile
          ? MobileNavPanel(
              currentUser: currentUser.formData.sectionA,
              onLogout: onLogout,
            )
          : null,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            // The BenoHeader is now a pure SliverAppBar, which is correct.
            BenoHeader(
              onLogout: onLogout,
              currentUser: currentUser.formData.sectionA,
              onScrollToRegister: onScrollToRegister,
              // parentContext: context, // 👈 NEW
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                // const HeroSection(onRegister: () {  },),
                HeroSection(
                  onRegister: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BenoRegistrationForm(
                          currentUserData: BenoFormDataType(
                            sectionA: SectionA(),
                            sectionB: SectionB(),
                            sectionC: SectionC(),
                          ),
                          onUpdate: (data) {
                            // Handle form submission (e.g., API call)
                            print(data.toJson());
                          },
                        ),
                      ),
                    );
                  },
                ),
                BenoRegistrationForm(
                  key: registrationFormKey,
                  currentUserData: currentUser.formData,
                  onUpdate: onFormUpdate,
                ),
                // const FeaturesSection(),
                // const PricingSection(),
                const BenoFooter(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
