class PokemonItemApiDto {
  final String name;
  final String url;

  PokemonItemApiDto({
    required this.name,
    required this.url,
  });

  factory PokemonItemApiDto.fromApiMap(Map<String, dynamic> map) {
    return PokemonItemApiDto(
      name: map['name'],
      url: map['url'],
    );
  }
}
