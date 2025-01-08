import 'package:supabase_flutter/supabase_flutter.dart';
import 'local.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;
  final LocalDatabase localDatabase = LocalDatabase();

  // Fonction pour insérer un utilisateur
  Future<void> insertUser(
      String username, String useremail, String userpass) async {
    try {
      // Enregistrement dans la base locale
      await localDatabase.insertUser(username, useremail, userpass);

      // Enregistrement dans la base distante (Supabase)
      final response = await client.from('users').insert({
        'username': username,
        'useremail': useremail,
        'userpass': userpass,
      });

      if (response.error != null) {
        throw Exception('Erreur : Utilisateur non inséré dans Supabase.');
      }

      print('Utilisateur enregistré localement et en ligne.');
    } catch (e) {
      print('Erreur lors de l\'enregistrement : $e');
    }
    getLocalUsers();
  }

   Future<List<Map<String, dynamic>>> getLocalUsers() async {
    return await localDatabase.fetchUsers();
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
