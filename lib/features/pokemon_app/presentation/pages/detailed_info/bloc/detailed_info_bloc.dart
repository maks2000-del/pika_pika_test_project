import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../../../injector.dart';
import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/repositories/interfaces/pokemon_data_interface.dart';
import '../../main/bloc/home_bloc.dart';

part 'detailed_info_event.dart';
part 'detailed_info_state.dart';

class DetailedInfoBloc extends Bloc<DetailedInfoEvent, DetailedInfoState> {
  final ILocalDataRepository _localDataRepository =
      i.get<ILocalDataRepository>();
  final IDataRepository _dataRepository = i.get<IDataRepository>();

  DetailedInfoBloc() : super(DetailedInfoState.initial()) {
    on<PockemonPicked>(
      _onPokemonPicked,
    );
    on<DetailedInfoConnectionChecked>(
      _onConnectionChecked,
    );
  }

  Future<void> _onPokemonPicked(
    PockemonPicked event,
    Emitter<DetailedInfoState> emit,
  ) async {
    try {
      if (state.status == FetchStatus.initial) {
        final id = int.parse(event.id);

        final pokemonInfo = await _dataRepository.getPokemonById(id);
        if (pokemonInfo.runtimeType == Pokemon) {
          emit(
            state.copyWith(
              status: FetchStatus.success,
              pokemonInfo: pokemonInfo,
            ),
          );
          await _localDataRepository.savePokemonById(id, pokemonInfo);
        } else {
          emit(state.copyWith(status: FetchStatus.failure));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  Future<void> _onConnectionChecked(
    DetailedInfoConnectionChecked event,
    Emitter<DetailedInfoState> emit,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    return emit(
      state.copyWith(
        connection: connectivityResult,
      ),
    );
  }
}
