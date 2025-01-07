import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  // Méthode pour lancer un appel téléphonique
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Impossible d\'appeler $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 32),
            // Liste des options d'assistance
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.fire_truck),
                    title: Text('Sapeurs-Pompiers'),
                    subtitle: Text('18'),
                    onTap: () {
                      _launchPhone('18'); // Appel aux pompiers
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('Mairie'),
                    subtitle: Text('Numéro mairie'), // Remplacez avec le numéro réel
                    onTap: () {
                      _launchPhone('02 41 XX XX XX'); // Remplacez avec le numéro réel de la mairie
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.local_police),
                    title: Text('Police Préfecture'),
                    subtitle: Text('17'),
                    onTap: () {
                      _launchPhone('17'); // Appel à la police
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
