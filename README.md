# Coin Watcher App
![](https://i.imgur.com/55X4sEF.png)

This is a cross-platform app that is made with Flutter. With this app, you can find the current crypto prices and you can add them to your favorite list. You track easly.

You can download and run without any settings like the API key.
Or you can download it from [Apple AppStore](https://apps.apple.com/us/app/coin-watcher-cryptocoin-price/id6471106834 "Apple AppStore") or[ Google PlayStore](https://play.google.com/store/apps/details?id=com.muratbaykor.coin_watcher "Google PlayStore").

#### Used Public APIs
[CoinCap API 2.0 ](https://docs.coincap.io/)for current and hystorical crypto coin prices
[Crypto Icon API](https://coinicons-api.vercel.app) for crypto coin icons.


#### Features
- HTTP request with [http](https://pub.dev/packages/http "http") package.
- Show last 5 days crypto price using custom chart with [FL Chart](https://pub.dev/packages/fl_chart "FL Chart") package.
- SQLite database with [sqlite3 ](https://pub.dev/packages/sqlite3 "sqlite3 ") package to persist favorites cryptocoins.
- State managment with [riverpod](https://pub.dev/packages/flutter_riverpod "riverpod") to manage favorite button action and trigger SQLite CRUD actions.
- Proper error handling with custom views and ScaffoldMessages.
- JSON parsing with custom model
- Asynchronous programming (Future, async/await)
- Loading screen while getting data from server with http request with [loading_animation_widget](https://pub.dev/packages/loading_animation_widget "loading_animation_widget") package.

#### Screenshots

![](https://i.imgur.com/cj5NxGP.png)

#### Usage Video
[Youtube](https://www.youtube.com/watch?v=VUyO2ePrtBU "Youtube")

### License

This project is licensed under the GNU GPLv3 - see the LICENSE.md file for details
