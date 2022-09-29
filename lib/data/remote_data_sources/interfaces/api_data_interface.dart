abstract class IRemoteDataSource {
  Future<dynamic> getPokemonById(int pokemonId);
  Future<dynamic> getPokemonItems([int startIndex = 0]);
}
