import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';

class HomeLoggedPage extends StatefulWidget {
  const HomeLoggedPage({super.key});

  @override
  State<HomeLoggedPage> createState() => _HomeLoggedPageState();
}

class _HomeLoggedPageState extends State<HomeLoggedPage> {
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue[900],
              ),
              child: const Text(
                'Meteo alert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Accueil'),
              onTap: () {
                // Action pour l'option 1
                Navigator.pop(context); // Ferme le Drawer
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.map,
              ),
              title: const Text('Carte'),
              onTap: () {
                // Action pour l'option 2
                Navigator.pushNamed(context, '/map'); // Ferme le Drawer
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.warning,
              ),
              title: const Text('Risques'),
              onTap: () {
                // Action pour l'option 2
                Navigator.pushNamed(context, '/risk'); // Ferme le Drawer
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: const Text('Deconnexion'),
              onTap: () {
                // Action pour l'option 2
                Navigator.pushNamed(context, '/home'); // Deconnexion
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white, // Couleur de l'icône (blanc)
              ),
              onPressed: () {
                // Utilisation du bon contexte pour ouvrir le Drawer
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
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
          // Bouton avec les trois points
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert,
                  color: Colors.white), // Icône avec trois points
              onSelected: (value) {
                if (value == 'Déconnexion') {
                  // Action à effectuer lors du clic sur Déconnexion
                  Navigator.pushNamed(context, '/home');
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'Nom',
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Yvan'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Déconnexion',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Déconnexion'),
                    ],
                  ),
                ),
              ],
              color: Colors.white,
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
    );
  }
}
