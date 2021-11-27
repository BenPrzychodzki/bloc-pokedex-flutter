import 'package:pokedex_app/repos/models/pokemon_details_model.dart';

abstract class DetailsState {}

/// Switch to if pokemon was clicked from a grid view and open hero view
class DetailsPageInitial extends DetailsState {
  final int pokemonId;
  final List<String> types;

  DetailsPageInitial({required this.pokemonId, required this.types});
}

/// Show loading screen until data is loaded
class LoadingDetailsState extends DetailsState {}

/// Show loaded data
class DetailsLoadingSuccess extends DetailsState {
  final PokemonDetails pokemon;

  DetailsLoadingSuccess({required this.pokemon});
}

/// Show an error message if something went wrong
class DetailsLoadingFailure extends DetailsState {
  final dynamic error;

  DetailsLoadingFailure({required this.error});
}
