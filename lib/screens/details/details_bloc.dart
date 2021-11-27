import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/repos/models/pokemon_details_model.dart';
import 'package:pokedex_app/repos/models/pokemon_info_response_model.dart';
import 'package:pokedex_app/repos/models/species_info_response_model.dart';
import 'package:pokedex_app/repos/pokemon_repository.dart';

import 'details_event.dart';
import 'details_state.dart';

/// Bloc with the logic used in detailed view (after clicking on a tile in a grid view).
class DetailsBloc extends Bloc<DetailsEvent, DetailsState?> {
  final _pokemonRepository = PokemonRepository();
  DetailsBloc() : super(null) {
    on<ShowDetailsPopupEvent>((event, emit) {
      emit(DetailsPageInitial(pokemonId: event.pokemonId, types: event.types));
    });
    on<LoadDetailsPopupData>(_onLoadDetailsPopupData);
    on<CloseDetailsPopup>((event, emit) {
      emit(null);
    });
  }

  void _onLoadDetailsPopupData(LoadDetailsPopupData event, emit) async {
    emit(LoadingDetailsState());

    try {
      final responses = await Future.wait([
        // We want to make two requests in the same time, so it can be quicker than waiting separately
        _pokemonRepository.getPokemonInfo(event.pokemonId),
        _pokemonRepository.getPokemonSpeciesInfo(event.pokemonId)
      ]);

      final pokemonInfo = responses[0] as PokemonInfoResponseModel;
      final speciesInfo = responses[1] as SpeciesInfoResponseModel;

      emit(DetailsLoadingSuccess(
          pokemon: PokemonDetails(
              id: pokemonInfo.id,
              name: pokemonInfo.name,
              imageUrl: pokemonInfo.imageUrl,
              types: pokemonInfo.types,
              height: pokemonInfo.height,
              weight: pokemonInfo.weight,
              description: speciesInfo.description)));
    } catch (e) {
      emit(DetailsLoadingFailure(error: e));
    }
  }
}
