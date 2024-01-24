import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class MainViewModel extends ViewModel {

  final MainRepository _repository = locator<MainRepository>();
  final menuListStateFlow = StateFlow<List<MainMenuModel>>([]);
  final menuCryptoListStateFlow = StateFlow<List<MenuCryptoModel>>([]);

  @override
  void init() async {
    menuListStateFlow.value = _repository.getMenuList();
    for (var item in menuListStateFlow.value) {
      if(item.typeCard == TypeCard.crypto) {
        if(item.cryptoList != null) {
          menuCryptoListStateFlow.value = item.cryptoList!;
        }
      }
    }
    super.init();
  }

  void collectStates() async {
    await _repository.loadInformationAboutItems().then((items) {
      menuListStateFlow.value = items;
      for (var item in menuListStateFlow.value) {
        if(item.typeCard == TypeCard.crypto) {
          if(item.cryptoList != null) {
            menuCryptoListStateFlow.value = item.cryptoList!;
          }
        }
      }
    });
  }

  Future<void> initSharedPref() async {
    await _repository.initSharedPref();
  }

  List<TownModel> getTownsList() {
    return _repository.getTowns();
  }

  bool checkEmptyCrypto() {
    return _repository.checkEmptyCrypto();
  }
  
}