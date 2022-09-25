import 'package:pika_pika_test_project/data/models/pokemon_item.dart';
import 'package:pika_pika_test_project/domain/entities/pokemon.dart';

abstract class ILocalDataSource {
  Future<String?> getPokemonById();
  Future<String?> getPokemonItems();

  void savePokemonInfo(Pokemon pokemon);
  void savePokemonItems(List<PokemonItem> pokemoItems);

  void clearData();
}
