class Tiro {
  final String nome;
  double valor;
  final int nivel;
  final int escolha;

  Tiro(
    this.nome,
    this.valor,
    this.nivel,
    this.escolha,
  );

  @override
  String toString() {
    return 'Tiro{valor: $valor, escolha: $escolha}';
  }
}
