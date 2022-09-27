abstract class IRemoteDataSource {
  Future<dynamic> getPokemonById(String pokemonId);
  Future<dynamic> getPokemonItems([int startIndex = 0]);
}
