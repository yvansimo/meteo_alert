import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meteo_alerte/services/screenservice.dart';
import 'package:meteo_alerte/model/screen.dart';

class HomeSecond extends StatefulWidget {
  const HomeSecond({super.key});

  @override
  State<HomeSecond> createState() => _HomeSecondState();
}

class _HomeSecondState extends State<HomeSecond> {
  final String apiKey = '59585fd28bc2f8b42824626d581cf3d7'; // Remplace par ta clé API
  late final ScreenService _screenService;
  Meteo? _meteo;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _screenService = ScreenService(apiKey);
    _fetchMeteo();
  }

  Future<void> _fetchMeteo() async {
    try {
      String coordinates = await _screenService.getCurrentCity();
      List<String> latLong = coordinates.split(',');
      double latitude = double.parse(latLong[0]);
      double longitude = double.parse(latLong[1]);

      Meteo meteoData = await _screenService.getMeteo(latitude, longitude);
      setState(() {
        _meteo = meteoData;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print("Erreur dans _fetchMeteo: $e");
    }
  }

  String getMeteoAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animations/soso.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/animations/nuageux.json';
      case 'mist':
        return 'assets/animations/brume.json';
      case 'fog':
        return 'assets/animations/nuageux.json';
      case 'rain':
        return 'assets/animations/rain.json';
      case 'clear':
        return 'assets/animations/soso.json';
      default:
        return 'assets/animations/soso.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: _meteo == null
            ? _errorMessage != null
            ? Text(
          "Erreur : $_errorMessage",
          style: const TextStyle(color: Colors.white),
        )
            : const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _meteo!.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Lottie.asset(getMeteoAnimation(_meteo?.mainCondition)),
            Text(
              '${_meteo?.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              _meteo?.description ?? '',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}