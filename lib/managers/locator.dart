
import 'package:get_it/get_it.dart';
import 'package:weather_crypto_app_flutter/data/service/crypto_api.dart';
import 'package:weather_crypto_app_flutter/data/service/weather_api.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_viewmodel.dart';
import 'package:weather_crypto_app_flutter/modules/main/main_helper.dart';
import 'package:weather_crypto_app_flutter/modules/main/main_viewmodel.dart';
import 'package:weather_crypto_app_flutter/modules/replace/replace_view_model.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_viewmodel.dart';
import 'package:weather_crypto_app_flutter/preferences/shared_preferences.dart';
import 'package:weather_crypto_app_flutter/repository/crypto_repository.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //Shared preferences
  locator.registerLazySingleton(() => SharedPref());

  //ViewModels
  locator.registerLazySingleton(() => MainViewModel());
  locator.registerLazySingleton(() => CryptoViewModel());
  locator.registerLazySingleton(() => WeatherMapViewModel());
  locator.registerLazySingleton(() => ReplaceViewModel());

  //Api
  locator.registerLazySingleton(() => CryptoApi());
  locator.registerLazySingleton(() => WeatherApi());

  //Repository
  locator.registerLazySingleton(() => MainRepository());
  locator.registerLazySingleton(() => CryptoRepository());

  //Helpers
  locator.registerLazySingleton(() => MainHelper());
}