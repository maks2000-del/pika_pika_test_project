import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:stream_transform/stream_transform.dart';
import '../../../../data/models/pokemon_item.dart';
import '../../../../domain/repositories/remote_data_repository.dart';
import '../../../di/injector.dart';

part 'home_event.dart';
part 'home_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RemoteDataRepository remoteDataRepository =
      i.get<RemoteDataRepository>();

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
      if (state.status == FetchStatus.initial) {
        final pokemonItems = await remoteDataRepository.getPokemonItems();
        return emit(
          state.copyWith(
            status: FetchStatus.success,
            pokemonItems: pokemonItems,
            hasReachedMax: false,
          ),
        );
      }
      final pokemonItems =
          await remoteDataRepository.getPokemonItems(state.pokemonItems.length);
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
}
