
enum TypeCard {
  crypto,
  weather,
  map,
}

class MainMenuModel {

  TypeCard typeCard;
  String nameCard;
  List<String>? cryptoList;
  String? weatherCityName;
  String? mapCityName;

  MainMenuModel({
    required this.typeCard,
    required this.nameCard,
    this.cryptoList,
    this.mapCityName,
    this.weatherCityName,
  });
}