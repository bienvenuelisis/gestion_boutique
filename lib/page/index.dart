import 'dart:convert';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'admin.dart';
class Boutique extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Boutique();
  }
}

Future getInfos(String licence) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("boutique", _nom.text);
  sharedPreferences.setString("licence", licence);
}

//Controller variables
TextEditingController _nom = TextEditingController();
TextEditingController _password = TextEditingController();

class _Boutique extends State<Boutique> {
  @override
  void initState() {
    //initstate du logiciel
  }

  @override
  Widget build(BuildContext context) {

    Future getConnect() async {
  if (_nom.text == "" || _password.text == "") {
    final snackBar = SnackBar(
      content: const Text('REMPLISSEZ TOUS LES CHAMPS'),
      action: SnackBarAction(
        label: 'Fermer',
        onPressed: () {
          null;
        },
      ),
    );
  } else {
    try {
      var data = await http.post(Uri.parse(url + "/boutique.php"),
          body: {"nom": _nom.text, "password": _password.text});
      var response = data.body;
      if (response == "failed") {
        final snackBar = SnackBar(
          content: const Text('ECHEC DE CONNEXION'),
          action: SnackBarAction(
            label: 'FERMER',
            onPressed: () {
              null;
            },
          ),
        );
      } else {
        String _data = jsonDecode(response);
        print(_data);
        getInfos(_data);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveAdmin()));
      }
    } catch (e) {
      print(e);
    }
  }
}
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double textscal = MediaQuery.of(context).textScaleFactor * 20;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "GESTION BOUTIQUE 2.0.1",
          style: GoogleFonts.poppins(
            fontSize: textscal,
          ),
        ),
      ),
      body: Container(
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
                  Image.asset("images/login.png"),
                  SizedBox(
                    height: _height / 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: TextField(
                      controller: _nom,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: "NOM BOUTIQUE",
                          labelStyle: GoogleFonts.poppins(fontSize: textscal)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      obscuringCharacter: "*",
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: "MOT DE PASSE",
                          labelStyle: GoogleFonts.poppins(fontSize: textscal)),
                    ),
                  ),
                  SizedBox(
                    height: _height / 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getConnect();
                      },
                      child: Text("CONNEXION"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
