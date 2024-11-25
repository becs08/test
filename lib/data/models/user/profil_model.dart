import '../../../domain/entities/profil_entity.dart';
import 'menu_model.dart';

class Profil extends ProfilEntity {
  Profil({
    required super.id,
    required super.code,
    required super.libelle,
    required super.menus
  });

  factory Profil.fromJson(Map<String,dynamic> json){
    return Profil(
        id: json['id'],
        code: json['code'],
        libelle: json['libelle'],
        menus: (json['menus'] as List).map((m)=> Menu.fromJson(m)).toList()
    );
  }

}