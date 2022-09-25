part of 'detailed_info_bloc.dart';

class DetailedInfoState {
  final FetchStatus status;
  final Pokemon pokemonInfo;

  DetailedInfoState.initial()
      : this(
          pokemonInfo: Pokemon(
            frontImage: null,
            height: null,
            isDefault: null,
            name: null,
            types: null,
            weight: null,
          ),
          status: FetchStatus.initial,
        );

  DetailedInfoState({
    required this.status,
    required this.pokemonInfo,
  });

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
