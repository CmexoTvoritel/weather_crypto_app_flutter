
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather_crypto_app_flutter/data/service/crypto_api.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/response/crypto_response_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';

class MainRepository {

  List<MainMenuModel> _listOfMenuItems = [];
  final CryptoApi _api = locator<CryptoApi>();

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
          CryptoItemModel(name: item.name, isChecked: false)
      );
      return List<CryptoItemModel>.from(answer!);
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

}