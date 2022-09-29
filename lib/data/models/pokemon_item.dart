class PokemonItem {
  String name;
  String url;

  List<Object> get props => [url, name];

  PokemonItem(this.name, this.url);

  factory PokemonItem.fromMap(Map<String, dynamic> map) {
    return PokemonItem(
      map['name'] ?? '',
      map['url'] ?? '',
    );
  }

  Map<String, dynamic> toDBMap() {
    return {
      'name': name,
      'url': url,
    };
  }
}
