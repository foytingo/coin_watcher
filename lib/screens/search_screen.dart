import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/screens/coin_details_screen.dart';
import 'package:coin_watcher/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focus = FocusNode();
  final _controller = TextEditingController();
  late bool _showLoading;
  late bool _isButtonDisabled;

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _showLoading = false;
    _isButtonDisabled = true;
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/cryptocurrency.png", width: 125,),
        const SizedBox(height: 24,),
        Text("Coin Watcher", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.primary)),
        Text("Find out crypto coin prices.", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary)),
        const SizedBox(height: 30,),
        TapRegion(
          onTapOutside: (event) {
            _focus.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _focus,
                      controller: _controller,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: "Search a coin",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                        suffixIcon: _controller.text.isNotEmpty ? IconButton(onPressed: () {
                          setState(() {
                            _isButtonDisabled = true;
                            _controller.clear();
                          });
                        }, icon: const Icon(Icons.clear),) : null,
                      ),     
                      onChanged: (value) {
                        setState(() {
                          _isButtonDisabled = value.isEmpty;
                        });
                      },
                    ),
                  ),
                  if(_focus.hasFocus)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextButton(onPressed: (){
                      _isButtonDisabled = true;
                      _controller.clear();
                      _focus.unfocus();
                    }, child: const Text("Cancel")),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: _isButtonDisabled ? null : () async {
            setState(() { 
              _showLoading = true; 
              _isButtonDisabled = true;
            });
            try {
              CoinModel coin = await NetworkService().getSingleCoinData(name: _controller.text);
              setState(() {
                _showLoading = false; 
                _isButtonDisabled = false;

              });
              if (context.mounted) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CoinDetails(coin: coin)));
              }
            } catch (error) {
              setState(() {
                _showLoading = false; 
                _isButtonDisabled = true;
                _controller.clear();
              });
              if (context.mounted) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coin was not found. Enter full name of coin.")));
              }

            }
          },
          child: Container(
            width: 136,
            height: 40,
            decoration: BoxDecoration(color: _isButtonDisabled ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(12)),
            child: 
            _showLoading ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 25)):
            Center(child: Text("Search", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white))) 
          ),
        )

      ],
    );
  }
}