import 'package:flutter/material.dart';

class HompePage extends StatefulWidget {
  const HompePage({super.key});

  @override
  State<HompePage> createState() => _HompePageState();
}

class _HompePageState extends State<HompePage> {
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
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Location
                Text(
                  "Zocca, Italie",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),

                // Temperature
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Température : 1.97 °C",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Feels Like
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.accessibility_new,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Ressenti : 1.97 °C",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Humidity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Humidité : 92%",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Description
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_queue,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Description : light rain",
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Wind
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.air,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Vent : 1.22 m/s",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
