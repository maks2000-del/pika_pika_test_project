part of 'detailed_info_bloc.dart';

class DetailedInfoState {
  final FetchStatus status;
  final Pokemon pokemonInfo;

  DetailedInfoState.initial()
      : this(
          pokemonInfo: Pokemon(
            frontImage: '',
            height: 0,
            isDefault: true,
            name: '',
            types: <String>[],
            weight: 0,
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
