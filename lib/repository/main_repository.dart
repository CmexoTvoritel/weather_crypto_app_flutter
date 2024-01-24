
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather_crypto_app_flutter/data/service/crypto_api.dart';
import 'package:weather_crypto_app_flutter/data/service/weather_api.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/response/crypto_response_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';
import 'package:weather_crypto_app_flutter/preferences/shared_preferences.dart';

class MainRepository {

  List<MainMenuModel> _listOfMenuItems = [];
  List<TownModel> _listOfTowns = [];
  final CryptoApi _apiCrypto = locator<CryptoApi>();
  final WeatherApi _apiWeather = locator<WeatherApi>();
  final SharedPref sharedPref = locator<SharedPref>();

  MainRepository() {
    _listOfMenuItems = [
      MainMenuModel(typeCard: TypeCard.weather, nameCard: "Погода"),
      MainMenuModel(typeCard: TypeCard.map, nameCard: "Карта"),
      MainMenuModel(typeCard: TypeCard.crypto, nameCard: "Курс криптовалют"),
    ];
  }

  Future<void> initSharedPref() async {
    await sharedPref.init();
    await getTownsList();
  }

  List<MainMenuModel> getMenuList() => _listOfMenuItems;

  List<String> getStringMenuList() =>
      List<String>.from(_listOfMenuItems.map((e) => e.nameCard));

  Future<void> saveStates(List<String> newMenuOrder) async {
    List<MainMenuModel> newList = [];
    for(String nameMenu in newMenuOrder) {
      for(MainMenuModel menu in _listOfMenuItems) {
        if(menu.nameCard == nameMenu) {
          newList.add(menu);
        }
      }
    }
    _listOfMenuItems = newList;
  }

  Future<List<MainMenuModel>> loadInformationAboutItems() async {
    for(MainMenuModel menu in _listOfMenuItems) {
      switch(menu.typeCard) {
        case TypeCard.crypto:
          final listCrypto = await _loadCryptoInfo();
          menu.cryptoList = listCrypto;
          break;
        case TypeCard.weather:
          final weatherInfo = await _loadWeather();
          menu.weatherInfo = weatherInfo;
          break;
        case TypeCard.map:
          menu.mapCityName = _loadMap();
          break;
      }
    }
    return _listOfMenuItems;
  }

  Future<List<MenuCryptoModel>?> _loadCryptoInfo() async {
    final savedCrypto = sharedPref.cryptoNames;
    if(savedCrypto != null) {
      List<MenuCryptoModel> answerList = [];
      final response = await _apiCrypto.fetchData();
      if(response.statusOfResponse == Status.success) {
        final answerFromApi = response.listOfCrypto?.map((item) =>
            CryptoItemModel.mapApiResponse(item)
        );
        final cryptoListApi = List<CryptoItemModel>.from(answerFromApi!);
        for (String nameCrypto in savedCrypto) {
          for (CryptoItemModel cryptoApi in cryptoListApi) {
            if (nameCrypto == cryptoApi.name) {
              answerList.add(MenuCryptoModel.mapApiResponse(cryptoApi));
            }
          }
        }
        return answerList;
      } else {
        return List.empty();
      }
    } else {
      return null;
    }
  }

  Future<MenuWeatherModel?> _loadWeather() async {
    final weatherName = sharedPref.weatherTownName;
    if(weatherName != null) {
      TownModel? targetTown;
      for(var town in _listOfTowns) {
        if(town.townName == weatherName) {
          targetTown = town;
          break;
        }
      }
      if(targetTown != null) {
        final response = await _apiWeather.fetchData(targetTown.cordX, targetTown.cordY);
        if(response.responseStatus == Status.success) {
          return MenuWeatherModel.mapApiResponse(response);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  MenuMapModel? _loadMap() {
    final mapName = sharedPref.mapTownName;
    if(mapName != null) {
      late MenuMapModel answer;
      for (var town in _listOfTowns) {
        if (town.townName == mapName) {
          answer = MenuMapModel(
              lat: town.cordX,
              lon: town.cordY,
              name: town.townName
          );
          break;
        }
      }
      return answer;
    }
    return null;
  }

  bool checkEmptyCrypto() =>
      sharedPref.cryptoNames == null || sharedPref.cryptoNames == List.empty();

  Future<List<TownModel>> getTownsList() async {
    final String jsonFromFile = await rootBundle.loadString('assets/towns.json');
    List<dynamic> townsList = jsonDecode(jsonFromFile);
    List<TownModel> answer = townsList.map((town) => TownModel.fromJson(town)).toList();
    _listOfTowns = answer;
    return answer;
  }

  List<TownModel> getTowns() {
    return _listOfTowns;
  }

  void setTown(String townName, TypeCard typeCard) {
    switch(typeCard) {
      case TypeCard.weather:
        sharedPref.weatherTownName = townName;
        break;
      case TypeCard.map:
        sharedPref.mapTownName = townName;
        break;
      default:
        break;
    }
  }
}