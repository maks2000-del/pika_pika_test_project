import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:stream_transform/stream_transform.dart';
import '../../../../../../injector.dart';
import '../../../../domain/entities/pokemon_item.dart';
import '../../../../domain/repositories/interfaces/pokemon_data_interface.dart';

part 'home_event.dart';
part 'home_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ILocalDataRepository _localDataRepository =
      i.get<ILocalDataRepository>();
  final IDataRepository _dataRepository = i.get<IDataRepository>();

  HomeBloc() : super(const HomeState()) {
    on<PokemonsFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
    PokemonsFetched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      final connectivity = await Connectivity().checkConnectivity();

      if (state.status == FetchStatus.initial) {
        final pokemonItems = await _dataRepository.getPokemonItems();
        if (connectivity != ConnectivityResult.none) {
          await _localDataRepository.savePokemonItems(pokemonItems);
        }
        return emit(
          state.copyWith(
            status: FetchStatus.success,
            pokemonItems: pokemonItems,
            hasReachedMax: false,
          ),
        );
      }
      if (connectivity != ConnectivityResult.none) {
        final pokemonItems =
            await _dataRepository.getPokemonItems(state.pokemonItems.length);

        await _localDataRepository.savePokemonItems(pokemonItems);
        pokemonItems.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
                state.copyWith(
                  status: FetchStatus.success,
                  pokemonItems: List.of(state.pokemonItems)
                    ..addAll(pokemonItems),
                  hasReachedMax: false,
                ),
              );
      }
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
