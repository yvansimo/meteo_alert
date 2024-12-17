import 'package:flutter/material.dart';

class HomeLoggedPage extends StatefulWidget {
  const HomeLoggedPage({super.key});

  @override
  State<HomeLoggedPage> createState() => _HomeLoggedPageState();
}

class _HomeLoggedPageState extends State<HomeLoggedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
