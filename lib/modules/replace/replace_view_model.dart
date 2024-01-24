
import 'package:view_model_x/view_model_x.dart';
import 'package:weather_crypto_app_flutter/managers/locator.dart';
import 'package:weather_crypto_app_flutter/repository/main_repository.dart';

class ReplaceViewModel extends ViewModel {
  final _repository = locator<MainRepository>();

  Future<void> saveStates(List<String> menuList) async {
    await _repository.saveStates(menuList);
  }

  List<String> getCurrentMenu() => _repository.getStringMenuList();
}