
import 'package:flutter/material.dart';
import 'package:flutter_app/models/transferencia.dart';

import 'formulario.dart';

const _tituloAppBar = 'Transferencia';

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
        title: Text(_tituloAppBar),
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