import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cepController = new TextEditingController();
  String _log = "";
  String _cidade = "";
  String _uf = "";
  String _ddd = "";

  _buscaCEP() async {
    String cep = cepController.text.toString();
    String urlAPI = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _log = retorno['logradouro'].toString();
      _cidade = retorno['localidade'].toString();
      _uf = retorno['uf'].toString();
      _ddd = retorno['ddd'].toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API CEP'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Digite o CEP',
            ),
            style: TextStyle(fontSize: 20.0),
            controller: cepController,
          ),
          RaisedButton(
            child: Text('Buscar'),
            onPressed: _buscaCEP
          ),
          Text(
            _log,
          ),
          Text(
            _cidade,
          ),
          Text(
            _uf,
          ),
          Text(
            _ddd,
          ),
        ],
      ),
      )
    );
  }
}