import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    double _preco = 0;

    _recuperaPreco() async {

      var url = Uri.parse("https://blockchain.info/ticker");
      http.Response response = await http.get(url);
      Map<String, dynamic> retorno = json.decode( response.body );

      double precoBitcoin = retorno["BRL"]["sell"];

      setState(() {
        _preco = precoBitcoin;
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preço do Bitcoin"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text("R\$"+_preco.toString(),
                style: TextStyle(
                  fontSize: 40
                ),)
            ),
            Padding(padding: EdgeInsets.only(top: 30),
            child: RaisedButton(
              onPressed: _recuperaPreco,
              color: Colors.orange,
              child: Text("Carregar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
              padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            ),
            )
          ],
        ),
      ),
    );
  }
}


