import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../cart_model.dart';

class DatabaseHelper {
  static final _dbName = 'Advikadb';
  static final _dbVersion = 1;
  static final _tableName = 'producttab';
  static final id = 'id';
  static final productId = 'productid';
  static final productName = 'productname';
  static final productImage = 'productimage';
  static final productPrice = 'productprice';
  static final unitName = 'unitname';
  static final categoryName = 'categoryname';
  static final minimumQty = 'minimumqty';
  static final minimumUnit = 'minimumunit';
  static final orderQty = 'orderqty';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tableName (
            $id INTEGER PRIMARY KEY,
            $productId TEXT NOT NULL,
            $productName TEXT NOT NULL,
            $productImage TEXT NOT NULL,
            $productPrice TEXT NOT NULL,
            $unitName TEXT NOT NULL,
            $categoryName TEXT NOT NULL,
            $minimumQty TEXT NOT NULL,
            $orderQty TEXT NULL
        )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("$_tableName", row);
  }
  // Future<List<GetAllProduct>> queryAll() async{
  //   Database db = await instance.database;
  //   final List<Map> maps = await db.query("$_tableName");
  //   List<GetAllProduct> product = [];
  //    if(maps.length>0){
  //      for(int i = 0;i<maps.length;i++){
  //        product.add(GetAllProduct.fromMap(maps[i]));
  //      }
  //    }
  //    return product;

  // }
  Future<int> getProductById(int id) async {
    Database db = await instance.database;
    // return await db.query(_tableName, where: '$productId = ?', whereArgs: [id]);
    final result = await db
        .rawQuery('SELECT COUNT(*) FROM $_tableName WHERE $productId = $id');
    final count = Sqflite.firstIntValue(result);

    if (count > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> getProductByIdInMain(String id) async {
    Database db = await instance.database;
    // return await db.query(_tableName, where: '$productId = ?', whereArgs: [id]);
    final result = await db
        .rawQuery('SELECT COUNT(*) FROM $_tableName WHERE $productId = $id');
    final count = Sqflite.firstIntValue(result);

    if (count > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> checkProduct() async {
    Database db = await instance.database;
    // return await db.query(_tableName, where: '$productId = ?', whereArgs: [id]);
    final result = await db.rawQuery(
        'SELECT  COUNT(*) FROM $_tableName WHERE $orderQty != \"null\"');
    final result2 = await db.rawQuery('SELECT  COUNT(*) FROM $_tableName ');
    final count = Sqflite.firstIntValue(result);
    final count2 = Sqflite.firstIntValue(result2);
    var total = count2 - count;

    // print(total);
    if (total == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db
        .update("$_tableName", row, where: 'id = ?', whereArgs: [id]);
  }

  Future updateCart(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row['productid'];
    return await db
        .update("$_tableName", row, where: 'productid = ?', whereArgs: [id]);
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete("$_tableName", where: "id=?", whereArgs: [id]);
  }

  Future<int> deleteFromCart(String id) async {
    Database db = await instance.database;
    return await db
        .delete("$_tableName", where: "productid=?", whereArgs: [id]);
  }

  Future<int> addProduct(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var product = row['$productId'];
    final result = await db.rawQuery(
        'SELECT COUNT(*) FROM $_tableName WHERE $productId = $product');
    final count = Sqflite.firstIntValue(result);

    if (count == 0) {
      return await db.insert("$_tableName", row);
    } else {
      return 0;
    }
  }

  Future<int> getcount(id) async {
    Database db = await instance.database;
    int count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM $_tableName WHERE $productId=$id"));
    return count;
  }

  // Future<int> deleteall() async {
  //   Database db = await instance.database;
  //   return await db.delete("$_tableName");
  // }

  getProduct() async {
    Database db = await instance.database;

    var res = await db.query(_tableName);

    try {
      List<Product> list = res.map((c) => Product.fromMap(c)).toList();
      return list;
    } catch (e) {
      print(e);
    }
  }
}
