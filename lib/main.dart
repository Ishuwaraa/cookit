import 'package:cookit/Screens/home.dart';
import 'package:cookit/components/bottom_nav_bar.dart';
import 'package:cookit/screens/wrapper.dart';
import 'package:cookit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //if not using MaterialApp gott use the Directionality stuff LTR or RTL
    //default in MaterialApp is LTR
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class TestNavbar extends StatelessWidget {
  const TestNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavBar(),
    );
  }
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COOKIT'),
      ),
      body: const Text('Hello World!'),
    );
  }
}
