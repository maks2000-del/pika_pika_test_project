import 'package:pika_pika_test_project/features/pokemon_app/data/models/sqlDtos/pokemon_sql_dto.dart';

import '../../../../injector.dart';
import 'interfaces/i_local_data_source.dart';
import '../models/sqlDtos/pokemon_item_sql_dto.dart';
import '../../domain/entities/pokemon_item.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/interfaces/pokemon_data_interface.dart';

enum CashingStatus { success, failure }

class CashDataRepository implements ILocalDataRepository {
  final ILocalDataSourceEntity _localDataProvider =
      i.get<ILocalDataSourceEntity>();

  @override
  Future<Pokemon> getPokemonById(int pokemonId) async {
    final List entities = await _localDataProvider.getEntityById(pokemonId);
    final PokemonSqlDto pokemonSqlDto = PokemonSqlDto.fromMap(entities.first);
    Pokemon pokemonItem = Pokemon.fromSqlDto(pokemonSqlDto);
    return pokemonItem;
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) async {
    final pokemonItems = <PokemonItem>[];
    final dbPokemonItems = await _localDataProvider.getEntities();

    for (final item in dbPokemonItems) {
      final PokemonItemSqlDto pokemonItemSqlDto =
          PokemonItemSqlDto.fromMap(item as Map<String, dynamic>);
      PokemonItem pokemonItem = PokemonItem.fromSqlDto(pokemonItemSqlDto);
      //var pokemonItem = PokemonItem.fromMap(item as Map<String, dynamic>);
      pokemonItems.add(pokemonItem);
    }
    return pokemonItems;
  }

  @override
  Future<CashingStatus> savePokemonById(int pokemonId, Pokemon pokemon) async {
    final PokemonSqlDto pokemonSqlDto = pokemon.toSqlDto(pokemonId);
    final entitie = pokemonSqlDto.toMap();

    final cashingStatus =
        await _localDataProvider.saveEntityById(pokemonId, entitie);
    return cashingStatus;
  }

  @override
  Future<CashingStatus> savePokemonItems(List<PokemonItem> items) async {
    final entities = <Map<String, dynamic>>[];

    for (final item in items) {
      final PokemonItemSqlDto pokemonItemSqlDto = item.toSqlDto();
      final Map<String, dynamic> pokemonEntitie = pokemonItemSqlDto.toDBMap();
      entities.add(pokemonEntitie);
    }
    final status = await _localDataProvider.saveEntities(entities);
    return status;
  }
}
