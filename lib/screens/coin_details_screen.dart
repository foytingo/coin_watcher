import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/models/coin_model_for_db.dart';
import 'package:coin_watcher/models/history_coin_model.dart';
import 'package:coin_watcher/services/network_service.dart';
import 'package:coin_watcher/views/chart_view.dart';
import 'package:coin_watcher/views/market_data_cell_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coin_watcher/providers/favorites_provider.dart';



class CoinDetails extends ConsumerWidget {
  const CoinDetails({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    final favorites = ref.watch(favoriteCoinsProvider);
    final matchedCoin = favorites.firstWhere((element) => element.coinId == coin.id, orElse: () => const CoinModelForDb(id: -1, coinId: "null"),);
    final isFavorite = matchedCoin.id>=0 ? true: false;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: ()  async {
            final wasAdded = await ref.read(favoriteCoinsProvider.notifier).toggleCoinsFavoriteStatus(coin);
            if (context.mounted) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(wasAdded ? "${coin.name} added to favorite list." : "${coin.name} removed from favorite list")));
            }
          }, icon: Icon(isFavorite ? Icons.favorite: Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: Image.network("https://coinicons-api.vercel.app/api/icon/${coin.symbol.toLowerCase()}", fit: BoxFit.fitWidth,),
                  ),
                  const SizedBox(width: 24,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${coin.name} / ${coin.symbol}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text("\$", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),),
                            const SizedBox(width: 2,),
                            Text(coin.getProperPrice(coin.priceUsd), style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 36,),textScaleFactor: 0.65,),
                            const SizedBox(width: 4,),
                            Text("USD", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 82,
                    height: 32,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: coin.getChangeColor()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(coin.getChangeIcon(), color: Colors.white, size: 24,),
                        Text("${coin.getProperPriceWithoutMinus()}%", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),)
                      ],
                    ),
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Last 5 days price", style: Theme.of(context).textTheme.titleMedium,),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal:18, vertical: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Theme.of(context).colorScheme.onInverseSurface,),
              child: AspectRatio(
                aspectRatio: 1.7,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18,left: 12,top: 24,bottom: 12,),
                  child: FutureBuilder(
                    future: NetworkService().getCoinHistory(coinId: coin.id), 
                    builder: (contex,snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasData) {
                          var historyPrices = snapshot.data as List<HistoryCoinModel>;
                          return ChartView(historyPrices: historyPrices);
                        } else {
                          return const Center(child: Text("Price chart not available. \nPlease try again later.", textAlign: TextAlign.center,));
                        }
                      } else {
                        return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).primaryColor, size: 76));
                      }
                    }
                    ),
                  ),
                ),
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Market Stats", style: Theme.of(context).textTheme.titleMedium,),
            ),
      
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              margin: const EdgeInsets.only(left:18, right: 18, top: 8, bottom: 32),
              width: double.infinity,
      
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Theme.of(context).colorScheme.onInverseSurface,),
              child: Column(
                children: [
                  MarketStatsCellView(title: "Market Cap", value: "\$${coin.getProperPrice(coin.marketCapUsd)}" ,),
                  MarketStatsCellView(title: "Volume (24 Hrs)", value: "\$${coin.getProperPrice(coin.volumeUsd24hr)}" ,),
                  MarketStatsCellView(title: "Supply", value: coin.supply.split('.')[0]),
                  if (coin.maxSupply != null) MarketStatsCellView(title: "Max Supply", value: coin.maxSupply!.split('.')[0]),
                  MarketStatsCellView(title: "VWAP (24 Hrs)", value: coin.getVwrapIn24hr()),
              ]),
              ),
            
          ],
        ),
      ),
    );
  }
}

