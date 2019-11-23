import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prova/update.dart';
import 'db_helper.dart';

class Select extends StatefulWidget {
  
  
  @override
  _SelectState createState() => new _SelectState();

}

class _SelectState extends State<Select>{
  
  final dbHelper = DbHelper.instance;
  List data;

  @override
  void initState(){
    super.initState();
    print('passou aqui init');
    getDados();
  }

  Future<String> getDados() async {
    final dados = await dbHelper.getAll();
   //List data = "{ID: 2, MARCA: Maverick Carbine, MODELO: M4A1, ANO: 1990, COR: PRETO, CALIBRE: 5.56}";
    print('passou aqui');
    setState(() {
     data = dados; 
    });
    print(data);
    var teste = data[1];
    print(teste);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar (
        title: Text("Lista de Armas")
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i){
          return new ListTile(
            title: new Text(data[i]["MARCA"] + " " + data[i]["MODELO"]),
            subtitle: new Text(data[i]["ORIGEM"] + " " + data[i]["COR"] + " " + data[i]["CALIBRE"]),
            onTap: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                Update(id : data[i]["ID"])));
              },
          );
        },
      ),
    );
  }
}

