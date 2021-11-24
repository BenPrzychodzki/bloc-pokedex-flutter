import 'package:pokedex_app/repos/models/pokemon_model.dart';

class PokemonPageResponseModel {
  /// API response model for keeping all the data from an API call
  final List<PokemonModel> pokemonList;
  final bool canLoadNextPage;

  PokemonPageResponseModel(
      {required this.pokemonList, required this.canLoadNextPage});

  factory PokemonPageResponseModel.fromJson(Map<String, dynamic> json) {
    /// Create an API response model from a json data
    final pokemonList = (json['results'] as List)
        .map((pokemonJson) => PokemonModel.fromJson(pokemonJson))
        .toList(); // Iterable<PokemonModel> => List<PokemonModel>
    final canLoadNextPage = json['next'] != null;

    return PokemonPageResponseModel(
        pokemonList: pokemonList, canLoadNextPage: canLoadNextPage);
  }
}
