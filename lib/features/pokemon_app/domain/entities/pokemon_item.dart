import '../../../../core/utils/string_formatter.dart';
import '../../data/models/apiDtos/pokemon_item_api_dto.dart';
import '../../data/models/sqlDtos/pokemon_item_sql_dto.dart';

class PokemonItem {
  final String id;
  final String name;
  final String url;

  PokemonItem({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PokemonItem.fromApiDto(PokemonItemApiDto pokemonItemApiDto) {
    return PokemonItem(
      id: StringFormatter.getIdFromUrl(pokemonItemApiDto.url),
      name: pokemonItemApiDto.name,
      url: pokemonItemApiDto.url,
    );
  }

  factory PokemonItem.fromSqlDto(PokemonItemSqlDto pokemonItemSqlDto) =>
      PokemonItem(
        id: pokemonItemSqlDto.id.toString(),
        name: pokemonItemSqlDto.name,
        url: pokemonItemSqlDto.url,
      );

  PokemonItemSqlDto toSqlDto() {
    return PokemonItemSqlDto(
      id: int.parse(id),
      name: name,
      url: url,
    );
  }
}
