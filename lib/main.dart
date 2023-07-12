import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_wall1/theme/dark_theme.dart';
import 'package:the_wall1/theme/light_theme.dart';

import 'Authentication/authentication.dart';
import 'Pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wall',
      theme: lightTheme,
      darkTheme: darkTheme,
      home:
          FirebaseAuth.instance.currentUser != null ? HomePage() : AuthOption(),
    );
  }
}
