abstract class PokemonListEvent {}

/// Request data to populate a grid view.
class PokemonDataRequest extends PokemonListEvent {
  final int page;

  PokemonDataRequest({required this.page});
}
