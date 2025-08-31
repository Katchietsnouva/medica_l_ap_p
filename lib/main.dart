import 'lib_medica_l_ap_p/main.dart' as medical_app;

import 'package:flutter/material.dart';

void main() async {
  medical_app.main();
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// // ------------------- CHANGES ARE IN THIS CLASS -------------------

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   // 1. Add a boolean to track the loading state
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // 2. Start your data loading process when the widget is first created
//     _loadData();
//   }

//   // 3. Create a method to simulate a long-running task
//   Future<void> _loadData() async {
//     // This simulates a 3-second network request or any long task.
//     await Future.delayed(const Duration(seconds: 3));

//     // After the task is done, update the state to stop loading
//     // and show the main content.
//     if (mounted) {
//       // Check if the widget is still in the tree
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       // 4. Conditionally show the spinner OR your main content
//       body: _isLoading
//           ? const Center(
//               // If it's loading, show the spinner
//               child: CircularProgressIndicator(),
//             )
//           : Center(
//               // If loading is finished, show your content
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text(
//                     'Content is loaded! You have pushed the button this many times:',
//                   ),
//                   Text(
//                     '$_counter',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                 ],
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// // // import 'lib_brok_a/main.dart' as brok_a;
// // // import 'lib_beno_app/main.dart' as beno_app;
// // // import 'lib_mtn_digital_ap_p/main.dart' as mtn_digital;
// // import 'lib_medica_l_ap_p/main.dart' as medical_app;

// // import 'package:flutter/material.dart';
// // // import 'package:food/lib_brok_a/screens/ai_chat_screen.dart';

// // // import 'lib_tikto_k/main.dart' as tikto_k;
// // // import 'lib_famil_y/main.dart' as famil_y;
// // // import 'lib_tod_o_app/main.dart' as tod_o_app;
// // // import 'lib_profil_e/main.dart' as profil_e;
// // // import 'lib_chatap_p/main.dart' as chatap_p;
// // // import 'lib_insta_app/main.dart' as insta_app;
// // // import 'lib_flemo_ap_p/main.dart' as flemo_ap_p;
// // // import 'lib_nouva_neon_ap_p/main.dart' as nouva_neon_ap_p;
// // // import 'lib_nouva_neon_ap_p_2/main.dart'jubilee_ins_app as nouva_neon_ap_p_2;
// // // import 'lib_nouva_neon_ap_p_3/main.dart' as nouva_neon_ap_p_3;
// // // import 'lib_benevolent_app/main.dart' as benevolent_app;

// // // void main() {
// // //   brok_a.main();
// // //   // tikto_k.main();
// // //   // famil_y.main();
// // //   // tod_o_app.main();
// // //   // profil_e.main();
// // //   // chatap_p.main();
// // //   // insta_app.main();
// // //   // flemo_ap_p.main();
// // //   // nouva_neon_ap_p.main();
// // //   // nouva_neon_ap_p_2.main();
// // //   // nouva_neon_ap_p_3.main();
// // //   // benevolent_app.main();
// // // }

// // void main() async {
// //   // WidgetsFlutterBinding.ensureInitialized();
// //   // try {
// //   //   await dotenv.load(fileName: ".env");
// //   //   print("API Key: ${dotenv.env['OPENAI_API_KEY']}"); // ✅ Test output
// //   //   print("API Key: ${dotenv.env['OPENAI_API_KEY']}"); // ✅ Test output
// //   // } catch (e) {
// //   //   print("Could not load .env file: $e");
// //   // }
// //   // brok_a.main();
// //   // beno_app.main();
// //   // mtn_digital.main();
// //   medical_app.main();
// //   // runApp(AIChatScreen());
// // }

// // // import 'package:flutter/material.dart';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Flutter Demo',
// // //       theme: ThemeData(primarySwatch: Colors.blue),
// // //       home: MyHomePage(),
// // //     );
// // //   }
// // // }

// // // class MyHomePage extends StatefulWidget {
// // //   @override
// // //   _MyHomePageState createState() => _MyHomePageState();
// // // }

// // // class _MyHomePageState extends State<MyHomePage> {
// // //   int _counter = 0;

// // //   void _incrementCounter() {
// // //     setState(() {
// // //       _counter++;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Simple Counter App')),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: <Widget>[
// // //             Text('You have pushed the button this many times:'),
// // //             Text(
// // //               '$_counter',
// // //               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _incrementCounter,
// // //         tooltip: 'Increment',
// // //         child: Icon(Icons.add),
// // //       ),
// // //     );
// // //   }
// // // }
