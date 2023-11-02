
import 'package:coin_watcher/models/coin_model_for_db.dart';
import 'package:coin_watcher/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coin_watcher/views/favorite_coin_cell_view.dart';
import 'package:coin_watcher/views/empty_favorites_view.dart';


class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CoinModelForDb> favoriteCoins = ref.watch(favoriteCoinsProvider);

    if(favoriteCoins.isEmpty) {
      return const EmptyFavoritesView();
    } 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12.0, crossAxisSpacing: 24.0), 
        itemCount: favoriteCoins.length,
        itemBuilder: (context, index) {
          var coin = favoriteCoins[index];
          return FavoriteCoinCellView(coinFromDb: coin);
        }
      ),
    );
    
  }
}


