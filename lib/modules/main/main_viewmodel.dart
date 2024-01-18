import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class MainViewModel extends ViewModel {

  final MainRepository _repository = locator<MainRepository>();
  final menuListStateFlow = StateFlow<List<MainMenuModel>>([]);
  final cryptoListStateFlow = StateFlow<List<CryptoItemModel>>([]);

  @override
  void init() async {
    menuListStateFlow.value = _repository.getMenuList();
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
}