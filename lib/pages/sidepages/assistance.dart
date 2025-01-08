import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await launchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        print('DEBUG: url_launcher failed. Trying AndroidIntent...');
        final intent = AndroidIntent(
          action: 'android.intent.action.DIAL',
          data: 'tel:$phoneNumber',
        );
        await intent.launch();
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistance'),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildListTile(
              icon: Icons.fire_truck,
              title: 'Sapeurs-Pompiers',
              subtitle: '18',
              phoneNumber: '18',
            ),
            _buildListTile(
              icon: Icons.location_city,
              title: 'Mairie',
              subtitle: '02 41 XX XX XX',
              phoneNumber: '+33753398731',
            ),
            _buildListTile(
              icon: Icons.local_police,
              title: 'Police Préfecture',
              subtitle: '17',
              phoneNumber: '17',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String phoneNumber,
  }) {
    return Card(
      color: Colors.black.withOpacity(0.6),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () => _launchPhone(phoneNumber), // Lancer l'appel
      ),
    );
  }
}