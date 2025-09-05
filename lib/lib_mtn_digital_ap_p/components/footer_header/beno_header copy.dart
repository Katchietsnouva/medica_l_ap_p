// components/footer_header/beno_header.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/theme_provider.dart';
import '../../models/beno_project_model.dart';
import '../../widgets/settings_dialog.dart';

class BenoHeader extends StatelessWidget {
  final VoidCallback onLogout;
  final BenoPersonalDetailsType currentUser;
  final VoidCallback onScrollToRegister;

  const BenoHeader({
    super.key,
    required this.onLogout,
    required this.currentUser,
    required this.onScrollToRegister,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final bgColor = isDarkMode
        ? const Color(0xFF1A1D21).withOpacity(0.85)
        : Colors.white.withOpacity(0.85);

    final isSmallScreen = MediaQuery.of(context).size.width < 450;
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      backgroundColor: bgColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
          ),
        ),
      ),
      title: Row(
        children: [
          Icon(Icons.church, color: Colors.blue, size: 28),
          SizedBox(width: 12),
          // Text('Deliverance Church', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            "Deliverance Church",
            style: TextStyle(
              fontSize: responsiveFontSize(context, baseSize: 20),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        if (MediaQuery.of(context).size.width > 800) ...[
          _navButton(context, 'Home', () => Navigator.pushNamed(context, '/')),
          _navButton(context, 'Register/Update', onScrollToRegister),
          _navButton(
              context, 'About', () => Navigator.pushNamed(context, '/about')),
          _navButton(context, 'Contact',
              () => Navigator.pushNamed(context, '/contact')),
        ],
        // isSmallScreen
        // if (!isSmallScreen) (sz)

        const SizedBox(width: 100),
        IconButton(
          tooltip: 'Display Settings',
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const SettingsDialog(),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
                currentUser.fullName.isNotEmpty ? currentUser.fullName[0] : 'U',
                style: const TextStyle(color: Colors.white)),
          ),
        ),
        IconButton(
          tooltip: 'Logout',
          icon: const Icon(Icons.logout),
          onPressed: onLogout,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _navButton(BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }
}
// // components/footer_header/beno_header.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../logic/theme_provider.dart';
// import '../../models/beno_project_model.dart';

// class BenoHeader extends StatelessWidget {
//   final VoidCallback onLogout;
//   final BenoPersonalDetailsType currentUser;
//   final VoidCallback onScrollToRegister;

//   const BenoHeader({
//     super.key,
//     required this.onLogout,
//     required this.currentUser,
//     required this.onScrollToRegister,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
//     final bgColor = isDarkMode
//         ? const Color(0xFF1A1D21).withOpacity(0.85)
//         : Colors.white.withOpacity(0.85);

//     return SliverAppBar(
//       floating: true,
//       pinned: true,
//       snap: false,
//       backgroundColor: bgColor,
//       // backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white.withOpacity(0.85),
//       elevation: 0.5,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: BoxDecoration(
//             border: Border(
//                 bottom:
//                     BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
//           ),
//         ),
//       ),
//       title: Row(
//         children: const [
//           Icon(Icons.church, color: Colors.blue, size: 28),
//           SizedBox(width: 12),
//           Text('Deliverance Church'),
//         ],
//       ),
//       actions: [
//         if (MediaQuery.of(context).size.width > 720) ...[
//           //   TextButton(onPressed: () {}, child: const Text('Home')),
//           //   TextButton(onPressed: () {}, child: const Text('Register/Update')),
//           //   TextButton(onPressed: () {}, child: const Text('Contact')),
//           //   TextButton(onPressed: () {}, child: const Text('About')),
//           // ],
//           _navButton(context, 'Home', () => Navigator.pushNamed(context, '/')),
//           _navButton(context, 'Register/Update', onScrollToRegister),
//           _navButton(
//               context, 'About', () => Navigator.pushNamed(context, '/about')),
//           _navButton(context, 'Contact',
//               () => Navigator.pushNamed(context, '/contact')),
//         ],
//         IconButton(
//           icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
//           onPressed: () => themeProvider.toggleTheme(),
//         ),
//         if (MediaQuery.of(context).size.width > 600)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Center(
//               child: Text(
//                 'Welcome, ${currentUser.fullName.split(' ')[0]}',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ),
//           ),
//         IconButton(
//           icon: const Icon(Icons.logout),
//           onPressed: onLogout,
//         ),
//       ],
//     );
//   }
// }

// Widget _navButton(BuildContext context, String text, VoidCallback onPressed) {
//   return TextButton(
//     onPressed: onPressed,
//     style: TextButton.styleFrom(
//       foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     ),
//     child: Text(text),
//   );
// }
