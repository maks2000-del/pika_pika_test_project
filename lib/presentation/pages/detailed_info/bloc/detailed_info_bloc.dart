import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/repositories/cash_data_repository.dart';
import '../../../../domain/usecases/data_usecase.dart';
import '../../../di/injector.dart';
import '../../main/bloc/home_bloc.dart';

part 'detailed_info_event.dart';
part 'detailed_info_state.dart';

class DetailedInfoBloc extends Bloc<DetailedInfoEvent, DetailedInfoState> {
  final CashDataRepository _cashDataRepository = i.get<CashDataRepository>();

  final HomeUsecase _homeUsecase = i.get<HomeUsecase>();

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
        final pokemonInfo = await _homeUsecase.getPokemonById(id);
        final cashingStatus =
            await _cashDataRepository.savePokemonById(id, pokemonInfo);

        if (cashingStatus == CashingStatus.success) {
          print('cashed');
        }
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
