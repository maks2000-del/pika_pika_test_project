import 'package:pika_pika_test_project/domain/entities/pokemon.dart';

import 'package:pika_pika_test_project/data/models/pokemon_item.dart';

import '../repositories/interfaces/pokemon_data_interface.dart';

class HomeUsecase implements IDataRepository {
  final IDataRepository dataRepository;
  HomeUsecase(this.dataRepository);

  @override
  Future<Pokemon> getPokemonById(int pokemonId) {
    return dataRepository.getPokemonById(pokemonId);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) {
    return dataRepository.getPokemonItems(startIndex);
  }
}
