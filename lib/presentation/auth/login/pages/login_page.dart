
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obi/common/bloc/auth/auth_state.dart';
import 'package:obi/common/bloc/auth/auth_state_cubit.dart';
import '../../../../common/bloc/button/button_state.dart';
import '../../../../common/bloc/button/button_state_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_labels.dart';
import '../../../../core/constants/app_messages.dart';
import '../../../../core/constants/app_paths.dart';
import '../../../../data/models/auth/login_request.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _telephoneCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Permet le défilement si le contenu dépasse la hauteur de l'écran
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // Espace en haut
              _logoSection(), // Section du logo
              const SizedBox(height: 20), // Espacement entre le logo et le texte
              const Text(
                "Remplissez le formulaire pour accéder à votre compte",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF52525B),
                ),
              ),
              const SizedBox(height: 17), // Espacement avant le champ identifiant
              _emailField(), // Champ identifiant
              const SizedBox(height: 17), // Espacement avant le champ mot de passe
              _passwordField(), // Champ mot de passe
              const SizedBox(height: 8), // Espacement avant le bouton mot de passe oublié
              _forgotPasswordButton(), // Bouton "Mot de passe oublié"
              const SizedBox(height: 25), // Espacement avant le bouton Connexion
              _loginButton(context), // Bouton Connexion
              const SizedBox(height: 20), // Espacement avant l'option S’inscrire
              _registerOption(), // Option "Je n’ai pas de compte, S’inscrire"
              const SizedBox(height: 40), // Espacement avant la séparation
              _divider(), // Ligne de séparation avec "OU"
              const SizedBox(height: 17), // Espacement avant les options biométriques
              _biometricOptions(), // Options biométriques (Empreintes digitales, Face ID)
            ],
          ),
        ),
      ),
    );
  }

  // Section du logo
  Widget _logoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'asset/logo(1).png', // Chemin du logo
          height: 70, // Taille du logo
        ),
        const SizedBox(width: 3), // Espacement entre le logo et le texte
        const Text(
          "Bi",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF232954),
          ),
        ),
      ],
    );
  }


  // Champ pour l'identifiant
  Widget _emailField() {
    return TextField(
      controller: _telephoneCon,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.person), // Icône utilisateur
        hintText: "Identifiant", // Placeholder
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Champ pour le mot de passe
  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      obscureText: true, // Masquer le texte pour les mots de passe
      decoration: InputDecoration(
      suffixIcon: const Icon(Icons.remove_red_eye_outlined), // Icône hide
        hintText: "Mot de passe", // Placeholder
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Bouton "Mot de passe oublié"
  Widget _forgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Logique pour gérer l'oubli de mot de passe
        },
        child: const Text(
          "Mot de passe oublié ?",
          style: TextStyle(
            color: Color(0xFF232954),
          ),
        ),
      ),
    );
  }

  // Bouton Connexion
  Widget _loginButton(BuildContext context) {
   return ElevatedButton(
      onPressed: () {
        // Logique de connexion
        context.read<AuthStateCubit>().login(
          LoginRequest(
            login: _telephoneCon.text, // Identifiant saisi
            password: _passwordCon.text, // Mot de passe saisi
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF39221), // Couleur orange du bouton
        minimumSize: Size(MediaQuery.of(context).size.width, 50), // Largeur et hauteur
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Boutons arrondis
        ),
      ),
      child: const Text(
        "Connexion", // Texte du bouton
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Option "Je n’ai pas de compte, S’inscrire"
  Widget _registerOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Je n’ai pas de compte, "),
        GestureDetector(
          onTap: () {
            // Logique pour gérer l'inscription
          },
          child: const Text(
            "S’inscrire",
            style: TextStyle(
              color: Color(0xFF232954), // Couleur bleue
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Ligne de séparation
  Widget _divider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("OU"),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Options biométriques
  Widget _biometricOptions() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.fingerprint, size: 40, color: Colors.grey), // Icône empreintes digitales
            SizedBox(height: 8), // Espacement entre l'icône et le texte
            Text("Empreintes"),
          ],
        ),
        Column(
          children: [
            Icon(Icons.face, size: 40, color: Colors.grey), // Icône Face ID
            SizedBox(height: 8), // Espacement entre l'icône et le texte
            Text("Face ID"),
          ],
        ),
      ],
    );
  }
}
