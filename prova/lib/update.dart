import 'package:flutter/material.dart';
import 'package:prova/select.dart';

import 'db_helper.dart';

class Update extends StatefulWidget {
  

  Update({Key key, @required this.id}) : super(key: key);
  final int id;

  @override
  _UpdateState createState() => new _UpdateState();

}

class _UpdateState extends State<Update> {

  List arma;

  @override
  void initState(){
    super.initState();
    getArma();
  }

  Future<String> getArma() async {
    final dados = await dbHelper.getId(widget.id);
    setState(() {
     arma = dados; 
    });
    print(arma[0]["ID"]);
    campoMarca.text = arma[0]["MARCA"];
    campoModelo.text = arma[0]["MODELO"];
    campoOrigem.text = arma[0]["ORIGEM"];
    campoCor.text = arma[0]["COR"];
    campoCalibre.text = arma[0]["CALIBRE"];
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
        title: Text("Update"),
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
      _update();
    }
  }

  void _update() async {
    // linha para inserir
    Map<String, dynamic> row = {
      'MARCA' : campoMarca.text,
      'MODELO' : campoModelo.text,
      'ORIGEM' : campoOrigem.text,
      'COR' : campoCor.text,
      'CALIBRE' : campoCalibre.text
    };
    final id = await dbHelper.update(row, widget.id);
    //print('linha inserida id: $id');
    resetCampos();
    Navigator.push(context, MaterialPageRoute(builder: (context) => 
    Select()));
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