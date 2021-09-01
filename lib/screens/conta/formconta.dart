import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/conta.dart';
import 'package:bytebank/screens/tiro/lista.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Jogada';
const inset = 2.0;
const _rotuloCampoValor = 'Valor da Conta';
const _dicaCampoValor = '123,45';
const _rotuloCampoParticipantes = 'Participantes';
const _dicaCampoParticipantes = '10';

const _rotuloCampoNome = 'Nome do Anfitrião';
const _dicaCampoNome = 'Fulano';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioConta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioContaState();
  }
}

class FormularioContaState extends State<FormularioConta> {
  final TextEditingController _controladorCampoNome = TextEditingController();
  TextEditingController _controladorCampoValor = TextEditingController();
  int level;
  TextEditingController _controladorCampoParticipantes =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Editor(
        controlador: _controladorCampoNome,
        dica: _dicaCampoNome,
        rotulo: _rotuloCampoNome,
        icone: Icons.person,
        number: false,
      ),
      Editor(
        controlador: _controladorCampoParticipantes,
        dica: _dicaCampoParticipantes,
        rotulo: _rotuloCampoParticipantes,
        icone: Icons.people,
        number: true,
      ),
      Editor(
        dica: _dicaCampoValor,
        controlador: _controladorCampoValor,
        rotulo: _rotuloCampoValor,
        icone: Icons.monetization_on,
        number: true,
      ),
      ElevatedButton(
        child: Text(_textoBotaoConfirmar),
        onPressed: () => _criaConta(context),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: children2,
          ),
        ));
  }

  void _atualiza(Conta contaRecebida) {
    if (contaRecebida != null) {
      setState(() {
        //contaRecebida.valorResidual;
      });
    }
  }

  void _criaConta(BuildContext context) {
    final String nome = _controladorCampoNome.text;
    final int participantes = int.tryParse(_controladorCampoParticipantes.text);
    final double valor = toMoney(double.tryParse(_controladorCampoValor.text));
    if (nome != null && participantes != null && valor != null) {
      final conta = Conta(nome, valor, valor, participantes, participantes);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ListaTiros(conta);
      })).then(
        (tiroRecebido) => _atualiza(tiroRecebido),
      );

      //Navigator.pop(context, conta);
    }
  }

  double toMoney(double entrada) {
    return ((entrada * 100).toInt()).toDouble() / 100;
  }
}
