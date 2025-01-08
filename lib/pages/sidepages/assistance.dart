import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  // Méthode pour lancer un appel téléphonique
  Future<void> _launchPhone(String phoneNumber) async {
  // Formater l'URL correctement avec le schéma 'tel:'
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  try {
    // Vérifier si l'URL peut être lancée
    if (await canLaunchUrl(phoneUri)) {
      // Lancer l'application téléphone avec le numéro donné
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'appeler $phoneNumber';
    }
  } catch (e) {
    print('Erreur lors de l\'appel: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assistance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[900],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      _buildListTile(
                        context,
                        icon: Icons.fire_truck,
                        title: 'Sapeurs-Pompiers',
                        subtitle: '18',
                        phoneNumber: '18',
                      ),
                      _buildListTile(
                        context,
                        icon: Icons.location_city,
                        title: 'Mairie',
                        subtitle: '02 41 XX XX XX',
                        phoneNumber: '0753398731',
                      ),
                      _buildListTile(
                        context,
                        icon: Icons.local_police,
                        title: 'Police Préfecture',
                        subtitle: '17',
                        phoneNumber: '17',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String phoneNumber,
  }) {
    return Card(
      color: Colors.black.withOpacity(0.6),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () {
          _launchPhone(phoneNumber); // Appeler le numéro
        },
      ),
    );
  }
}
