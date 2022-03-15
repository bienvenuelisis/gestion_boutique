import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_boutique/database/produits.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Affichage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Affichage();
  }
}

class _Affichage extends State<Affichage> {
  Produits produit = Produits("IPHONE5", "Telephone", 100000, 3);

  //
  List<Map<String, dynamic>> prdu = [];
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
    var tr = await db.query("produit");
    setState(() {
      prdu = tr;
    });
    // print(prdu);
    return tr;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //produit.insertProduit(produit);
    getProduits();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double textscale = MediaQuery.of(context).textScaleFactor * 20;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: getProduits, icon:const Icon(Icons.refresh))
        ],
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "LISTE DES PRODUITS",
          style: GoogleFonts.poppins(fontSize: textscale),
        ),
      ),
      body: Container(
        width: _width,
        height: _height,
        //margin: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ID PRODUIT",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
                Text(
                  "NOM PRODUIT",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
                Text(
                  "CATEGORIE",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
                Text(
                  "PRIX",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
                Text(
                  "STOCK",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
                Text(
                  "ACTIONS",
                  style: GoogleFonts.poppins(fontSize: textscale + 1),
                ),
              ],
            ),
            SizedBox(
              height: _height / 64,
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: ((context, index) {
                    return Container(
                      //padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${prdu[index]['id']}"),
                          Text("${prdu[index]['nom_produits']}"),
                          Text("${prdu[index]['categorie']}"),
                          Text("${prdu[index]['prix']}"),
                          Text("${prdu[index]['stock']}"),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: (() {
                                      produit.deleteProduit(
                                          int.parse("${prdu[index]['id']}"));
                                    }),
                                    child:const Text("supprimer")),
                                TextButton(
                                    onPressed: (() {
                                      //en parametre un 
                                      produit.updateProduits(produit,
                                          int.parse("${prdu[index]['id']}"));
                                    }),
                                    child:const Text("mettre a jour")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      color: Colors.grey,
                    );
                  }),
                  itemCount: prdu.length),
            ),
            SizedBox(
              height: _height / 32,
            )
          ],
        ),
      ),
    );
  }
}
