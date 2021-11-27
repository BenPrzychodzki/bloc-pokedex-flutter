import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/repos/models/pokemon_model.dart';
import 'package:pokedex_app/repos/models/pokemonlist_tile_model.dart';
import 'package:pokedex_app/repos/pokemon_repository.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_event.dart';
import 'package:pokedex_app/screens/pokemonlist/pokemonlist_state.dart';

/// Bloc providing all necessary logic for pokemon list screen.
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final _pokemonRepository = PokemonRepository();

  PokemonListBloc() : super(PokemonListInitial()) {
    on<PokemonDataRequest>(_onPokemonDataRequest);
  }

  void _onPokemonDataRequest(PokemonDataRequest event, emit) async {
    emit(PokemonListLoadInProgress());





    // get PokemonPageResponseModel instance with properties id and name
    try {
      final pokemonPageResponse =
          await _pokemonRepository.getPokemonPage(event.page);

      List<PokemonListTileModel> pokemonTileList= [];

      // combine properties from PokemonPageResponseModel with types corresponding to each pokemon
      for(PokemonModel pokemon in pokemonPageResponse!.pokemonList) {
        final pokemonTypes = await _pokemonRepository.getPokemonInfo(pokemon.id);
        pokemonTileList.add(PokemonListTileModel(
            id: pokemon.id,
            name: pokemon.name,
            types: pokemonTypes!.types));
      }

      emit(PokemonListLoadSuccess(
          pokemonList: pokemonTileList,
          canLoadNextPage: pokemonPageResponse.canLoadNextPage));
    } catch (e) {
      emit(PokemonListLoadFail(error: e));
    }
  }
}
