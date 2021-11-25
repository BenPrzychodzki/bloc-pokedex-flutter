import 'package:pokedex_app/repos/models/pokemon_model.dart';

/// API response model for keeping all the data from an API call
class PokemonPageResponseModel {
  final List<PokemonModel> pokemonList;
  final bool canLoadNextPage;

  PokemonPageResponseModel(
      {required this.pokemonList, required this.canLoadNextPage});

  /// Create an API response model from a json data
  factory PokemonPageResponseModel.fromJson(Map<String, dynamic> json) {
    final pokemonList = (json['results'] as List)
        .map((pokemonJson) => PokemonModel.fromJson(pokemonJson))
        .toList(); // Iterable<PokemonModel> => List<PokemonModel>
    final canLoadNextPage = json['next'] != null;

    return PokemonPageResponseModel(
        pokemonList: pokemonList, canLoadNextPage: canLoadNextPage);
  }
}
