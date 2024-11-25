
import 'package:obi/data/models/user/boutique_model.dart';
import 'package:obi/data/models/user/profil_model.dart';

import '../../../domain/entities/user_entity.dart';

class User extends UserEntity {
  User({
    required super.prenom,
    required super.nom,
    required super.email,
    required super.telephone,
    required super.profil,
    required super.boutique
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        prenom: json['prenom'],
        nom: json['nom'],
        email: json['email'],
        telephone: json['telephone'],
        profil: Profil.fromJson(json['profil']),
        boutique: Boutique.fromJson(json['boutique'])
    );
  }

}