import 'package:flutter/material.dart';


class MarketStatsCellView extends StatelessWidget {
  const MarketStatsCellView({super.key,required this.title,required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:18),
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.25, color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: Theme.of(context).textTheme.labelLarge,)
        ],
      ),
    );
  }
}