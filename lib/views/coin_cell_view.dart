import 'package:flutter/material.dart';
import 'package:coin_watcher/models/coin_model.dart';

class CoinCellView extends StatelessWidget {
  const CoinCellView({
    super.key,
    required this.coin,
  });
  
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.only(left: 18, right: 8),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onInverseSurface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(child: SizedBox(width: 30,height: 30,child: Image.network("https://coinicons-api.vercel.app/api/icon/${coin.symbol.toLowerCase()}"),)),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(coin.name),
              Text(coin.symbol, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade500),)
            ],),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text("\$${coin.getProperPrice(coin.priceUsd)}"),
            Text("${coin.getChangeIn24hr()}%", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: coin.getChangeColor()),)
          ],),
          const SizedBox(width: 8,),
          Icon(Icons.chevron_right, color: Colors.grey.shade500,)
        ],
      ),
    );
  }
}