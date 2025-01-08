import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Démarrer un timer pour naviguer vers la route '/home' après 10 secondes
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background.jpg'), // Image de fond
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Image au centre
          Center(
            child: Image.asset(
              'assets/logoapk.png', // Image au centre
              width: 200, // Largeur de l'image
              height: 200, // Hauteur de l'image
            ),
          ),
        ],
      ),
    );
  }
}
