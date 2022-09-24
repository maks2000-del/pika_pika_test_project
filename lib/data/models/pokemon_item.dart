class PokemonItem {
  String name;
  String urlId;

  List<Object> get props => [urlId, name];

  PokemonItem(this.name, this.urlId);

  factory PokemonItem.fromMap(Map<String, dynamic> map) {
    return PokemonItem(
      map['name'] ?? '',
      map['url'] ?? '',
    );
  }
}
