// // lib/utils/app_theme.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static const Color primaryColor = Color(0xFF37008C);
//   static const Color secondaryColor = Color(0xFF37008C); // Keeping it consistent
//   static const Color accentColor = Color(0xFF00C6AE); // For special highlights
//   static const Color backgroundColor = Color(0xFFF8F9FA);
//   static const Color surfaceColor = Color.fromARGB(255, 237, 228, 249);
//   static const Color textColor = Color(0xFF343A40);
//   static const Color subtleTextColor = Color(0xFF6C757D);

//   static ThemeData get theme {
//     return ThemeData(
//       primaryColor: primaryColor,
//       scaffoldBackgroundColor: backgroundColor,
//       fontFamily: GoogleFonts.poppins().fontFamily,
//       cardTheme: CardTheme(
//         elevation: 1,
//         color: Colors.white,
//         surfaceTintColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//       textTheme: TextTheme(
//         displaySmall: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 36),
//         headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: textColor, fontSize: 24),
//         titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: textColor, fontSize: 18),
//         bodyMedium: GoogleFonts.poppins(color: subtleTextColor, fontSize: 14, height: 1.5),
//         labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: primaryColor,
//           side: const BorderSide(color: primaryColor, width: 2),
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

// lib/utils/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor =
      // Color(0xFF007BFF);
      // Color.fromARGB(255, 88, 167, 185);
      Color(0xFF37008C);

  static const Color secondaryColor =
      // Color(0xFF00C6AE);
      Color(0xFF37008C);

  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color.fromARGB(255, 224, 245, 249);
  static const Color textColor = Color(0xFF343A40);
  static const Color subtleTextColor = Color(0xFF6C757D);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: 24,
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: textColor,
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: subtleTextColor,
          fontSize: 14,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
