
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/repository/crypto_repository.dart';

class CryptoViewModel extends ViewModel {

  final CryptoRepository _repository = locator<CryptoRepository>();
  final listCryptoStateFlow = StateFlow<List<CryptoItemModel>>([]);
  List<CryptoItemModel> listCrypto = [];

  @override
  void init() async {
   await _repository.getCryptoInformation().then((value) {
     listCryptoStateFlow.value = value;
     listCrypto = value;
   });
    super.init();
  }

  void changeStateOfList(CryptoItemModel cryptoItem) async {
    await _repository.synchronizeCryptoList(cryptoItem).then((value) {
      listCryptoStateFlow.value = value;
      listCrypto = value;
    });
  }

  void searchQuery(String query) {
    if(query == "") {
      listCryptoStateFlow.value = listCrypto;
    } else {
      listCryptoStateFlow.value = listCrypto.where((item) =>
          item.name
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
    }
  }

}