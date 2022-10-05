import '../../../../core/utils/string_formatter.dart';
import '../../data/models/apiDtos/pokemon_api_dto.dart';
import '../../data/models/sqlDtos/pokemon_sql_dto.dart';

const nullStringFieldFromApi = 'unknown';
const nullIntieldFromApi = 0;

class Pokemon {
  final String name;
  final String frontImage;
  final List<String> types;
  final int weight;
  final int height;

  Pokemon({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
  });

  factory Pokemon.fromApiDto(PokemonApiDto pokemonApiDto) {
    return Pokemon(
      name: pokemonApiDto.name ?? nullStringFieldFromApi,
      frontImage: pokemonApiDto.frontImage ?? nullStringFieldFromApi,
      types: StringFormatter.convertApiMaptoList(pokemonApiDto.types),
      weight: pokemonApiDto.weight ?? nullIntieldFromApi,
      height: pokemonApiDto.height ?? nullIntieldFromApi,
    );
  }

  factory Pokemon.fromSqlDto(PokemonSqlDto pokemonSqlDto) => Pokemon(
        name: pokemonSqlDto.name,
        frontImage: pokemonSqlDto.frontImage,
        types: StringFormatter.convertStringDBToList(pokemonSqlDto.types),
        height: pokemonSqlDto.height,
        weight: pokemonSqlDto.weight,
      );

  PokemonSqlDto toSqlDto(int id) {
    return PokemonSqlDto(
      id: id,
      frontImage: frontImage,
      height: height,
      name: name,
      types: StringFormatter.convertListToDBString(types),
      weight: weight,
    );
  }
}
