class SpeciesInfoResponseModel {
  final String description;

  SpeciesInfoResponseModel({required this.description});

  factory SpeciesInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return SpeciesInfoResponseModel(
        description: json['flavor_text_entries'][0]['flavor_text']
            .replaceAll("\n", " "));
  }
}
