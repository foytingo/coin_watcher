import 'package:flutter/material.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 96.0),
      child: Column(
         children: [
          Image.asset("assets/banking.png", width: 128),
          const SizedBox(height: 12,),
          SizedBox(
            width: double.infinity, 
            child: Text("No coin was marked favorite.", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary), textAlign: TextAlign.center,))
         ],
       ),
    );
  }
}
