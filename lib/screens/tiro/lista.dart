import 'package:flutter/material.dart';

import 'package:bytebank/models/conta.dart';
import 'package:bytebank/models/tiro.dart';
import 'package:bytebank/screens/tiro/formulario.dart';

const _tituloAppBar = 'Rodadas';

class ListaTiros extends StatefulWidget {
  final List<Tiro> _tiros = [];
  final Conta conta;
  ListaTiros(
    this.conta,
  );
  //final double valorTotal = 250.0;

  @override
  State<StatefulWidget> createState() {
    return ListaTirosState();
  }
}

class ListaTirosState extends State<ListaTiros> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._tiros.length,
        itemBuilder: (context, indice) {
          final tiro = widget._tiros[indice];
          return ItemTiro(tiro);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTiro(widget.conta);
          })).then(
            (tiroRecebido) => _atualiza(tiroRecebido),
          );
        },
      ),
    );
  }

  void _atualiza(Tiro tiroRecebido) {
    if (tiroRecebido != null) {
      setState(() {
        widget._tiros.add(tiroRecebido);
      });
    }
  }
}

class ItemTiro extends StatelessWidget {
  final Tiro _tiro;

  ItemTiro(this._tiro);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_tiro.nome.toString()),
      subtitle: Text(_tiro.valor.toString()),
    ));
  }
}
