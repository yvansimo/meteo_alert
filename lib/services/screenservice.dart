import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:meteo_alerte/model/screen.dart';

class ScreenService {
  final String apiKey;

  ScreenService(this.apiKey);

  // Appelle l'API avec latitude et longitude
  Future<Meteo> getMeteo(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print('Données météo récupérées : $data');
      return Meteo.fromJson(data);
    } else {
      print('Erreur API : ${response.body}');
      throw Exception('Impossible de récupérer les données météo.');
    }
  }

  // Récupère les coordonnées actuelles de l'utilisateur
  Future<String> getCurrentCity() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Le service de localisation est désactivé.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permission de localisation refusée.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permissions de localisation refusées en permanence.");
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return '${position.latitude},${position.longitude}';
  }
}