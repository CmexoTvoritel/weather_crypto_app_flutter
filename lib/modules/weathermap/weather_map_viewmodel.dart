import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class WeatherMapViewModel extends ViewModel{

  final MainRepository _repository = locator<MainRepository>();

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

}