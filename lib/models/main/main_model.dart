
enum TypeCard {
  crypto,
  weather,
  map,
}

class MainMenuModel {

  TypeCard typeCard;
  List<String>? cryptoList;
  String? weatherCityName;
  String? mapCityName;

  MainMenuModel({
    required this.typeCard,
    this.cryptoList,
    this.mapCityName,
    this.weatherCityName,
  });
}