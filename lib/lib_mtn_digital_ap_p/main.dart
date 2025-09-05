// main.dart
// This is the entry point of your Flutter application.
import 'dart:async';

import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/logic/auth_provider.dart';
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/screens/terms_and_conditions_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/text_scale_provider.dart';
import 'logic/theme_provider.dart';
import 'screens/about_page.dart';
import 'screens/contact_page.dart';
import 'screens/design1_home_page.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('🛑 Caught Flutter Error: ${details.exceptionAsString()}');
    if (details.stack != null) {
      print(details.stack);
    }
  };

  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => ThemeProvider()),
  //       ChangeNotifierProvider(create: (context) => TextScaleProvider()),
  //       ChangeNotifierProvider(
  //           create: (context) => AuthProvider()), // ✅ NEW: Add AuthProvider
  //     ],
  //     child: const MyApp(),
  //   ),
  // );

  // runZonedGuarded(() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      // await dotenv.load(fileName: ".env");
      // print("API Key: ${dotenv.env['OPENAI_API_KEY']}");
    } catch (e) {
      print("Could not load .env file: $e");
    }

    runApp(const AppRoot());
  }, (Object error, StackTrace stackTrace) {
    print('💥 Uncaught Dart error: $error');
    print(stackTrace);
  });
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TextScaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The Consumer widget listens to ThemeProvider changes and rebuilds the UI
    return Consumer2<ThemeProvider, TextScaleProvider>(
      builder: (context, themeProvider, textScaleProvider, child) {
        return MaterialApp(
          title: 'Benevolent Ministry Scheme',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            // scaffoldBackgroundColor: Colors.white,
            scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Lighter grey
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
            fontFamily: 'Inter',
            // cardTheme: CardTheme(
            cardTheme: CardThemeData(
              elevation: 1,
              shadowColor: Colors.black.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[400]!),
                // borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            // scaffoldBackgroundColor: const Color(0xFF121212),
            scaffoldBackgroundColor: const Color(0xFF1A1D21), // Dark charcoal
            fontFamily: 'Inter',
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Inter',
                bodyColor: Colors.white70,
                displayColor: Colors.white),
            // cardTheme: CardTheme(
            cardTheme: CardThemeData(
              // color: const Color(0xFF1E1E1E),
              color: const Color(0xFF25282D),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey[800]!, width: 1),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          themeMode: themeProvider.themeMode,
          // This builder applies the global text scale factor
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler:
                    TextScaler.linear(textScaleProvider.textScaleFactor),
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          // home: const Design1HomePage(),
          initialRoute: '/',
          routes: {
            '/': (context) => const Design1HomePage(),
            '/about': (context) => const AboutPage(),
            '/contact': (context) => const ContactPage(),
            '/terms': (context) =>
                const TermsAndConditionsPage(), // Add the new route
          },
        );
      },
    );
  }
}
