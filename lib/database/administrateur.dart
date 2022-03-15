import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Administrateur {
  late int id;
  late String login;
  late String password;
  //constructeur
  Administrateur(this.id, this.login, this.password);
  //fonction toMap() pour
  Map<String, dynamic> toMap() {
    return {"id": id, "login": login, "password": password};
  }

//fonction d'insertion des administrateurs
  Future<void> insertAdmin(Administrateur ad) async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final database =
          openDatabase(join(await getDatabasesPath(), 'gestion_data.db'));

      var db = await database;
      db.insert('administrateur', ad.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }
}
