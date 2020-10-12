import 'package:flutter/material.dart';
import 'package:flutter_app/screens/transferencia/lista.dart';

void main() => runApp(BluBankApp());

class BluBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: ListaTransferencia(),
    );
  }
}
