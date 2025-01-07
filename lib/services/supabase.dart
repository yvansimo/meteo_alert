import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;
  Logger logger = Logger();

  Future<void> insertUser(String username, String useremail,
      String userpass) async {
    try {
      final response = await client
          .from('users') // Nom de la table
          .insert({
        'username': username,
        'useremail': useremail,
        'userpass': userpass,
      });

      // Vérifie si l'insertion a échoué
      if (response.error != null) {
        logger.e(
            'Erreur lors de l\'insertion de l\'utilisateur : ${response.error
                .message}');
        throw Exception('Erreur : Utilisateur non inséré.');
      } else {
        logger.i('Utilisateur inséré avec succès : $username');
      }
    } catch (e) {
      logger.e('Erreur lors de l\'insertion de l\'utilisateur : $e');
      throw Exception('Une erreur s\'est produite lors de l\'insertion.');
    }
  }
}
