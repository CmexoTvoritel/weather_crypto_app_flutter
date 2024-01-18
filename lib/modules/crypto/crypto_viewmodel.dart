
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class CryptoViewModel extends ViewModel {

  final MainRepository _repository = locator<MainRepository>();
  final listCryptoStateFlow = StateFlow<List<CryptoItemModel>>([]);

  @override
  void init() async {
   await _repository.getCryptoInformation().then((value) {
     listCryptoStateFlow.value = value;
   });
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeStateOfList(CryptoItemModel cryptoItem, int index) async {
    await _repository.synchronizeCryptoList(cryptoItem, index).then((value) {
      listCryptoStateFlow.value = value;
    });
  }

}