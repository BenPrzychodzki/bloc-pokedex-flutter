import 'package:pokedex_app/repos/models/pokemon_model.dart';

abstract class PokemonListState {}

class PokemonListInitial extends PokemonListState {
  /// First app state
}

class PokemonListLoadInProgress extends PokemonListState {
  /// Switch to if awaiting for data
}

class PokemonListLoadSuccess extends PokemonListState {
  /// Switch to if data was loaded successfully
  final List<PokemonModel> pokemonList;
  final bool canLoadNextPage;

  PokemonListLoadSuccess(
      {required this.pokemonList, required this.canLoadNextPage});
}

class PokemonListLoadFail extends PokemonListState {
  /// Switch to if can't load data from a website (e.g. no internet connection)
  final dynamic error;

  PokemonListLoadFail({required this.error});
}
