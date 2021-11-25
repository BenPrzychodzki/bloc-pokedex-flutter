import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_app/repos/models/pokemon_info_response_model.dart';
import 'package:pokedex_app/repos/models/pokemon_page_response_model.dart';
import 'package:pokedex_app/repos/models/species_info_response_model.dart';

class PokemonRepository {
  // repository can be described as abstract where the data is coming from
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponseModel?> getPokemonPage(int pageIndex) async {
    /// Get pokemon list data from an API and make an object from it

    // set of parameters attached to the end of a url (e.g. ?limit=200&offset=0)
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    // Creates a new https URI from authority, path and query.
    // URI contains both URL and URN to identify the name and location or both of a resource
    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    try {
      final response =
          await client.get(uri); // get response from pokemon api site
      final json = jsonDecode(response.body); // turn response for a json

      return PokemonPageResponseModel.fromJson(json);
    } catch (e) {
      print(e);
    }
  }

  Future<PokemonInfoResponseModel?> getPokemonInfo(int pokemonId) async {
    /// Get pokemon details data from an API
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponseModel.fromJson(json);
    } catch (e) {
      print(e);
    }
  }

  Future<SpeciesInfoResponseModel?> getPokemonSpeciesInfo(int pokemonId) async {
    /// Get pokemon flavor text from an API and pass it to an instance of
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return SpeciesInfoResponseModel.fromJson(json);
    } catch (e) {
      print(e);
    }
  }
}
