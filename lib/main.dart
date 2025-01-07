import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meteo_alerte/home/home.dart';
import 'package:meteo_alerte/home/signin.dart';
import 'package:meteo_alerte/pages/homelogged.dart';
import 'package:meteo_alerte/pages/sidepages/map.dart';
import 'package:meteo_alerte/pages/sidepages/assistance.dart';
import 'package:meteo_alerte/pages/sidepages/parametre.dart';
import 'home/login.dart';
import 'home/splash.dart';
import 'services/screenservice.dart';
import 'home/homesecond.dart';
import 'model/screen.dart';
void main() async {




await Supabase.initialize(
    url:
        'https://ltfojjgddtsighhhmarp.supabase.co', // URL de votre projet Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0Zm9qamdkZHRzaWdoaGhtYXJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgzODMzNTMsImV4cCI6MjA0Mzk1OTM1M30.FyPfveLx1U43k6-KMzfHWZVkzkb5jzb1nubbGBj8boY'
  );
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
        '/assistance': (context) => const AssistancePage(),
        '/parametre': (context) => const ParametrePage(),
        '/homesecond': (context) => const HomeSecond(),

      },
    );
  }
}
