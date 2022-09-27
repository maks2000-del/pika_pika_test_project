import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/pokemon.dart';
import '../models/pokemon_item.dart';
import 'interfaces/i_local_data_source.dart';

class LocalDataSource implements ILocalDataSource {
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  Future<String?> getPokemonById() {
    //return _prefs.then((prefs) => prefs.getString(key));
    // TODO: implement getPokemonById
    throw UnimplementedError();
  }

  @override
  Future<String?> getPokemonItems() {
    // TODO: implement getPokemonItems
    throw UnimplementedError();
  }

  @override
  void savePokemonById(Pokemon pokemon) {
    //_prefs.then((prefs) => prefs.setString(key, id));
    // TODO: implement savePokemonInfo
  }

  @override
  void savePokemonItems(List<PokemonItem> pokemoItems) {
    // TODO: implement savePokemonItems
  }
}
