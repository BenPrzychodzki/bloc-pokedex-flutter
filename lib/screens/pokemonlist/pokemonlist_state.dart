import 'package:pokedex_app/repos/models/pokemon_model.dart';

abstract class PokemonListState {}

/// App initial state.
class PokemonListInitial extends PokemonListState {}

/// Switch to if awaiting for data.
class PokemonListLoadInProgress extends PokemonListState {}

/// Switch to if data was loaded successfully.
class PokemonListLoadSuccess extends PokemonListState {
  final List<PokemonModel> pokemonList;
  final bool canLoadNextPage;

  PokemonListLoadSuccess(
      {required this.pokemonList, required this.canLoadNextPage});
}

/// Switch to if can't load data from a website (e.g. no internet connection).
class PokemonListLoadFail extends PokemonListState {
  final dynamic error;

  PokemonListLoadFail({required this.error});
}
