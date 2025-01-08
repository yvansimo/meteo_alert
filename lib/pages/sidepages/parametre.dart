import 'package:flutter/material.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});
  @override
  _ParametrePageState createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  bool isDarkMode = false; // État pour le mode sombre
  bool notificationsEnabled = true; // Exemple d'un autre réglage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the leading icon color to white
        ),
        title: const Text('Paramètres', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue[900], // AppBar en bleu
      ),
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background.jpg'), // Chemin de l'image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu principal avec texte en blanc
          ListView(
            children: [
              // Réglage pour le mode sombre
              SwitchListTile(
                title: const Text(
                  'Mode sombre',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                subtitle: const Text(
                  'Activer/Désactiver le mode sombre',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    // Appliquer le mode sombre (à implémenter selon votre app)
                  });
                },
              ),
              // Exemple : Activer/Désactiver les notifications
              SwitchListTile(
                title: const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                subtitle: const Text(
                  'Activer/Désactiver les notifications',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
              // Autres réglages possibles
              ListTile(
                title: const Text(
                  'Langue',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                subtitle: const Text(
                  'Modifier la langue de l\'application',
                  style: TextStyle(color: Colors.white), // Texte en blanc
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white, // Icône en blanc
                ),
                onTap: () {
                  // Action pour changer la langue
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}