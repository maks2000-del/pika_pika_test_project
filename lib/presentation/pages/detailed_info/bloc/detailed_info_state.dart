part of 'detailed_info_bloc.dart';

class DetailedInfoState {
  const DetailedInfoState({
    this.status = FetchStatus.initial,
    this.pokemonInfo = Pokemon(),
  });

  final FetchStatus status;
  final Pokemon pokemonInfo;

  DetailedInfoState copyWith({
    FetchStatus? status,
    Pokemon? pokemonInfo,
  }) {
    return DetailedInfoState(
      status: status ?? this.status,
      pokemonInfo: pokemonInfo ?? this.pokemonInfo,
    );
  }
}
