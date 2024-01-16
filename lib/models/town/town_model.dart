class TownModel {
  String townName;
  double cordX;
  double cordY;

  TownModel({
    required this.townName,
    required this.cordX,
    required this.cordY,
  });

  factory TownModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'cordX': double cordX,
        'cordY': double cordY
      } => TownModel(
        townName: name,
        cordX: cordX,
        cordY: cordY
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}