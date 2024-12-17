import 'package:flutter/material.dart';
import 'package:meteo_alerte/home/home.dart';
import 'package:meteo_alerte/home/signin.dart';
import 'package:meteo_alerte/pages/homelogged.dart';
import 'package:meteo_alerte/pages/sidepages/map.dart';
import 'home/login.dart';
import 'home/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HompePage(),
        '/login': (context) => const LoginPage(),
        '/signin': (context) => const SignInPage(),
        '/homelogged': (context) => const HomeLoggedPage(),
        '/map': (context) => const MapPage(),
      },
    );
  }
}
