import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:stream_transform/stream_transform.dart';
import '../../../../data/models/pokemon_item.dart';
import '../../../../domain/repositories/cash_data_repository.dart';
import '../../../../domain/repositories/interfaces/pokemon_data_interface.dart';
import '../../../../domain/repositories/remote_data_repository.dart';
import '../../../../domain/usecases/data_usecase.dart';
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
  final CashDataRepository _cashDataRepository = i.get<CashDataRepository>();

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

      final IDataRepository dataRepository =
          (connectivity != ConnectivityResult.none)
              ? i.get<RemoteDataRepository>()
              : i.get<CashDataRepository>();

      final HomeUsecase homeUsecase = HomeUsecase(dataRepository);
      if (state.status == FetchStatus.initial) {
        final pokemonItems = await homeUsecase.getPokemonItems();

        if (connectivity != ConnectivityResult.none) {
          final cashingStatus =
              await _cashDataRepository.savePokemonItems(pokemonItems);

          if (cashingStatus == CashingStatus.success) {
            print('cashed');
          }
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
        final pokemonItems = await i
            .get<HomeUsecase>()
            .getPokemonItems(state.pokemonItems.length);
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
