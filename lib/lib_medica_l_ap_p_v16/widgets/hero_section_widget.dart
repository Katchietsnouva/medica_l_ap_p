// lib/lib_medica_l_ap_p/widgets/hero_section_widget.dart
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/utils/app_theme.dart';

class HeroSectionWidget extends StatelessWidget {
  final ScrollController scrollController;

  const HeroSectionWidget({Key? key, required this.scrollController})
      : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }

  // The new Hero Section Widget
  // Widget _buildHeroSection(BuildContext context) {
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage('assets/medica_l_ap_p/images/hero_image.png'),
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.2),
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppTheme.primaryColorLight.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Protect What Matters Most',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              blurRadius: 8.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Choose a tailored medical cover plan for you, your spouse, or your entire family with Royal Med.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              fontSize: 18,
                              height: 1.6,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      NouvaButton(
                        onPressed: () {
                          scrollController.animateTo(
                            MediaQuery.of(context).size.height / 3,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                          );
                          // Scrollable.ensureVisible(
                          // _formSectionKey.currentContext!,
                          // scrollController: _scrollController,
                          // duration: const Duration(milliseconds: 500),
                          // curve: Curves.easeInOut,
                          // );
                        },
                        text: 'Get Cover Now',
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class HeroSectionWidget extends StatefulWidget {
//   const HeroSectionWidget({super.key});

//   @override
//   State<HeroSectionWidget> createState() => _HeroSectionWidgetState();
// }

// class _HeroSectionWidgetState extends State<HeroSectionWidget> {
//   @override
//   // Widget build(BuildContext context) {
//   //   return const Placeholder();
//   // }




// }