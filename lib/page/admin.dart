import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_boutique/database/database.dart';
import 'package:gestion_boutique/database/administrateur.dart';
import 'post_admin.dart';

class SaveAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SaveAdmin();
  }
}

//boutiques variables
String boutique = "";
String licence = "";
//editing controller

TextEditingController nom_admin = TextEditingController();
TextEditingController pass_admin = TextEditingController();

class _SaveAdmin extends State<SaveAdmin> {
  //get sharedpreferences data
  Future getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      boutique = sharedPreferences.getString("boutique").toString();
      licence = sharedPreferences.getString("licence").toString();
    });
  }

  Future insertAdmin(Administrateur ad) async {
    print(ad.toMap());
    try {
      getDatabase();
      //insertion de l'administrateur dans la base de donnees
      ad.insertAdmin(ad);
      //afficher l'adminsitrateur
      //ad.getAdmin();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double textscal = MediaQuery.of(context).textScaleFactor * 20;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        title: Text(
          "AJOUT ADMINSTRATEUR",
          style: GoogleFonts.poppins(fontSize: textscal),
        ),
      ),
      body: Container(
        child: Row(
          children: [
            Container(
              height: _height,
              width: _width / 4,
              color: Colors.grey[300],
              child: Column(
                children: [
                  SizedBox(
                    height: _height / 16,
                  ),
                  Container(
                    height: _height / 8,
                    width: _width,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Center(
                      child: Container(
                          child: Image.asset(
                        "images/shop.png",
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: _height / 16,
                  ),
                  Container(
                    height: _height / 4,
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      children: [
                        Text(
                          boutique,
                          style: GoogleFonts.poppins(fontSize: textscal),
                        ),
                        SizedBox(
                          height: _height / 16,
                        ),
                        Text(
                          licence,
                          style: GoogleFonts.poppins(fontSize: textscal),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: _height,
              width: _width / 2 + _width / 4,
              color: Colors.grey[100],
              child: Center(
                child: Card(
                  elevation: 3,
                  child: Container(
                    height: _height / 2,
                    width: _width / 2,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        SizedBox(
                          height: _height / 20,
                        ),
                        Container(
                            height: _height / 10,
                            width: _width / 8,
                            child: Image.asset("images/admin.png")),
                        SizedBox(
                          height: _height / 20,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          child: TextField(
                            controller: nom_admin,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: "NOM ADMINISTRATEUR",
                                labelStyle:
                                    GoogleFonts.poppins(fontSize: textscal)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            obscuringCharacter: "*",
                            obscureText: true,
                            controller: pass_admin,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                labelText: "MOT DE PASSE",
                                labelStyle:
                                    GoogleFonts.poppins(fontSize: textscal)),
                          ),
                        ),
                        SizedBox(
                          height: _height / 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //insertion admnistrateur
                              insertAdmin(Administrateur(
                                  1, nom_admin.text, pass_admin.text));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Index()), (Route<dynamic> route)=>false);
                            },
                            child: Text("ENREGISTRER"))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
