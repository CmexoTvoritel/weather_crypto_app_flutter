import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_crypto_app_flutter/models/response/crypto_response_model.dart';

class CryptoApi {

  get url => "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false&price_change_percentage=1h";

  Future<ResponseCryptoModel> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<CryptoModel> cryptoList =
        responseData.map((json) => CryptoModel.fromJson(json)).toList();
      return ResponseCryptoModel(
          listOfCrypto: cryptoList,
          statusOfResponse: Status.success
      );
    } else {
      return ResponseCryptoModel(
          listOfCrypto: null,
          statusOfResponse: Status.error
      );
    }
  }

}