import 'package:obi/domain/entities/boutique_entity.dart';

class Boutique extends BoutiqueEntity {
  Boutique({
    required super.id,
    required super.nom,
    required super.adresse,
    required super.telephone,
    required super.email
  });

  factory Boutique.fromJson(Map<String,dynamic> json){
    return Boutique(
        id: json['id'],
        nom: json['nom'],
        adresse: json['adresse'],
        telephone: json['telephone'],
        email: json['email']
    );
  }

}