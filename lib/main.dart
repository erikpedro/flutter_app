import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(BluBankApp());

class BluBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _contraladorCompoNumConta =
      TextEditingController();
  final TextEditingController _contraladorCompoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferencia'),
        ),
        body: Column(
          children: [
            Editor(
              controlador: _contraladorCompoNumConta,
              dica: '0000',
              rotulo: 'Número da Conta',
            ),
            Editor(
              controlador: _contraladorCompoValor,
              dica: 'Valor',
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(),
            )
          ],
        ));
  }

  void _criaTransferencia() {
    final int numeroConta =
    int.tryParse(_contraladorCompoNumConta.text);
    final double valor =
    double.tryParse(_contraladorCompoValor.text);
    if (numeroConta != null && valor != null) {
      final tranferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$tranferenciaCriada');
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icon;

  Editor({this.controlador, this.rotulo, this.dica, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon !=null ? Icon(icon) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencia'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(250.00, 1001)),
          ItemTransferencia(Transferencia(150.00, 2002)),
          ItemTransferencia(Transferencia(350.00, 3004)),
          ItemTransferencia(Transferencia(1250.00, 5005))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }

  ItemTransferencia(this._transferencia);
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
