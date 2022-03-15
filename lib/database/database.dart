import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//creation base de donnees
Future getDatabase() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'gestion_data.db'),
    version: 1,
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          'CREATE TABLE administrateur ( id INTEGER PRIMARY KEY,login varchar(50) NOT NULL,password varchar(50) NOT NULL);CREATE TABLE produit (id INTEGER PRIMARY KEY , nom_produits varchar(50) NOT NULL ,categorie varchar(50) NOT NULL,prix float(10) NOT NULL,stock int(11) NOT NULL);CREATE TABLE rentabilite  (id INTEGER PRIMARY KEY ,prix_total float(50) NOT NULL, total_vendues float(50) NOT NULL);CREATE TABLE boutique(id INTEGER PRIMARY KEY,nom varchar(50) NOT NULL,password varchar(50) NOT NULL,licence varchar(50) NOT NULL);');
    },
  );
}
