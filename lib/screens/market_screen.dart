
import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/screens/coin_details_screen.dart';
import 'package:coin_watcher/services/network_service.dart';
import 'package:coin_watcher/views/error_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:coin_watcher/views/coin_cell_view.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}
class _MarketScreenState extends State<MarketScreen> {

  late List<CoinModel> coins;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: FutureBuilder(
        future: NetworkService().getAllCoinData(limit: 20), 
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData) {
              var coins = snapshot.data as List<CoinModel>;
              return ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetails(coin: coins[index])));
                    },
                    child: CoinCellView(coin: coins[index])
                  );
              });
            } else {
              return const ErrorView();
            }
          } else if(snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).primaryColor, size: 150));
          } else {
            return const ErrorView();
          }
        })

    );
  }
}

