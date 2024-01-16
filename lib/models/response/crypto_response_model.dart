enum Status {
  success,
  error,
}

class ResponseCryptoModel {
  List<CryptoModel>? listOfCrypto;
  Status statusOfResponse;

  ResponseCryptoModel({
    required this.listOfCrypto,
    required this.statusOfResponse
  });
}

class CryptoModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  double marketCapRank;
  double fullyDilutedValuation;
  double totalVolume;
  double high24h;
  double low24h;
  double priceChange24h;
  double priceChangePercentage24h;
  double marketCapChange24h;
  double marketCapChangePercentage24h;
  double circulatingSupply;
  double totalSupply;
  double? maxSupply;
  double ath;
  double athChangePercentage;
  String athDate;
  double atl;
  double atlChangePercentage;
  String atlDate;
  Roi? roi;
  String lastUpdated;
  double priceChangePercentage1hInCurrency;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
    required this.priceChangePercentage1hInCurrency
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
      'id': String id,
      'symbol': String symbol,
      'name': String name,
      'image': String image,
      'current_price': double currentPrice,
      'market_cap': double marketCap,
      'market_cap_rank': double marketCapRank,
      'fully_diluted_valuation': double fullyDilutedValuation,
      'total_volume': double totalVolume,
      'high_24h': double high24h,
      'low_24h': double low24h,
      'price_change_24h': double priceChange24h,
      'price_change_percentage_24h': double priceChangePercentage24h,
      'market_cap_change_24h': double marketCapChange24h,
      'market_cap_change_percentage_24h': double marketCapChangePercentage24h,
      'circulating_supply': double circulatingSupply,
      'total_supply': double totalSupply,
      'max_supply': double maxSupply,
      'ath': double ath,
      'ath_change_percentage': double athChangePercentage,
      'ath_date': String athDate,
      'atl': double atl,
      'atl_change_percentage': double atlChangePercentage,
      'atl_date': String atlDate,
      'roi': Roi roi,
      'last_updated': String lastUpdated,
      'price_change_percentage_1h_in_currency': double priceChangePercentage1hInCurrency
      } =>
          CryptoModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24h: high24h,
            low24h: low24h,
            priceChange24h: priceChange24h,
            priceChangePercentage24h: priceChangePercentage24h,
            marketCapChange24h: marketCapChange24h,
            marketCapChangePercentage24h: marketCapChangePercentage24h,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            roi: Roi.fromJson(roi),
            lastUpdated: lastUpdated,
            priceChangePercentage1hInCurrency: priceChangePercentage1hInCurrency
          ),
    _ => throw const FormatException('Failed to load'),
    };
  }
}


class Roi {
  double times;
  String currency;
  double percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });


  factory Roi.fromJson(dynamic json) {
    return switch(json) {
      {
        'times': double times,
        'currency': String currency,
        'percentage': double percentage
      } => Roi (
        times: times,
        currency: currency,
        percentage: percentage
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}