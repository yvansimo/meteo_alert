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
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          // Réglage pour le mode sombre
          SwitchListTile(
            title: const Text('Mode sombre'),
            subtitle: const Text('Activer/Désactiver le mode sombre'),
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
            title: const Text('Notifications'),
            subtitle: const Text('Activer/Désactiver les notifications'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          // Autres réglages possibles
          ListTile(
            title: const Text('Langue'),
            subtitle: const Text('Modifier la langue de l\'application'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Action pour changer la langue
            },
          ),
        ],
      ),
    );
  }
}
