import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../domain/entities/pokemon.dart';
import '../../main/bloc/home_bloc.dart';

part 'detailed_info_event.dart';
part 'detailed_info_state.dart';

class DetailedInfoBloc extends Bloc<DetailedInfoEvent, DetailedInfoState> {
  DetailedInfoBloc({required this.httpClient})
      : super(const DetailedInfoState()) {
    on<PokemonFetched>(
      _onPokemonFetched,
    );
  }

  final http.Client httpClient;

  Future<void> _onPokemonFetched(
    PokemonFetched event,
    Emitter<DetailedInfoState> emit,
  ) async {
    try {
      if (state.status == FetchStatus.initial) {
        final pokemonInfo = await _fetchPokemon();
        return emit(
          state.copyWith(
            status: FetchStatus.success,
            pokemonInfo: pokemonInfo,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  Future<Pokemon> _fetchPokemon([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'pokeapi.co',
        '/api/v2/pokemon',
        <String, String>{'offset': '$startIndex'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return Pokemon.fromMap(body);
    }
    throw Exception('error fetching pokemon info');
  }
}
