class Meteo {
  final String cityName;
  final String mainCondition;
  final String description;
  final double temperature;

  Meteo({
    required this.cityName,
    required this.mainCondition,
    required this.description,
    required this.temperature,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) {
    return Meteo(
      cityName: json['name'] ?? 'Ville inconnue',
      mainCondition: json['weather'][0]['main'] ?? 'Inconnu',
      description: json['weather'][0]['description'] ?? 'Pas de description',
      temperature: json['main']['temp'] ?? 0.0,
    );
  }
}