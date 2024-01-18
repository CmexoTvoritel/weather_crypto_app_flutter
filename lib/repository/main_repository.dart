
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather_crypto_app_flutter/data/service/crypto_api.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/response/crypto_response_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';
import 'package:weather_crypto_app_flutter/preferences/shared_preferences.dart';

class MainRepository {

  List<MainMenuModel> _listOfMenuItems = [];
  List<CryptoItemModel> _listOfCryptoItems = [];
  final CryptoApi _api = locator<CryptoApi>();
  final SharedPref sharedPref = locator<SharedPref>();

  MainRepository() {
    _listOfMenuItems = [
      MainMenuModel(typeCard: TypeCard.weather, nameCard: "Погода"),
      MainMenuModel(typeCard: TypeCard.map, nameCard: "Карта"),
      MainMenuModel(typeCard: TypeCard.crypto, nameCard: "Курс криптовалют"),
    ];
  }

  List<MainMenuModel> getMenuList() => _listOfMenuItems;

  Future<List<CryptoItemModel>> getCryptoInformation() async {
    final response = await _api.fetchData();
    if(response.statusOfResponse == Status.success) {
      final answer = response.listOfCrypto?.map((item) => 
          CryptoItemModel(
              name: item.name,
              isChecked: false,
              currentPrice: item.currentPrice,
              dynamic: item.priceChangePercentage1hInCurrency,
              image: item.image
          )
      );
      _listOfCryptoItems = List<CryptoItemModel>.from(answer!);
      _checkWithPrefs();
      return _listOfCryptoItems;
    } else {
      return List.empty();
    }
  }

  Future<List<TownModel>> getTownsList() async {
    final String jsonFromFile = await rootBundle.loadString('assets/towns.json');
    List<dynamic> townsList = jsonDecode(jsonFromFile);
    List<TownModel> answer = townsList.map((town) => TownModel.fromJson(town)).toList();
    return answer;
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

  Future<List<CryptoItemModel>> synchronizeCryptoList(CryptoItemModel cryptoItem, int index) async {
    var listFromDB = sharedPref.cryptoNames;
    if(!cryptoItem.isChecked) {
      if (listFromDB == null) {
        listFromDB = [cryptoItem.name];
      } else if (listFromDB.length < 3) {
        listFromDB.add(cryptoItem.name);
      } else {
        final cryptoToDelete = listFromDB[0];
        listFromDB.removeAt(0);
        listFromDB.add(cryptoItem.name);
        for(var item in _listOfCryptoItems) {
          if(item.checkByName(cryptoToDelete)) {
            item.isChecked = false;
            break;
          }
        }
      }
      for (var item in listFromDB) {
        for (var cryptoItem in _listOfCryptoItems) {
          if(cryptoItem.checkByName(item)) {
            cryptoItem.isChecked = true;
            break;
          }
        }
      }
    } else {
      listFromDB!.remove(cryptoItem.name);
      for(var item in _listOfCryptoItems) {
        if(item.checkByName(cryptoItem.name)) {
          item.isChecked = false;
          break;
        }
      }
    }
    sharedPref.cryptoNames = listFromDB;
    _moveCheckedToTheTop();
    return _listOfCryptoItems;
  }

  void _checkWithPrefs() {
    final listFromDB = sharedPref.cryptoNames;
    if(listFromDB != null) {
      for (var item in listFromDB) {
        for(var cryptoItem in _listOfCryptoItems) {
          if(cryptoItem.checkByName(item)) {
            cryptoItem.isChecked = true;
          }
        }
      }
      _moveCheckedToTheTop();
    }
  }

  void _moveCheckedToTheTop() {
    for(var cryptoItem in _listOfCryptoItems) {
      if(cryptoItem.isChecked) {
        final index = _listOfCryptoItems.indexOf(cryptoItem);
        _listOfCryptoItems.insert(0, cryptoItem);
        _listOfCryptoItems.removeAt(index);
      }
    }
  }

}