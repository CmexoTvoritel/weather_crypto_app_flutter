import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/models/main/main_model.dart';
import 'package:weather_crypto_app_flutter/models/town/town_model.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class WeatherMapViewModel extends ViewModel{

  final MainRepository _repository = locator<MainRepository>();
  final listTownsStateFlow = StateFlow<List<TownModel>>([]);

  @override
  void init() async {
    await _repository.getTownsList().then((value) {
      listTownsStateFlow.value = value;
    });
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setTownName(TownModel town, TypeCard typeCard) {
    _repository.setTown(town.townName, typeCard);
  }

}