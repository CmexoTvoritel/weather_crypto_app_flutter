import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_crypto_app_flutter/models/response/weather_response_model.dart';

class WeatherApi {

  get _url => "https://api.openweathermap.org/data/2.5/weather";

  String _getFinalURL(double lat, double lon) {
    String answer = _url;
    answer += "?lat=$lat&lon=$lon&appid=22c2b837bf6f65a956144d42d02343bb&lang=ru&units=metric";
    return answer;
  }

  Future<ResponseWeatherModel> fetchData(double lat, double lon) async {
    final finalURL = _getFinalURL(lat, lon);
    final response = await http.get(Uri.parse(finalURL));

    if(response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      WeatherModel weatherInfo = WeatherModel.fromJson(responseData);
      return ResponseWeatherModel(
          weatherInfo: weatherInfo,
          responseStatus: Status.success
      );
    } else {
      return ResponseWeatherModel(
          weatherInfo: null,
          responseStatus: Status.error
      );
    }
  }
}