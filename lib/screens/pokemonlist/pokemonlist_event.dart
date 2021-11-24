abstract class PokemonListEvent {}

class PokemonDataRequest extends PokemonListEvent {
  final int page;

  PokemonDataRequest({required this.page});
}
