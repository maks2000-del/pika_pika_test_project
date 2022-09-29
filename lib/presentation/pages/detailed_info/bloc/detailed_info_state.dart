part of 'detailed_info_bloc.dart';

class DetailedInfoState {
  final FetchStatus status;
  final ConnectivityResult connection;
  final Pokemon pokemonInfo;

  DetailedInfoState.initial()
      : this(
          pokemonInfo: Pokemon(
            frontImage: '',
            height: 0,
            name: '',
            types: <String>[],
            weight: 0,
          ),
          status: FetchStatus.initial,
          connection: ConnectivityResult.none,
        );

  DetailedInfoState({
    required this.connection,
    required this.status,
    required this.pokemonInfo,
  });

  DetailedInfoState copyWith({
    FetchStatus? status,
    ConnectivityResult? connection,
    Pokemon? pokemonInfo,
  }) {
    return DetailedInfoState(
      connection: connection ?? this.connection,
      status: status ?? this.status,
      pokemonInfo: pokemonInfo ?? this.pokemonInfo,
    );
  }
}
