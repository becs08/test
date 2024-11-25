import '../../../domain/entities/menu_entity.dart';

class Menu extends MenuEntity {
  Menu({
    required super.id,
    required super.route,
    required super.titre,
    required super.type,
    required super.icone,
    required super.ordre
  });

  factory Menu.fromJson(Map<String,dynamic> json) {
    return Menu(
        id: json['id'],
        route: json['route'],
        titre: json['titre'],
        type: json['type'],
        icone: json['icone'],
        ordre: json['ordre']
    );
  }

}