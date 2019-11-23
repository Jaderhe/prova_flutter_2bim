import 'package:flutter/material.dart';
import 'package:prova/select.dart';

import 'db_helper.dart';
import 'insert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final dbHelper = DbHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Armas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              child: Text('Listar', style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            ),RaisedButton(
              child: Text('Inserir', style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir();},
            ),
            RaisedButton(
              child: Text('Apagar último', style: TextStyle(fontSize: 20),),
              onPressed: () {_deleteLast();},
            ),
          ],
        ),
      ),
    );
  }
  
  void _inserir() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => 
    Insert()));
    
    
    // linha para inserir
    
    /*
    Map<String, dynamic> row = {
      'MARCA' : 'Maverick Carbine',
      'MODELO' : 'M4A1',
      'ORIGEM' : 'USA',
      'COR' : 'PRETO',
      'CALIBRE' : '5.56'
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
    */
  }

  void _consultar() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => 
    Select()));
    
    /*
    final linhas = await dbHelper.getAll();
    print('===========================Todas Pessoas===================');
    linhas.forEach( (l) => print(l) );*/
  }

  void deleteAll() async {
      await dbHelper.removeAll();
  }

  void _deleteLast() async {
    final arma = await dbHelper.getLast();
    final id = arma['ID'];
    await dbHelper.removeLast(id);
  }
}
