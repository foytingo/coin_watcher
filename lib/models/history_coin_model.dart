

class HistoryCoinModel{
  final String price;
  final int time;


  HistoryCoinModel({required this.price, required this.time});

  factory HistoryCoinModel.fromJson(jsonData) {
    var doublePrice = double.parse(jsonData["priceUsd"]);
    var double2digit = doublePrice.toStringAsFixed(6);
    
    return HistoryCoinModel(price: double2digit, time: jsonData["time"]);
  }
}