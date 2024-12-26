class Risk {
  final String libelle;
  final bool present;

  Risk({required this.libelle, required this.present});

  // Méthode pour créer un objet Risk à partir d'un JSON
  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
      libelle: json['libelle'] ?? '',
      present: json['present'] ?? false,
    );
  }
}

class RiskData {
  final String adresse;
  final String commune;
  final String url;
  final List<Risk> risquesNaturels;
  final List<Risk> risquesTechnologiques;

  RiskData({
    required this.adresse,
    required this.commune,
    required this.url,
    required this.risquesNaturels,
    required this.risquesTechnologiques,
  });

  // Méthode pour créer un objet RiskData à partir du JSON
  factory RiskData.fromJson(Map<String, dynamic> json) {
    return RiskData(
      adresse: json['adresse']['libelle'] ?? '',
      commune: json['commune']['libelle'] ?? '',
      url: json['url'] ?? '',
      risquesNaturels: (json['risquesNaturels'] as Map<String, dynamic>)
          .values
          .where((e) => e['present'] == true)
          .map((e) => Risk.fromJson(e))
          .toList(),
      risquesTechnologiques:
          (json['risquesTechnologiques'] as Map<String, dynamic>)
              .values
              .where((e) => e['present'] == true)
              .map((e) => Risk.fromJson(e))
              .toList(),
    );
  }
}
