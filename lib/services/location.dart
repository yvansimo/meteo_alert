import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static const String _googleMapsApiKey =
      'AIzaSyB9qb8KuInEXGfFqgxVAGRRUwBOGr1BHOY';
  static const String _openWeatherApiKey = 'acdec6550b15fc49361173c2e8080191';

  Future<Position?> getCurrentLocation() async {
    try {
      // Vérifiez si les services de localisation sont activés
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Veuillez activer les services de localisation.");
      }

      // Vérifiez et demandez les permissions de localisation
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permission de localisation refusée.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Permission refusée définitivement.");
      }

      // Récupérez la localisation actuelle
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 5),
        ),
      );

      return position;
    } catch (e) {
      throw Exception("Erreur lors de la récupération de la localisation : $e");
    }
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleMapsApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        } else {
          return "Aucune adresse trouvée via Google Maps.";
        }
      } else {
        throw Exception("Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erreur lors de l'appel API : $e");
    }
  }

  Future<List<Map<String, dynamic>>> getNearbyPlaces(
      double latitude, double longitude, String type) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&type=$type&key=$_googleMapsApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          // Retourner une liste de lieux
          return data['results']
              .map<Map<String, dynamic>>((place) => {
                    'name': place['name'],
                    'location': LatLng(
                      place['geometry']['location']['lat'],
                      place['geometry']['location']['lng'],
                    ),
                    'address': place['vicinity'],
                  })
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            "Erreur lors de la récupération des lieux : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erreur API Google Places : $e");
    }
  }

  Future<Map<String, dynamic>> getWeather(
      double latitude, double longitude) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&lang=fr&appid=$_openWeatherApiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Retourne les données météo brutes
      } else {
        throw Exception("Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erreur lors de l'appel API météo : $e");
    }
  }
}
