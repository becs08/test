
import 'menu_entity.dart';

class ProfilEntity {
  int id;
  String code;
  String libelle;
  List<MenuEntity> menus;

  ProfilEntity({
    required this.id,
    required this.code,
    required this.libelle,
    required this.menus
  });
}