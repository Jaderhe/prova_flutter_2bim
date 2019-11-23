import 'package:flutter/material.dart';

import 'db_helper.dart';

class Insert extends StatefulWidget {

  @override
  _InsertState createState() => new _InsertState();

}

class _InsertState extends State<Insert> {

  @override
  void initState(){
    super.initState();
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool validate = false;
  final dbHelper = DbHelper.instance;
  final campoMarca = new TextEditingController();
  final campoModelo = new TextEditingController();
  final campoOrigem = new TextEditingController();
  final campoCor = new TextEditingController();
  final campoCalibre = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15),
          child: new Form(
            key: _key,
            autovalidate: validate,
            child: buildScreen(context),            
          ),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context){
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Marca'),
          maxLength: 50,
          validator: validateField,
          controller: campoMarca,
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Modelo'),
          maxLength: 50,
          validator: validateField,
          controller: campoModelo,
        ), 
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Origem'),
          maxLength: 50,
          validator: validateField,
          controller: campoOrigem,
        ), 
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Cor'),
          maxLength: 50,
          validator: validateField,
          controller: campoCor,
        ), 
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Calibre'),
          maxLength: 50,
          validator: validateField,
          controller: campoCalibre,
        ), 
        new RaisedButton(
          onPressed: () {sendFormulario(); },
          child: Text('Enviar'),
        ),
      ],
    );
  }

  void sendFormulario() {
    if (_key.currentState.validate()){
      _inserir();
    }
  }

  void _inserir() async {
    // linha para inserir
    Map<String, dynamic> row = {
      'MARCA' : campoMarca.text,
      'MODELO' : campoModelo.text,
      'ORIGEM' : campoOrigem.text,
      'COR' : campoCor.text,
      'CALIBRE' : campoCalibre.text
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
    resetCampos();
  }
  
  String validateField(String value){
    if (value.length == 0){
      return "Informe campo!";
    }
    return null;
  }

  void resetCampos(){
    campoMarca.clear();
    campoModelo.clear();
    campoOrigem.clear();
    campoCor.clear();
    campoCalibre.clear();
  }
  
}