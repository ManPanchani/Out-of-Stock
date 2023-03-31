import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../globals.dart';
import '../models/models.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String databaseName = "product.db";
  final String tableName = "product";
  final String colId = "Id";
  final String? colName = "Name";
  final String? colImage = "Image";
  final String? colQuantity = "Quantity";

  Database? db;

  Future<void> initDB() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, databaseName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colImage BLOB, $colQuantity INTEGER);");
    });
  }

  Future<void> insertRecord() async {
    await initDB();

    for (int i = 0; i < Global.products.length; i++) {
      Product data = Product.fromMap(data: Global.products[i]);

      String query =
          "INSERT INTO $tableName($colName, $colImage, $colQuantity) VALUES(?, ?, ?);";
      List args = [
        data.name,
        data.image,
        data.quantity,
      ];
      await db!.rawInsert(query, args);
    }
  }

  Future<List<ProductDB>> fetchAllRecode() async {
    await initDB();
    await insertRecord();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<ProductDB> productDB =
        data.map((e) => ProductDB.fromMap(data: e)).toList();
    return productDB;
  }

  Future<void> updateRecord({required int id, required int quantity}) async {
    await initDB();

    int? a = await db?.rawUpdate(
        "Update $tableName SET $colQuantity= ? WHERE $colId = ?",
        [quantity, id]);
  }
}
