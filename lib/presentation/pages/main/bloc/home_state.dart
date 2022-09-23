part of 'home_bloc.dart';

enum FetchStatus { initial, success, failure }

class HomeState {
  const HomeState({
    this.status = FetchStatus.initial,
    this.pokemonItems = const <PokemonItem>[],
    this.hasReachedMax = false,
  });

  final FetchStatus status;
  final List<PokemonItem> pokemonItems;
  final bool hasReachedMax;

  HomeState copyWith({
    FetchStatus? status,
    List<PokemonItem>? pokemonItems,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      pokemonItems: pokemonItems ?? this.pokemonItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ItemsState { status: $status, 
              hasReachedMax: $hasReachedMax,
              items: ${pokemonItems.length} }''';
  }
}
