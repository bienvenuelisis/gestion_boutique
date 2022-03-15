
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_boutique/database/produits.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'affichageproduits.dart';
import 'insererproduits.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Index();
  }
}

late String admin;
Map<String, Object?> admi = {};
String admni = "";

class _Index extends State<Index> {
  //fonction to get admin
  Future<List<String>> getAdmin() async {
    //
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    //variables stockant les logins
    List<String> admn = [];
    final database =
        openDatabase(join(await getDatabasesPath(), 'gestion_data.db'));
    var db = await database;
    var adm = await db.query("administrateur");
    //debut du traitement de l'administrateur
    adm.forEach((element) {
      //print(element);
      setState(() {
        admi = element;
      });
    });
    print(admi);
    admi.forEach(
      (key, value) {
        setState(() {
          admn.add(value.toString());
          //print(admn);
        });
      },
    );
    setState(() {
      admni = admn[1];
    });
    print(admni);
    return admn;
  }

  /*traitAdmin(List<Map<String, Object?>> admi) {
    admi.forEach((element) {
      print(element);
    });
  }*/

  @override
  void initState() {
    getAdmin();
    // traitAdmin(admi);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double textscale = MediaQuery.of(context).textScaleFactor * 20;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        title: Text(
          "BOX DE GESTION BOUTIQUE",
          style: GoogleFonts.poppins(
            fontSize: textscale,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          height: _height,
          width: _width,
          child: Row(
            children: [
              Container(
                height: _height,
                width: _width / 6,
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Container(
                      height: _height / 10,
                      width: _width / 8,
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset("images/admin.png"),
                    ),
                    SizedBox(
                      height: _height / 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.online_prediction,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: _width / 64,
                        ),
                        Text(
                          admni,
                          style: GoogleFonts.poppins(fontSize: textscale),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: _height,
                width: _width - _width / 6,
                child: Column(
                  children: [
                    SizedBox(
                      height: _height / 64,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "TABLEAU DE BORD",
                            style: GoogleFonts.poppins(
                                fontSize: textscale + textscale / 3,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //print("tap");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Insert()));
                            },
                            child: Container(
                              height: _height / 2.5,
                              width: _width / 4.3,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _height / 32,
                                      ),
                                      Text(
                                        "AJOUTER DES PRODUITS",
                                        style: GoogleFonts.poppins(
                                            fontSize: textscale - 5),
                                      ),
                                      Image.asset("images/add_product.png"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _width / 64,
                          ),
                          GestureDetector(
                            onTap: () {
                              //print("tap");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Affichage()));
                            },
                            child: Container(
                              height: _height / 2.5,
                              width: _width / 4.3,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _height / 32,
                                      ),
                                      Text(
                                        "AFFICHER LES PRODUITS",
                                        style: GoogleFonts.poppins(
                                            fontSize: textscale - 5),
                                      ),
                                      Image.asset(
                                        "images/eye_show.png",
                                        fit: BoxFit.contain,
                                        height: _height / 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _width / 64,
                          ),
                          GestureDetector(
                            onTap: (() {
                              print("tap");
                            }),
                            child: Container(
                              height: _height / 2.5,
                              width: _width / 4.3,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _height / 32,
                                      ),
                                      Text(
                                        "SUIVI DE LA BOUTIQUE",
                                        style: GoogleFonts.poppins(
                                            fontSize: textscale - 5),
                                      ),
                                      Image.asset("images/suivi.png"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
