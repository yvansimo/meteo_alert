import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../services/classrisk.dart';
import '../../services/location.dart';
import 'package:geolocator/geolocator.dart';

class RiskPage extends StatefulWidget {
  const RiskPage({super.key});

  @override
  State<RiskPage> createState() => _RiskPageState();
}

class _RiskPageState extends State<RiskPage> {
  final LocationService locationService = LocationService();
  late Future<RiskData> riskData;

  @override
  void initState() {
    super.initState();
    riskData =
        fetchRiskData(); // Appeler la fonction pour récupérer les données
  }

  // Fonction pour récupérer les données depuis l'API (ou d'un fichier JSON)
  Future<RiskData> fetchRiskData() async {
    try {
      // Récupérer la position actuelle de l'utilisateur
      Position? position = await locationService.getCurrentLocation();

      if (position == null) {
        throw Exception("Impossible de récupérer la position.");
      }

      double latitude = position.latitude;
      double longitude = position.longitude;

      // Faire l'appel API en passant les coordonnées dynamiques
      final response = await http.get(Uri.parse(
          'https://georisques.gouv.fr/api/v1/resultats_rapport_risque?latlon=$longitude%2C$latitude'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return RiskData.fromJson(jsonResponse); // Parse les données JSON
      } else {
        throw Exception('Erreur lors de la récupération des données');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'appel API : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the leading icon color to white
        ),
        title: const Text(
          'Risques dans la région',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.lightBlue[900],
        elevation: 0,
      ),
      body: FutureBuilder<RiskData>(
        future: riskData, // Appel de la future pour obtenir les données
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;

            return Stack(
              children: [
                // Image de fond
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Contenu de la page au-dessus de l'image
                ListView(
                  children: [
                    // Affichage de l'adresse et de la commune
                    ListTile(
                      title: Text(
                        'Adresse: ${data.adresse}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Commune: ${data.commune}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    // Affichage des risques naturels
                    if (data.risquesNaturels.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Risques Naturels',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ...data.risquesNaturels.map((risk) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 4,
                          child: ListTile(
                            title: Text(risk.libelle),
                            leading:
                                const Icon(Icons.warning, color: Colors.orange),
                            subtitle: const Text('Risque identifié'),
                          ),
                        );
                      }),
                    ],
                    // Affichage des risques technologiques
                    if (data.risquesTechnologiques.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Risques Technologiques',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ...data.risquesTechnologiques.map((risk) {
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 4,
                          child: ListTile(
                            title: Text(risk.libelle),
                            leading:
                                const Icon(Icons.dangerous, color: Colors.red),
                            subtitle: const Text('Risque identifié'),
                          ),
                        );
                      }),
                    ],
                    // Lien vers le rapport
                    ListTile(
                      title: const Text(
                        'Consulter le rapport',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Ouvrir le lien du rapport dans le navigateur
                        launchURL(data.url);
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: Text('Aucun risque détecté'));
          }
        },
      ),
    );
  }

  // Fonction pour ouvrir l'URL du rapport dans le navigateur
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    // Utilisation de la méthode canLaunchUrl et launchUrl avec la nouvelle API
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Impossible de lancer l\'URL : $url';
    }
  }
}
