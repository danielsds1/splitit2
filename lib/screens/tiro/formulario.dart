import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/conta.dart';
import 'package:bytebank/models/tiro.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Jogada';
const inset = 2.0;
const _rotuloCampoEscolha = 'Tiro';
const _dicaCampoEscolha = '1';
const _rotuloCampoNivel = 'Nível';
const _dicaCampoNivel = '1';

const _rotuloCampoNome = 'Nome do Jogador';
const _dicaCampoNome = 'Fulano';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTiro extends StatefulWidget {
  final Conta conta;
  const FormularioTiro(this.conta);
  @override
  State<StatefulWidget> createState() {
    return FormularioTiroState();
  }
}

class FormularioTiroState extends State<FormularioTiro> {
  final TextEditingController _controladorCampoNome = TextEditingController();
  TextEditingController _controladorCampoEscolha = TextEditingController();
  int level;
  TextEditingController _controladorCampoNivel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Editor(
        controlador: _controladorCampoNome,
        dica: _dicaCampoNome,
        rotulo: _rotuloCampoNome,
        number: false,
      ),
      Editor(
        controlador: _controladorCampoNivel,
        dica: _dicaCampoNivel,
        rotulo: _rotuloCampoNivel,
        readonly: true,
        number: true,
      ),
      botoesNivel(context),
      Editor(
        dica: _dicaCampoEscolha,
        controlador: _controladorCampoEscolha,
        rotulo: _rotuloCampoEscolha,
        icone: Icons.gamepad,
        number: true,
      ),
      botoesTiro(context),
      ElevatedButton(
        child: Text(_textoBotaoConfirmar),
        onPressed: () => _criaTiro(context, widget.conta),
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

  Widget botoesNivel(BuildContext context) {
    return Container(
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('1'),
            onPressed: () => _selecionaNivel(context, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('2'),
            onPressed: () => _selecionaNivel(context, 2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('3'),
            onPressed: () => _selecionaNivel(context, 3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('4'),
            onPressed: () => _selecionaNivel(context, 4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('5'),
            onPressed: () => _selecionaNivel(context, 5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('6'),
            onPressed: () => _selecionaNivel(context, 6),
          ),
        ),
      ]),
    );
  }

  Widget botoesTiro(BuildContext context) {
    return Container(
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('1'),
            onPressed: () => _selecionaTiro(context, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('2'),
            onPressed: () => _selecionaTiro(context, 2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('3'),
            onPressed: () => _selecionaTiro(context, 3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('4'),
            onPressed: () => _selecionaTiro(context, 4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('5'),
            onPressed: () => _selecionaTiro(context, 5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(inset),
          child: ElevatedButton(
            child: Text('6'),
            onPressed: () => _selecionaTiro(context, 6),
          ),
        ),
      ]),
    );
  }

  void _selecionaNivel(BuildContext context, int level) {
    _controladorCampoNivel.text = level.toString();
  }

  void _selecionaTiro(BuildContext context, int tiro) {
    _controladorCampoEscolha.text = tiro.toString();
  }

  void _criaTiro(BuildContext context, Conta conta) {
    if (conta.participantes > 1) {
      final String nome = _controladorCampoNome.text;
      final int level = int.tryParse(_controladorCampoNivel.text);
      final int tiro = int.tryParse(_controladorCampoEscolha.text);

      if (nome != null && tiro != null && level != null) {
        double valor = participacao(conta, nivel: level, escolha: tiro);
        conta.valorResidual -= valor;
        conta.participantes -= 1;
        final tiroDisparado = Tiro(nome, valor, level, tiro);
        Navigator.pop(context, tiroDisparado);
      }
    } else {
      final tiroDisparado = Tiro(conta.proprietario, conta.valorResidual, 1, 1);
      Navigator.pop(context, tiroDisparado);
    }
  }

  double participacao(Conta conta, {int nivel = 1, int escolha = 1}) {
    var escolhas = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
    switch (nivel) {
      case 2:
        escolhas = [0.8, 0.88, 0.96, 1.04, 1.12, 1.2];
        break;
      case 3:
        escolhas = [0.6, 0.76, 0.92, 1.08, 1.24, 1.4];
        break;
      case 4:
        escolhas = [0.4, 0.64, 0.88, 1.12, 1.36, 1.6];
        break;
      case 5:
        escolhas = [0.2, 0.52, 0.84, 1.16, 1.48, 1.8];
        break;
      case 6:
        escolhas = [0.0, 0.4, 0.8, 1.2, 1.6, 2.0];
        break;
    }
    escolhas.shuffle();
    return toMoney(
        escolhas[escolha - 1] * conta.valorTotal / conta.participantesTotal);
  }

  double toMoney(double entrada) {
    return ((entrada * 100).toInt()).toDouble() / 100;
  }
}
