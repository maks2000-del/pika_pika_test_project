abstract class IRemoteDataSource {
  Future<String?> getPokemonById();
  Future<String?> getPokemonItems();
}
