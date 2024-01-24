import 'package:flutter/material.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';

class MainHelper {

  String getNullOrNotText(String? text) => text ?? "";

  bool conditionShowCrypto(MainMenuModel item) =>
      item.typeCard == TypeCard.crypto && item.cryptoList != null;

  bool conditionShowMap(MainMenuModel item) =>
      item.typeCard == TypeCard.map && item.mapCityName != null;

  bool conditionShowWeather(MainMenuModel item) =>
      item.typeCard == TypeCard.weather && item.weatherInfo != null;

  bool conditionButtonsVisible(MainMenuModel item, bool isChooseButton) {
    if(isChooseButton) {
      return (item.typeCard == TypeCard.map && item.mapCityName == null) ||
          (item.typeCard == TypeCard.weather && item.weatherInfo == null) ||
          (item.typeCard == TypeCard.crypto && item.cryptoList == null);
    } else {
      return (item.typeCard == TypeCard.map && item.mapCityName != null) ||
          (item.typeCard == TypeCard.weather && item.weatherInfo != null) ||
          (item.typeCard == TypeCard.crypto && item.cryptoList != null);
    }
  }

  Text buildTextTitle(String text, [double fontSize = 13]) {
    return Text(
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.white
        ),
        text
    );
  }

  Text buildTextDescription(String? text, [double fontSize = 12]) {
    return Text(
        textAlign: TextAlign.end,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.white
        ),
        getNullOrNotText(text)
    );
  }

}