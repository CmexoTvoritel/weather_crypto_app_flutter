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
      'current_price': num currentPrice,
      'market_cap': num marketCap,
      'market_cap_rank': num marketCapRank,
      'fully_diluted_valuation': num fullyDilutedValuation,
      'total_volume': num totalVolume,
      'high_24h': num high24h,
      'low_24h': num low24h,
      'price_change_24h': num priceChange24h,
      'price_change_percentage_24h': num priceChangePercentage24h,
      'market_cap_change_24h': num marketCapChange24h,
      'market_cap_change_percentage_24h': num marketCapChangePercentage24h,
      'circulating_supply': num circulatingSupply,
      'total_supply': num totalSupply,
      'max_supply': num? maxSupply,
      'ath': num ath,
      'ath_change_percentage': num athChangePercentage,
      'ath_date': String athDate,
      'atl': num atl,
      'atl_change_percentage': num atlChangePercentage,
      'atl_date': String atlDate,
      'roi': Map<String, dynamic>? roi,
      'last_updated': String lastUpdated,
      'price_change_percentage_1h_in_currency': num priceChangePercentage1hInCurrency
      } =>
          CryptoModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice.toDouble(),
            marketCap: marketCap.toDouble(),
            marketCapRank: marketCapRank.toDouble(),
            fullyDilutedValuation: fullyDilutedValuation.toDouble(),
            totalVolume: totalVolume.toDouble(),
            high24h: high24h.toDouble(),
            low24h: low24h.toDouble(),
            priceChange24h: priceChange24h.toDouble(),
            priceChangePercentage24h: priceChangePercentage24h.toDouble(),
            marketCapChange24h: marketCapChange24h.toDouble(),
            marketCapChangePercentage24h: marketCapChangePercentage24h.toDouble(),
            circulatingSupply: circulatingSupply.toDouble(),
            totalSupply: totalSupply.toDouble(),
            maxSupply: maxSupply?.toDouble(),
            ath: ath.toDouble(),
            athChangePercentage: athChangePercentage.toDouble(),
            athDate: athDate,
            atl: atl.toDouble(),
            atlChangePercentage: atlChangePercentage.toDouble(),
            atlDate: atlDate,
            roi: roi != null? Roi.fromJson(roi): null,
            lastUpdated: lastUpdated,
            priceChangePercentage1hInCurrency: priceChangePercentage1hInCurrency.toDouble()
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