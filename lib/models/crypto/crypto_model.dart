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
}