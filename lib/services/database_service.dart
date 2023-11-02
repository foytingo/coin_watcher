import 'package:coin_watcher/models/coin_model.dart';
import 'package:coin_watcher/models/coin_model_for_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'as sql;

class DatabaseService {

  static Future<void> createTable(sql.Database database) async {
    await database.execute(
      "CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT, coinId TEXT)",
    );
  }


  static Future<sql.Database> db() async {
    String path = await sql.getDatabasesPath();

    return sql.openDatabase(
      join(path, 'favorites.db'),
      onCreate: (db, version) async {
        await db.execute(
         "CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT, coinId TEXT)"
        );
      },version: 1,
    );
  }

  static Future<int> createFavorite(CoinModel model) async {
    final db = await DatabaseService.db();
    final coin = {"coinId" : model.id};
    final id = db.insert("favorites", coin, conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;

  }

  static Future<bool> deleteFavorite(int id) async {
    final db = await DatabaseService.db();
    try {
      db.delete("favorites", where: "id = ?", whereArgs: [id]);
      return true;
    } catch (error) {
      return false;

    }
  }

  static Future<List<CoinModelForDb>> getFavorites() async {
    final db = await DatabaseService.db();
    final List<Map<String,dynamic>> favorites = await db.query('favorites', orderBy: 'id');
    return List.generate(favorites.length, (index) => CoinModelForDb(id: favorites[index]["id"] as int , coinId: favorites[index]["coinId"] as String));
  }
    // final String databaseName = "favorites.db";
  

  // Future<Database> initDb() async {
  //   String path = await getDatabasesPath();

  //   return openDatabase(
  //     join(path, 'favorites.db'),
  //     onCreate: (db, version) async {
  //         await db.execute("CREATE TABLE Favorites(id INTEGER PRIMARY KEY AUTOINCREMENT, coinId TEXT)");
  //     }
  //   );
  // }

  // Future<List> readDb() async {
  //   final db = await instance
  // }
}