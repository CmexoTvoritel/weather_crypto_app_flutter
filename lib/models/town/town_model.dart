class TownModel {
  String townShortName;
  String townName;
  double cordX;
  double cordY;

  TownModel({
    required this.townShortName,
    required this.townName,
    required this.cordX,
    required this.cordY,
  });

  factory TownModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'short_name': String townShortName,
        'name': String name,
        'cordX': double cordX,
        'cordY': double cordY
      } => TownModel(
        townShortName: townShortName,
        townName: name,
        cordX: cordX,
        cordY: cordY
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}