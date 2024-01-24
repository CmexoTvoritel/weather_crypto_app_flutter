
import 'package:weather_crypto_app_flutter/models/crypto/crypto_model.dart';
import 'package:weather_crypto_app_flutter/models/response/weather_response_model.dart';

enum TypeCard {
  crypto,
  weather,
  map,
}

class MainMenuModel {

  TypeCard typeCard;
  String nameCard;
  List<MenuCryptoModel>? cryptoList;
  MenuWeatherModel? weatherInfo;
  MenuMapModel? mapCityName;

  MainMenuModel({
    required this.typeCard,
    required this.nameCard,
    this.cryptoList,
    this.weatherInfo,
    this.mapCityName,
  });
}

class MenuWeatherModel {
  String nameTown;
  String icon;
  String weatherName;
  String currentTemp;
  String feelsLike;
  String wind;
  String pressure;
  String humidity;
  String cloudy;
  String visibility;

  MenuWeatherModel({
    required this.nameTown,
    required this.icon,
    required this.weatherName,
    required this.currentTemp,
    required this.feelsLike,
    required this.wind,
    required this.pressure,
    required this.humidity,
    required this.cloudy,
    required this.visibility
  });

  factory MenuWeatherModel.mapApiResponse(ResponseWeatherModel item) {
    return MenuWeatherModel(
        nameTown: item.weatherInfo!.name,
        icon: "https://openweathermap.org/img/wn/${item.weatherInfo!.weather[0].icon}@2x.png",
        weatherName: item.weatherInfo!.weather[0].description,
        currentTemp: item.weatherInfo!.main.temp.toString(),
        feelsLike: item.weatherInfo!.main.feelsLike.toString(),
        wind: "${item.weatherInfo!.wind.speed.toString()}м/с",
        pressure: item.weatherInfo!.main.pressure.toString(),
        humidity: "${item.weatherInfo!.main.humidity.toString()}%",
        cloudy: "${item.weatherInfo!.clouds.all.toString()}%",
        visibility: "${item.weatherInfo!.visibility.toString()}м"
    );
  }
}

class MenuCryptoModel {
  String name;
  String image;
  String price;
  double changes;

  MenuCryptoModel({
    required this.name,
    required this.image,
    required this.price,
    required this.changes
  });

  factory MenuCryptoModel.mapApiResponse(CryptoItemModel item) {
    return MenuCryptoModel(
        name: item.name,
        image: item.image,
        price: "${item.currentPrice.toString()} \$",
        changes: item.dynamic
    );
  }
}

class MenuMapModel {
  double lat;
  double lon;
  String name;

  MenuMapModel({
    required this.lat,
    required this.lon,
    required this.name
  });
}