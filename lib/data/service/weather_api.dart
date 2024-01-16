import 'package:http/http.dart' as http;

class WeatherApi {

  //TODO:
  get url => "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false&price_change_percentage=1h";

  void fetchData() async {
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      //TODO: return response with success status
    } else {
      //TODO: Exception of response
    }
  }
}