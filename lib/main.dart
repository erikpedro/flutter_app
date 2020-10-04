import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(BluBankApp());

class BluBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
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
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta =
    int.tryParse(_contraladorCompoNumConta.text);
    final double valor =
    double.tryParse(_contraladorCompoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando Transferencia');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
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
          icon: icon != null ? Icon(icon) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasStates();
  }
}


class ListaTransferenciasStates extends State<ListaTransferencia> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencia'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice){
          final transferecia = widget._transferencias[indice];
          return ItemTransferencia(transferecia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        final Future<Transferencia> future = Navigator.push(
            context, MaterialPageRoute(builder: (context) {
          return FormularioTransferencia();
        }));
        future.then((transfereciaRecebida) {
          debugPrint('Chegou no Then do Future');
          debugPrint('$transfereciaRecebida');
          setState(() {
          widget._transferencias.add(transfereciaRecebida);
          });
        });
      },
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
