import 'package:http/http.dart' as http;

import '../../domain/di/injector.dart';
import 'interfaces/api_data_interface.dart';

const _pokemonLimit = 20;

class ApiDataProvider implements IRemoteDataProvider {
  final http.Client httpClient = i.get<http.Client>();

  @override
  Future<dynamic> getPokemonItems([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'pokeapi.co',
        '/api/v2/pokemon',
        <String, String>{'offset': '$startIndex', 'limit': '$_pokemonLimit'},
      ),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('error fetching pokemons');
    }
  }

  @override
  Future<dynamic> getPokemonById(int pokemonId) async {
    final response = await httpClient.get(
      Uri.https(
        'pokeapi.co',
        '/api/v2/pokemon/$pokemonId/',
      ),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('error fetching pokemon info');
    }
  }
}
