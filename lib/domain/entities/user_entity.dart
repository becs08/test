
import 'boutique_entity.dart';
import 'profil_entity.dart';

class UserEntity{
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final ProfilEntity profil;
  final BoutiqueEntity boutique;

  UserEntity({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.profil,
    required this.boutique
  });

}