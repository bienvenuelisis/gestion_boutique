import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_boutique/database/produits.dart';

class Insert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Insert();
  }
}

class _Insert extends State<Insert> {
  var nom = TextEditingController();
  var categorie = TextEditingController();
  var prix = TextEditingController();
  var stock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double textscale = MediaQuery.of(context).textScaleFactor * 20;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "AJOUTER DES PRODUITS",
          style: GoogleFonts.poppins(fontSize: textscale),
        ),
      ),
      body: Center(
        child: Container(
          height: _height / 1.8,
          width: _width / 2,
          child: Card(
            elevation: 3,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                children: [
                  SizedBox(
                    height: _height / 128,
                  ),
                  Text(
                    "Ajouter chaque details du produit dans les champs correspondants",
                    style: GoogleFonts.poppins(fontSize: textscale),
                  ),
                  SizedBox(
                    height: _height / 64,
                  ),
                  TextField(
                    controller: nom,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: "NOM PRODUIT",
                        labelStyle: GoogleFonts.poppins(fontSize: textscale)),
                  ),
                  SizedBox(
                    height: _height / 128,
                  ),
                  TextField(
                    controller: categorie,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: "CATEGORIE",
                        labelStyle: GoogleFonts.poppins(fontSize: textscale)),
                  ),
                  SizedBox(
                    height: _height / 128,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: prix,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: "PRIX",
                        labelStyle: GoogleFonts.poppins(fontSize: textscale)),
                  ),
                  SizedBox(
                    height: _height / 128,
                  ),
                  TextField(
                    controller: stock,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: "STOCK",
                        labelStyle: GoogleFonts.poppins(fontSize: textscale)),
                  ),
                  SizedBox(
                    height: _height / 16,
                  ),
                  ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        Produits p = Produits(
                            nom.text,
                            categorie.text,
                            double.parse(prix.text.toString()),
                            int.parse(stock.text.toString()));
                        p.insertProduit(p);
                      });
                    }),
                    child: Text(
                      "ENREGISTRER",
                      style: GoogleFonts.poppins(fontSize: textscale),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
