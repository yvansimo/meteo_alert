import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationService {
  Logger logger = Logger();

  Future<bool> login({required String login, required String pwd}) async {
    try {
      // Connexion avec Supabase en utilisant l'email et le mot de passe fournis.
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: login,
        password: pwd,
      );

      if (response.user != null) {
        // Enregistrement du token et email dans SharedPreferences
        final preferences = await SharedPreferences.getInstance();
        await preferences.setString('token', response.session!.accessToken);
        await preferences.setString('email', login);

        // Journalisation pour vérifier que les valeurs sont bien enregistrées
        logger.i('Email: ${preferences.getString('email')}');
        logger.i('Token: ${preferences.getString('token')}');

        return true; // Connexion réussie
      }
    } on AuthException catch (e) {
      // Gestion des exceptions liées à l'authentification.
      logger.e("Erreur exception authentification : $e");
      return false;
    } catch (e) {
      logger.e("Erreur login ou pwd authentification : $e");
    }
    return false; // Retourne false si la connexion échoue
  }
}
