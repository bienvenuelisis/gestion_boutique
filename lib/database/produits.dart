import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/widgets.dart';

//cree classe de produit
class Produits {
  //late int id;
  late String nomproduits;
  late String categorie;
  late double prix;
  late int stock;
  //initialisateur
  Produits(this.nomproduits, this.categorie, this.prix, this.stock);
  //fonction tomap
  Map<String, dynamic> toMap(Produits p) {
    return {
      "nom_produits": p.nomproduits,
      "categorie": p.categorie,
      "prix": p.prix,
      "stock": p.stock
    };
  }

  Future<void> insertProduit(Produits p) async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    WidgetsFlutterBinding.ensureInitialized();
    final database =
        openDatabase(join(await getDatabasesPath(), "gestion_data.db"));
    var db = await database;
    db.insert("produit", p.toMap(p),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("produit inserer");
  }
  //getter des produits
  Future<List<Map<String, dynamic>>> getProduits() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    WidgetsFlutterBinding.ensureInitialized();
    final database =
        openDatabase(join(await getDatabasesPath(), "gestion_data.db"));
    var db = await database;
    print(await db.query("produit"));
    var tr = await db.query("produit");
    return tr;
  }
  //update produits
  Future<void> updateProduits(Produits p, int id) async {
  // Get a reference to the database.
  final database =
        openDatabase(join(await getDatabasesPath(), "gestion_data.db"));
  final db = await database;

  await db.update(
    'produit',
    p.toMap(p),
 
    where: 'id = ?',
    
    whereArgs: [id],
  );
}
Future<void> deleteProduit(int id) async {
  final database =
        openDatabase(join(await getDatabasesPath(), "gestion_data.db"));
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the database.
  await db.delete(
    'produit',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}
}
