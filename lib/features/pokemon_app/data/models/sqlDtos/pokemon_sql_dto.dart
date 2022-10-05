class PokemonSqlDto {
  final int id;
  final String name;
  final String frontImage;
  final String types;
  final int weight;
  final int height;

  PokemonSqlDto({
    required this.id,
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
  });

  factory PokemonSqlDto.fromMap(Map<String, dynamic> map) => PokemonSqlDto(
        id: map['id'],
        name: map['name'],
        frontImage: map['front_default'],
        types: map['types'],
        height: map['height'],
        weight: map['weight'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'front_default': frontImage,
      'types': types,
      'weight': weight,
      'height': height,
    };
  }
}
