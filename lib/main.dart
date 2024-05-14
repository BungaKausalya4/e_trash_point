import 'package:first_project/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/screens/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized

  // await Firebase.initializeApp(
  //   name:'e-trash-point',
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // widget binding
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        // Add your routes here
        '/root': (context) => const RootPage(),
      },
    );
  }
}
