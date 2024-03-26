import 'package:cookit/components/bottom_navbar.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/wrapper.dart';
import 'package:cookit/firebase_options.dart';
import 'package:cookit/services/auth.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          catchError: (_, __) => null,
          initialData: null,
          value: AuthService().currUser,
        ),
        ChangeNotifierProvider(create: (_) => RecipeStore()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Wrapper(),
      debugShowCheckedModeBanner: false,
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
