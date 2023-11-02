import 'package:coin_watcher/models/coin_model_for_db.dart';
import 'package:coin_watcher/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:coin_watcher/models/coin_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:coin_watcher/screens/coin_details_screen.dart';

class FavoriteCoinCellView extends StatelessWidget {
  const FavoriteCoinCellView({super.key,required this.coinFromDb});

  final CoinModelForDb coinFromDb;
  
  @override
  Widget build(BuildContext context) {
    CoinModel? coin;
    return GestureDetector(
      onTap: () {
        if (coin != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetails(coin: coin!)));
        } 
      },
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.onInverseSurface, borderRadius: BorderRadius.circular(12)),
        child: FutureBuilder(
          future: NetworkService().getSingleCoinData(name: coinFromDb.coinId), 
          builder: (contex,snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                coin = snapshot.data as CoinModel;
                if(coin != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(child: SizedBox(width: 64,height: 64,child: Image.network("https://coinicons-api.vercel.app/api/icon/${coin!.symbol.toLowerCase()}"),)),
                      Text(coin!.name),
                      Text(coin!.symbol, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade500),),
                      Text("\$${coin!.getProperPrice(coin!.priceUsd)}", style: TextStyle(color: coin!.getChangeColor()),),
                    ],
                  );

                } else {
                  return const Center(child: Text("Coin not foud try again later."));
                }
              } else {
                return const Center(child: Text("Coin not foud try again later."));
              }
          
            } else {
              return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).primaryColor, size: 25));
            }
          } 
          )
        
      ),
    );
  }
}