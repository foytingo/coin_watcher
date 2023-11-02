import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 96.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/bank.png", width: 128),
          const SizedBox(height: 12,),
          SizedBox(
            width: double.infinity, child: Text("Can not get market data at the moment.\n Please try again later.", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary), textAlign: TextAlign.center,))
      
        ],
      ),
    );
  }
}
