abstract class DetailsEvent {}

class ShowDetailsPopupEvent extends DetailsEvent {
  final int pokemonId;
  final List<String> types;


  ShowDetailsPopupEvent({required this.pokemonId, required this.types});
}

class LoadDetailsPopupData extends DetailsEvent {
  final int pokemonId;

  LoadDetailsPopupData({required this.pokemonId});
}

class CloseDetailsPopup extends DetailsEvent {}
