import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meteo_alerte/pages/sidepages/risk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meteo_alerte/home/home.dart';
import 'package:meteo_alerte/home/signin.dart';
import 'package:meteo_alerte/pages/homelogged.dart';
import 'package:meteo_alerte/pages/sidepages/map.dart';
import 'home/login.dart';
import 'home/splash.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Hive
  await Hive.initFlutter();

  await Supabase.initialize(
    url:
        'https://udwhmzjggzxoomhqqult.supabase.co', // URL de votre projet Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkd2htempnZ3p4b29taHFxdWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5MDI1MjEsImV4cCI6MjA0OTQ3ODUyMX0.kEB_WM5Va9_ZgsdHxwSg_MoRJ0EBTl6ZjOsGFtC97xE', // Votre clé anonyme
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
        '/risk': (context) => const RiskPage(),
      },
    );
  }
}
