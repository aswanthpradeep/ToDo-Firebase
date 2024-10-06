import 'package:flutter/material.dart';
import 'package:loginfire/Pages/add_task.dart';
import 'package:loginfire/Pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginfire/Pages/homescreen.dart';
import 'package:loginfire/Pages/registerpage.dart';
import 'package:loginfire/Pages/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        
        '/': (context) => const Homepage(),
        '/register':(context) => const Registerpage(),
        '/homeScreen':(context) => const HomeScreen(),
        '/addtask':(context) => const AddTask(),
        '/splash': (context) =>  SplashScreen()

        
      },
      debugShowCheckedModeBanner: false,
    //  home:  Homepage(),

    );
  }
}
