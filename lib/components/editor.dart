import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final bool readonly;
  final bool number;

  Editor({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
    this.readonly,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: number ? TextInputType.number : TextInputType.name,
        readOnly: readonly == null ? false : true,
      ),
    );
  }
}
