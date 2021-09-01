import 'package:bytebank/screens/tiro/inicio.dart';
//import 'package:bytebank/screens/tiro/lista.dart';
import 'package:flutter/material.dart';

void main() => runApp(BoletaRussaApp());

class BoletaRussaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Inicio(),
    );
  }
}
