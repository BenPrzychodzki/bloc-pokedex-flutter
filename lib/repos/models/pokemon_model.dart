// JSON EXAMPLE
// count:1118
// next:"https://pokeapi.co/api/v2/pokemon?offset=300&limit=100"
// previous:"https://pokeapi.co/api/v2/pokemon?offset=100&limit=100"
// name:"unown"
// url:"https://pokeapi.co/api/v2/pokemon/201/"
// name:"wobbuffet"
// url:"https://pokeapi.co/api/v2/pokemon/202/"

class PokemonModel {
  /// Pokemon model for keeping all the data to show in list view
  final int id;
  final String name;

  // property imageUrl will be created when we use it for the first time in our code
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonModel({required this.id, required this.name});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    /// Create a pokemon model from a json data
    final name = json['name'];
    final url = json['url'];
    final id = int.parse(url.split('/')[6]); // get a pokemon id from url

    return PokemonModel(id: id, name: name);
  }
}
