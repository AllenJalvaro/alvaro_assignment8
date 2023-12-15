import 'package:alvaro_assignment8/models/product_item.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const db = 'product_management.db';
  static const dbVersion = 1;
  static const tbName = 'products';
  static const sku = 'productSKU';
  static const productName = 'productName';
  static const desc = 'productDescription';
  static const price = 'productPrice';
  static const discount = 'productDiscountedPrice';
  static const quantity = 'productQuantity';
  static const manufacturer = 'productManufacturer';

  late Database dbase;

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get database async {
    dbase = await _initDatabase();
    return dbase;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), db);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tbName (
        $sku TEXT PRIMARY KEY,
        $productName TEXT,
        $desc TEXT,
        $price REAL,
        $discount REAL,
        $quantity INTEGER,
        $manufacturer TEXT
      )
    ''');
  }

 Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tbName);
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert(
      tbName,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update(
      tbName,
      product.toMap(),
      where: '$sku = ?',
      whereArgs: [product.sku],
    );
  }

  Future<void> deleteProduct(String sku) async {
    final db = await database;
    await db.delete(
      tbName,
      where: '$sku = ?',
      whereArgs: [sku],
    );
  }
}
