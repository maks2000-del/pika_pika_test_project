import 'dart:convert';

class PokemonItem {
  String name;
  String urlId;

  List<Object> get props => [urlId, name];

  PokemonItem(this.name, this.urlId);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'urlId': urlId,
    };
  }

  factory PokemonItem.fromMap(Map<String, dynamic> map) {
    return PokemonItem(
      map['name'] ?? '',
      map['urlId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonItem.fromJson(String source) =>
      PokemonItem.fromMap(json.decode(source));
}
