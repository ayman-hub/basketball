/*
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



const String DATA_TABLE = "data_table";
const String PRODUCT_TABLE = "product_table";

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  DBHelper.internal();

  factory DBHelper() => _instance;
  static Database _db;
  var streamDb;
  var dbClient;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    streamDb = StreamDatabase(_db);
    dbClient = _db;
    return _db;
  }

  setDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sqlite');
    var dB = openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "$DATA_TABLE" (
	"firstName"	TEXT NOT NULL,
	"email"	TEXT ,
	"lastName"	TEXT ,	
	"password"	TEXT ,	
	PRIMARY KEY("email")
);
    ''');
    await db.execute('''
   CREATE TABLE "$PRODUCT_TABLE" (
	"barcode"	INTEGER NOT NULL ,
	"num"	INTEGER NOT NULL,
	"offer"	TEXT ,
	"favorite"	Boolean ,
	"image"	TEXT ,
	"rate"	TEXT ,
	"ratingNum"	TEXT NOT NULL,
	"priceAfter"	TEXT NOT NULL,
	"priceBefore"	TEXT,
	"name"	TEXT,
	"chosenType"	TEXT,
	"type"	TEXT,
	PRIMARY KEY("barcode","chosenType")
);
    ''');
  }

  Future<bool> insertData(UserInfoEntities user) async {
    var dbClient = await db;
    try {
      int result = await dbClient.insert(DATA_TABLE, user.toJson());
      print("${result.toString()} insert in database email :    ${user.email}");
      return result > 0;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<bool> insertProduct(ProductInfoEntities product) async {
    var dbClient = await db;
    try {
      print("data in insertProducts : ${product.name}");
      int result = await dbClient.insert(PRODUCT_TABLE, product.toJson());
      print(
          "${result.toString()} insert in database barcode : ${product.barcode}  chosenType:${product.chosenType}");
      return result > 0;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<bool> updateProduct({Map<String, dynamic> row, int num}) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    var dbClient = await db;

    // row to update
    //Map<String, dynamic> row ;

    // We'll update the first row just as an example
    // int id = 1;

    // do the update and get the number of affected rows
    int updateCount = await dbClient.update(PRODUCT_TABLE, {'num': num},
        where: 'barcode = ? and chosenType = ?',
        whereArgs: [row['barcode'], row['chosenType']]);

    // show the results: print all rows in the db
    print(await dbClient.query(DATA_TABLE));
    return updateCount == 1;
  }

  Future<bool> updateFavoriteData(
      {Map<String, dynamic> row, bool favorite}) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    var dbClient = await db;

    // row to update
    //Map<String, dynamic> row ;

    // We'll update the first row just as an example
    // int id = 1;

    // do the update and get the number of affected rows
    int updateCount = await dbClient.update(
        PRODUCT_TABLE, {'favorite': favorite},
        where: 'barcode = ?', whereArgs: [row['barcode']]);

    // show the results: print all rows in the db
    print(updateCount);
    return updateCount == 1;
  }

  Future<bool> deleteData(String email) async {
    var dbClient = await db;
    int result = await dbClient
        .rawDelete('DELETE FROM $DATA_TABLE WHERE email = ?', [email]);
    print('delete data : $email');
    print("" + result.toString() + " this is the result");
    print("database : ${result == 1}");
    return result == 1;
  }

  Future<bool> deleteProduct(int barcode, String type) async {
    try {
      var dbClient = await db;
      print('delete Products : $barcode');
      int result = await dbClient.rawDelete(
          'DELETE FROM $PRODUCT_TABLE WHERE barcode = ?and chosenType = ?',
          [barcode, type]);
      print('delete data : $barcode , $type');
      print("" + result.toString() + " this is the result");
      return true;
    } catch (Error) {
      print('delete error :' + Error);
      return false;
    }
  }

  Future<List<UserInfoEntities>> getAllData() async {
    var dbClient = await db;
    List<UserInfoEntities> data = List<UserInfoEntities>();
    await dbClient.query(DATA_TABLE).then((List<Map<String, dynamic>> list) {
      print("data : ${list.length}");
      countData.add(list.length);
      list.forEach((m) {
        print('here');
        print("${m['id']} this is the map");
        data.add(UserInfoEntities.fromJson(m));
      });
    });
    return data;
  }

  Future<List<ProductInfoEntities>> getAllProductsFuture() async {
    var dbClient = await db;
    List<ProductInfoEntities> data = List<ProductInfoEntities>();
    await dbClient.query(PRODUCT_TABLE).then((List<Map<String, dynamic>> list) {
      print("data : ${list.length}");
      list.forEach((m) {
        //print('here');
        // print("${m['barcode']} this is the map");
        data.add(ProductInfoEntities.fromJson(m));
      });
    });
    return data;
  }

  Future<List<ProductInfoEntities>> getAllFavoriteProducts() async {
    var dbClient = await db;
    List<ProductInfoEntities> data = List<ProductInfoEntities>();
    await dbClient.query(PRODUCT_TABLE,
        where: "favorite = ?",
        whereArgs: [1]).then((List<Map<String, dynamic>> list) {
      print("data : ${list.length}");
      print("list database favorite ${list.toString()}");
      list.forEach((m) {
        print('here $m');
        // print("${m['barcode']} this is the map");
        if (m['favorite'] == 1) {
          print(m.toString());
          data.add(ProductInfoEntities.fromJson(m));
        }
      });
    });
    print("data in database : ${data.length}");
    return data;
  }
}
*/
