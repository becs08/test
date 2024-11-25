import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_paths.dart'; //

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // pour naviguer vers la page de connexion au clic
          GoRouter.of(context).go(AppPaths.login);
        },
        child: Container(
          color: Colors.white, // Fond blanc
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Alignement du texte et l'image
              children: [
                // Logo circulaire
                Image.asset(
                  'asset/logo(1).png', //
                  height: 90, // taille de l'image
                ),
                const SizedBox(width: 5), // Espace entre le logo et le texte
                // Texte "Bi"
                const Text(
                  'Bi',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF232954), //
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
