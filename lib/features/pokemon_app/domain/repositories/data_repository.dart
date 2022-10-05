import '../entities/pokemon_item.dart';
import '../entities/pokemon.dart';
import 'interfaces/pokemon_data_interface.dart';

class DataReository implements IDataRepository {
  final IDataRepository dataRepository;

  DataReository(this.dataRepository);

  @override
  Future<Pokemon> getPokemonById(int pokemonId) {
    return dataRepository.getPokemonById(pokemonId);
  }

  @override
  Future<List<PokemonItem>> getPokemonItems([int startIndex = 0]) {
    return dataRepository.getPokemonItems(startIndex);
  }
}
