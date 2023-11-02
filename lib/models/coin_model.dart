import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class CoinModel {
  final String id;
  final String symbol;
  final String name;
  final String supply;
  final String? maxSupply;
  final String marketCapUsd;
  final String volumeUsd24hr;
  final String priceUsd;
  final String changePercent24hr;
  final String vwap24hr;

  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.supply,
    this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24hr,
    required this.priceUsd,
    required this.changePercent24hr,
    required this.vwap24hr,
    });

  factory CoinModel.fromJson(jsonData) {
    return CoinModel(
      id: jsonData["id"], 
      symbol: jsonData["symbol"], 
      name: jsonData["name"], 
      supply: jsonData["supply"],
      maxSupply: jsonData["maxSupply"],
      marketCapUsd: jsonData["marketCapUsd"], 
      volumeUsd24hr: jsonData["volumeUsd24Hr"], 
      priceUsd: jsonData["priceUsd"], 
      changePercent24hr: jsonData["changePercent24Hr"], 
      vwap24hr: jsonData["vwap24Hr"]
      );
  }


  String getProperPrice(String price) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    var splittedPrice = price.split('.');
    var priceString = "${splittedPrice[0]}.${splittedPrice[1].substring(0,2)}";
    var priceDouble = double.parse(priceString);
    
    return oCcy.format(priceDouble);
  }

  String getProperPriceWithoutMinus () {
    double changePercentinDouble = double.parse(changePercent24hr);
    if (changePercentinDouble <0) {
      return changePercentinDouble.toStringAsFixed(2).substring(1);
    } else {
      return changePercentinDouble.toStringAsFixed(2);
    }
  }

  String getVwrapIn24hr() {
    double vwrap = double.parse(vwap24hr);
    return vwrap.toStringAsFixed(2);

  }

  String getChangeIn24hr() {
    double changePercentinDouble = double.parse(changePercent24hr);
    return changePercentinDouble.toStringAsFixed(2);
  }

  Color getChangeColor() {
    double changePercentinDouble = double.parse(changePercent24hr);
    if (changePercentinDouble < 0) {
      return Colors.red;
    } else if(changePercentinDouble == 0) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  IconData getChangeIcon() {
    double changePercentinDouble = double.parse(changePercent24hr);
    if (changePercentinDouble < 0) {
      return Icons.arrow_drop_down;
    } else if(changePercentinDouble == 0) {
      return Icons.remove;
    } else {
      return Icons.arrow_drop_up;
    }
  }




}