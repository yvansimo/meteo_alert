import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  // Fonction pour insérer un utilisateur
  Future<void> insertUser(
      String username, String useremail, String userpass) async {
    final response = await client
        .from('users') // Nom de la table
        .insert({
      'username': username,
      'useremail': useremail,
      'userpass': userpass
    }); // Requête directe sans execute()

    if (response != null) {
      throw Exception(
          'Erreur : Utilisateur non inséré.'); // Lancer une exception en cas d'erreur
    }
  }
}
