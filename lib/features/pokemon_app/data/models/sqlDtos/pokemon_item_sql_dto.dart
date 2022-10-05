class PokemonItemSqlDto {
  final int id;
  final String name;
  final String url;

  PokemonItemSqlDto({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PokemonItemSqlDto.fromMap(Map<String, dynamic> map) =>
      PokemonItemSqlDto(
        id: map['id'],
        name: map['name'],
        url: map['url'],
      );

  Map<String, dynamic> toDBMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
