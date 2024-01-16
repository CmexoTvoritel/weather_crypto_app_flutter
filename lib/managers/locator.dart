
import 'package:get_it/get_it.dart';
import 'package:weather_crypto_app_flutter/data/service/crypto_api.dart';
import 'package:weather_crypto_app_flutter/modules/crypto/crypto_viewmodel.dart';
import 'package:weather_crypto_app_flutter/modules/weathermap/weather_map_viewmodel.dart';
import 'package:weather_crypto_app_flutter/preferences/shared_preferences.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => SharedPref());
  locator.registerLazySingleton(() => MainRepository());
  locator.registerLazySingleton(() => CryptoViewModel());
  locator.registerLazySingleton(() => CryptoApi());
  locator.registerLazySingleton(() => WeatherMapViewModel());
}