class PokemonApiDto {
  final String? name;
  final String? frontImage;
  final List types;
  final int? weight;
  final int? height;

  PokemonApiDto({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
  });

  get p => [name, frontImage, types, weight, height];

  factory PokemonApiDto.fromApiMap(Map<String, dynamic> map) {
    return PokemonApiDto(
      name: map['name'],
      frontImage: map['sprites']['front_default'],
      types: map['types'],
      weight: map['weight'],
      height: map['height'],
    );
  }
}
