import 'package:pika_pika_test_project/presentation/utils/string_formatter.dart';

class PokemonItem {
  String id;
  String name;
  String url;

  List<Object> get props => [id, url, name];

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
