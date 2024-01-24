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
        'cordX': num cordX,
        'cordY': num cordY
      } => TownModel(
        townShortName: townShortName,
        townName: name,
        cordX: cordX.toDouble(),
        cordY: cordY.toDouble()
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}