import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_app/repos/models/pokemon_page_response_model.dart';

class PokemonRepository {
  // repository can be described as abstract where the data is coming from
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponseModel> getPokemonPage(int pageIndex) async {
    /// Get pokemon data from an API and make an object from it

    // set of parameters attached to the end of a url (e.g. ?limit=200&offset=0)
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    // Creates a new https URI from authority, path and query.
    // URI contains both URL and URN to identify the name and location or both of a resource
    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response =
        await client.get(uri); // get response from pokemon api site
    final json = jsonDecode(response.body); // turn response for a json

    return PokemonPageResponseModel.fromJson(json);
  }
}
