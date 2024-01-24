import 'package:weather_crypto_app_flutter/models/response/crypto_response_model.dart';

class CryptoItemModel {
  String name;
  String image;
  double currentPrice;
  double dynamic;
  bool isChecked;

  CryptoItemModel({
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.dynamic,
    required this.isChecked
  });

  bool checkByName(String name) {
    return this.name == name;
  }

  factory CryptoItemModel.mapApiResponse(CryptoModel item) {
    return CryptoItemModel(
        name: item.name,
        image: item.image,
        currentPrice: item.currentPrice,
        dynamic: item.priceChangePercentage1hInCurrency,
        isChecked: false
    );
  }
}