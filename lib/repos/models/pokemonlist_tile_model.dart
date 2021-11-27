class PokemonListTileModel {
  final int id;
  final String name;
  final List<String> types;

  // property imageUrl will be created when we use it for the first time in our code
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';


  PokemonListTileModel(
      {required this.id,
        required this.name,
        required this.types,
      });
}