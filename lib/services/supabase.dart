import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bcrypt/bcrypt.dart';

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

  Future<bool> loginUser(String username, String userpass) async {
    try {
      // Effectuer une requête SELECT pour vérifier l'utilisateur
      final response = await client
          .from('users') // Nom de la table
          .select()
          .eq('username', username)
          .eq('userpass', userpass)
          .single(); // Récupère un seul enregistrement si trouvé

      // Si un utilisateur correspondant est trouvé
      if (response != null) {
        print("Connexion réussie : ${response['username']}");
        return true; // Connexion réussie
      }
    } catch (e) {
      print("Erreur lors de la connexion : $e");
    }

    return false; // Connexion échouée
  }
}
