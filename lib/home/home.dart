import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';

class HompePage extends StatefulWidget {
  const HompePage({super.key});

  @override
  State<HompePage> createState() => _HompePageState();
}

class _HompePageState extends State<HompePage> {
  final LocationService locationService = LocationService();

  String locationMessage = "Localisation en attente...";
  String address = "Adresse en attente...";
  String weatherMessage = "Météo en attente...";
  String temperature = "Température en attente...";
  String tempmin = "Température min en attente...";
  String tempmax = "Température max en attente...";
  String feels = "Ressentie en attente...";
  String humidity = "Humidité en attente...";
  String wind = "Vent en attente...";

  @override
  void initState() {
    super.initState();
    fetchLocationAndWeather();
  }

  Future<void> fetchLocationAndWeather() async {
    try {
      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        setState(() {
          locationMessage =
              "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        });

        address = await locationService.getAddressFromCoordinates(
            position.latitude, position.longitude);

        // Affichage de l'adresse
        setState(() {
          address = address;
        });

        //Données météo
        Map<String, dynamic> weatherData = await locationService.getWeather(
            position.latitude, position.longitude);

        setState(() {
          weatherMessage = weatherData['weather'][0]['description'];
          temperature = "${weatherData['main']['temp']} °C";
          tempmin = "${weatherData['main']['temp_min']} °C";
          tempmax = "${weatherData['main']['temp_max']} °C";
          feels = "${weatherData['main']['feels_like']} °C";
          humidity = "${weatherData['main']['humidity']} %";
        });
      }
    } catch (e) {
      setState(() {
        locationMessage = "Erreur : $e";
        address = "Erreur : $e";
        weatherMessage = "Erreur : $e";
        temperature = "Erreur : $e";
        tempmin = "Erreur : $e";
        tempmax = "Erreur : $e";
        feels = "Erreur : $e";
        humidity = "Erreur : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          elevation: 0,
          title: const Text(
            'Meteo Alerte',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            // Bouton avec l'icône utilisateur et le texte "Connexion"
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  // Action à effectuer lors du clic sur ce bouton
                  Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors
                        .blue, // Vous pouvez changer la couleur du bouton ici
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Connexion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(children: [
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Temperature
                Text(
                  temperature,
                  style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12.0,
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 54),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thermostat,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Min : $tempmin",
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thermostat,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Max : $tempmax",
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Feels Like
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.accessibility_new,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Ressenti : $feels",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_queue,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Description : $weatherMessage",
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Humidity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Humidité : $humidity",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
