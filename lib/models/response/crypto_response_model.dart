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

  String nameCoin;

  CryptoModel({
    required this.nameCoin,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {

    return CryptoModel(nameCoin: "bitcoin");
  }
}