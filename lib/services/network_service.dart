import 'dart:convert';

import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/models/history_coin_model.dart';
import 'package:http/http.dart' as http;

class NetworkService {

  Future<dynamic> getAllCoinData({required int limit}) async {
    String url = "https://api.coincap.io/v2/assets?limit=$limit";

    try {
      http.Response response = await http.get(Uri.parse(url));
      
      if(response.statusCode == 200) {
        final coinsData = jsonDecode(response.body) as Map<String,dynamic>;
        final coinsList = coinsData["data"] as List;        
        var list = List<CoinModel>.from(coinsList.map((data) => CoinModel.fromJson(data)));
        return list;
      } else {
        return Future.error(response.statusCode);
      }
    } catch (error) {
      return Future.error(error);

    }
  }

  Future<dynamic> getCoinHistory({required coinId}) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 6));
    
    String url = "https://api.coincap.io/v2/assets/$coinId/history?interval=d1&start=${startDate.millisecondsSinceEpoch}&end=${endDate.millisecondsSinceEpoch}";
    
    try {
      http.Response response = await http.get(Uri.parse(url));

      if(response.statusCode == 200) {
        final historyData = jsonDecode(response.body) as Map<String,dynamic>;
        final historyList = historyData["data"] as List;
        var list = List<HistoryCoinModel>.from(historyList.map((data) => HistoryCoinModel.fromJson(data)));
        return list;
      } else {
        return Future.error(response.statusCode);
      }

    } catch (error) {
      return Future.error(error);
    }
  }


  Future<dynamic> getSingleCoinData({required String name}) async {
    String url = "https://api.coincap.io/v2/assets/$name";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String,dynamic>;
        if(data["data"] != null) {
          final coinData = data["data"] as Map<String,dynamic>;
          final coin = CoinModel.fromJson(coinData);
          return coin;
        } else {
          final error = data["error"] as String;
          return Future.error(error);
        }
        
      } else {
        return Future.error(response.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }


  }
}