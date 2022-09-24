import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import '../../../../data/models/pokemon_item.dart';

part 'home_event.dart';
part 'home_state.dart';

const _pokemonLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.httpClient}) : super(const HomeState()) {
    on<PokemonsFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    PokemonsFetched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FetchStatus.initial) {
        final pokemonItems = await _fetchPosts();
        return emit(
          state.copyWith(
            status: FetchStatus.success,
            pokemonItems: pokemonItems,
            hasReachedMax: false,
          ),
        );
      }
      final pokemonItems = await _fetchPosts(state.pokemonItems.length);
      pokemonItems.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: FetchStatus.success,
                pokemonItems: List.of(state.pokemonItems)..addAll(pokemonItems),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  Future<List<PokemonItem>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'pokeapi.co',
        '/api/v2/pokemon',
        <String, String>{'offset': '$startIndex', 'limit': '$_pokemonLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final resultList = <PokemonItem>[];
      final body = json.decode(response.body) as Map;

      for (final pokemonDataMap in body['results']) {
        resultList.add(PokemonItem.fromMap(pokemonDataMap));
      }
      return resultList;
    }
    throw Exception('error fetching posts');
  }
}
