import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/models/coin_model_for_db.dart';
import 'package:coin_watcher/services/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteCoinsNotifier extends StateNotifier<List<CoinModelForDb>> {
  FavoriteCoinsNotifier() : super([]) {refreshFavorites();}

  void refreshFavorites() async {
    final data = await DatabaseService.getFavorites();
    state = data;
  }

  bool checkIsFavorite(CoinModel coin) {
    final matchedCoin = state.firstWhere((element) => element.coinId == coin.id, orElse: () => const CoinModelForDb(id: -1, coinId: "null"),);
    return matchedCoin.id>=0 ? true: false;
  }

  Future<bool> toggleCoinsFavoriteStatus(CoinModel coin) async {
    final matchedCoin = state.firstWhere((element) => element.coinId == coin.id, orElse: () => const CoinModelForDb(id: -1, coinId: "null"),);
    if(matchedCoin.id>=0) {
      await DatabaseService.deleteFavorite(matchedCoin.id);
      refreshFavorites();
      return false;
    } else {
      await DatabaseService.createFavorite(coin);
      refreshFavorites();
      return true;
    }

  }
  
}

final favoriteCoinsProvider = StateNotifierProvider<FavoriteCoinsNotifier,List<CoinModelForDb>>((ref){
  return FavoriteCoinsNotifier();
});