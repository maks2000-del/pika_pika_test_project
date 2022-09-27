import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/repositories/remote_data_repository.dart';
import '../../../di/injector.dart';
import '../../main/bloc/home_bloc.dart';

part 'detailed_info_event.dart';
part 'detailed_info_state.dart';

class DetailedInfoBloc extends Bloc<DetailedInfoEvent, DetailedInfoState> {
  final RemoteDataRepository remoteDataRepository =
      i.get<RemoteDataRepository>();

  DetailedInfoBloc() : super(DetailedInfoState.initial()) {
    on<PockemonPicked>(
      _onPokemonPicked,
    );
  }

  Future<void> _onPokemonPicked(
    PockemonPicked event,
    Emitter<DetailedInfoState> emit,
  ) async {
    try {
      if (state.status == FetchStatus.initial) {
        final id = event.id;

        final pokemonInfo = await remoteDataRepository.getPokemonById(id);
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
}
