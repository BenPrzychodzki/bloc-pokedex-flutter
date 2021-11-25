abstract class DetailsEvent {}

class ShowDetailsPopupEvent extends DetailsEvent {
  final int pokemonId;

  ShowDetailsPopupEvent({required this.pokemonId});
}

class LoadDetailsPopupData extends DetailsEvent {
  final int pokemonId;

  LoadDetailsPopupData({required this.pokemonId});
}

class CloseDetailsPopup extends DetailsEvent {}
