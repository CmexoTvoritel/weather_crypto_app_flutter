
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  late final SharedPreferences _sharedPreferences;

  get _WEATHER_TOWN_NAME => "WEATHER_TOWN_NAME";
  get _MAP_TOWN_NAME => "MAP_TOWN_NAME";
  get _CRYPTO_NAMES => "CRYPTO_NAMES";

  String? get weatherTownName => _sharedPreferences.getString(_WEATHER_TOWN_NAME);
  set weatherTownName(String? value) => _sharedPreferences.setString(_WEATHER_TOWN_NAME, value!);

  String? get mapTownName => _sharedPreferences.getString(_MAP_TOWN_NAME);
  set mapTownName(String? value) => _sharedPreferences.setString(_MAP_TOWN_NAME, value!);

  List<String>? get cryptoNames => _sharedPreferences.getStringList(_CRYPTO_NAMES);
  set cryptoNames(List<String>? value) => _sharedPreferences.setStringList(_CRYPTO_NAMES, value!);

  Future<void> init() async =>  _sharedPreferences =
    _sharedPreferences = await SharedPreferences.getInstance();
}

