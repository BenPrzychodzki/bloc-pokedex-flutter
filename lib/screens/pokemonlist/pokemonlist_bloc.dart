import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/repos/pokemon_repository.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_event.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  /// Bloc providing all necessary logic for pokemon list screen.
  final _pokemonRepository = PokemonRepository();

  PokemonListBloc() : super(PokemonListInitial()) {
    on<PokemonDataRequest>(_onPokemonDataRequest);
  }

  void _onPokemonDataRequest(PokemonDataRequest event, emit) async {
    emit(PokemonListLoadInProgress());

    try {
      final pokemonPageResponse =
          await _pokemonRepository.getPokemonPage(event.page);
      // invoke get page method from poke repo and emit new state based on data we'll get
      emit(PokemonListLoadSuccess(
          pokemonList: pokemonPageResponse.pokemonList,
          canLoadNextPage: pokemonPageResponse.canLoadNextPage));
    } catch (e) {
      emit(PokemonListLoadFail(error: e));
    }
  }
}
