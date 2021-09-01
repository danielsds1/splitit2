import 'package:bytebank/models/conta.dart';
import 'package:bytebank/screens/conta/formconta.dart';
import 'package:flutter/material.dart';

import 'lista.dart';

//import 'lista.dart';

const _tituloAppBar = 'Boleta Russa';

class Inicio extends StatefulWidget {
  final List<Conta> _conta = [];

  @override
  State<StatefulWidget> createState() {
    return InicioState();
  }
}

class InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Regras:',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      'O anfitrião tocará no botão play, colocar o próprio nome, o valor da conta e quantas ' +
                          'pessoas irão participar.\n' +
                          'Depois clicará no botão +, então cada participante colocará ' +
                          'o próprio nome e vai escolher o nível de risco (1-6) e tirará um palpite (1-6). ' +
                          'O anfitrião paga o que sobrar\n' +
                          'Os valores de risco variam de acordo sobre o valor da sua parte, podendo variar:\n' +
                          'Nível 1: 100% da sua parte\n' +
                          'Nível 6: 0%-200% da sua parte',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget._conta.length,
                itemBuilder: (context, indice) {
                  final conta = widget._conta[indice];
                  return ItemConta(conta);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioConta();
            })).then(
              (contaRecebida) => _atualiza(contaRecebida),
            );
          },
        ),
      ),
    );
  }

  void _atualiza(Conta contaRecebida) {
    if (contaRecebida != null) {
      if (widget._conta.length < 1) {
        setState(() {
          widget._conta.add(contaRecebida);
        });
      } else {
        widget._conta.clear();
        widget._conta.add(contaRecebida);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ListaTiros(contaRecebida);
      })).then(
        (contaResidual) => _atualizaFinal(contaResidual),
      );
    }
  }

  void _atualizaFinal(Conta contaResidual) {
    widget._conta[0].valorResidual = contaResidual.valorResidual;
  }
}

class ItemConta extends StatelessWidget {
  final Conta _conta;

  ItemConta(this._conta);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_conta.proprietario.toString()),
      subtitle: Text(_conta.valorResidual.toString()),
    ));
  }
// Widget build(BuildContext context) {
//   return Card(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         const ListTile(
//           //leading: Icon(Icons.album),
//           title: Text('The Enchanted Nightingale'),
//           subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             TextButton(
//               child: const Text('BUY TICKETS'),
//               onPressed: () {/* ... */},
//             ),
//             const SizedBox(width: 8),
//             TextButton(
//               child: const Text('LISTEN'),
//               onPressed: () {/* ... */},
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
