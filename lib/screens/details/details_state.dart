import 'package:pokedex_app/repos/models/pokemon_details_model.dart';

abstract class DetailsState {}

class DetailsPageInitial extends DetailsState {
  /// Switch to if pokemon was clicked from a grid view and open hero view
  final int pokemonId;

  DetailsPageInitial({required this.pokemonId});
}

class LoadingDetailsState extends DetailsState {
  /// Show loading screen until data is loaded
}

class DetailsLoadingSuccess extends DetailsState {
  /// Show loaded data
  final PokemonDetails pokemon;

  DetailsLoadingSuccess({required this.pokemon});
}

class DetailsLoadingFailure extends DetailsState {
  /// Show an error message
  final dynamic error;

  DetailsLoadingFailure({required this.error});
}
