import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/firebase_options.dart';
import 'package:quiznep/startpage.dart';
import 'package:quiznep/welcompage.dart';

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
      initialRoute: 'StartPage/',
      routes: {
        'StartPage/': (context) => const Startpage(),
        'WelcomePage/': (context) => Welcompage()
      },
    );
  }
}
