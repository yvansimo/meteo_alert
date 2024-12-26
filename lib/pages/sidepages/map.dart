import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationService locationService = LocationService();

  GoogleMapController? mapController; // Nullable controller
  LatLng? currentPosition;
  final Set<Marker> markers = {};

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Ensure the map is ready before interacting with it
    if (currentPosition != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(currentPosition!),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  @override
  void dispose() {
    mapController?.dispose(); // Dispose the controller safely
    super.dispose();
  }

  /// Méthode pour démarrer les mises à jour de la position
  void startLocationUpdates() {
    // Configurer les paramètres de localisation
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Mettre à jour après 10 mètres
    );

    // Écouteur de position
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        // Mise à jour de l'état avec la nouvelle position
        setState(() {
          currentPosition = LatLng(position.latitude, position.longitude);
          updateMarker(currentPosition!);
        });

        // Déplace la caméra pour centrer sur la nouvelle position
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(currentPosition!),
          );
        }
      },
    );
  }

  /// Mise à jour ou ajout d'un marqueur pour la position actuelle
  void updateMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: position,
        infoWindow: const InfoWindow(
          title: 'Votre Position',
          snippet: 'Position en temps réel',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  void fetchNearbyPlaces(String type) async {
    if (currentPosition == null) return;

    try {
      final places = await locationService.getNearbyPlaces(
        currentPosition!.latitude,
        currentPosition!.longitude,
        type,
      );

      setState(() {
        for (var place in places) {
          markers.add(
            Marker(
              markerId: MarkerId(place['name']),
              position: place['location'], // This now works with LatLng
              infoWindow: InfoWindow(
                title: place['name'],
                snippet: place['address'],
              ),
            ),
          );
        }
      });
    } catch (e) {
      print("Erreur lors de la récupération des lieux : $e");
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
          "Carte",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.lightBlue[900],
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (type) {
              markers
                  .clear(); // Réinitialiser les marqueurs avant d'ajouter les nouveaux
              fetchNearbyPlaces(type);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'hospital',
                child: Text("Afficher les hôpitaux"),
              ),
              const PopupMenuItem(
                value: 'fire_station',
                child: Text("Afficher les pompiers"),
              ),
              const PopupMenuItem(
                value: 'city_hall',
                child: Text("Afficher les mairies"),
              ),
            ],
            color: Colors.white,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition ?? const LatLng(47.4784, -0.5632),
          zoom: 11.0,
        ),
        markers: markers,
        myLocationEnabled:
            true, // Montre la position actuelle avec une icône "my location"
        myLocationButtonEnabled: true,
      ),
    );
  }
}
