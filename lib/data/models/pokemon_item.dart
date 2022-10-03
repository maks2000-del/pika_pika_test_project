import '../../presentation/utils/string_formatter.dart';

class PokemonItem {
  String id;
  String name;
  String url;

  PokemonItem(this.id, this.name, this.url);

  factory PokemonItem.fromMap(Map<String, dynamic> map) {
    return PokemonItem(
      StringFormatter.getIdFromUrl(map['url']),
      map['name'] ?? '',
      map['url'] ?? '',
    );
  }

  Map<String, dynamic> toDBMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
