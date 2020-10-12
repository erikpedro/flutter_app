
import 'package:flutter/material.dart';
import 'package:flutter_app/components/editor.dart';
import 'package:flutter_app/models/transferencia.dart';

const _tituloAppBar = 'Criando Transferencia';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _rotuloCampoNumeroConta = 'Numero da Conta';
const _dicaCampoNumeroConta = '0000';
const _textoBotao = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _contraladorCompoNumConta =
  TextEditingController();
  final TextEditingController _contraladorCompoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: Column(
          children: [
            Editor(
              controlador: _contraladorCompoNumConta,
              dica: _dicaCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
            ),
            Editor(
              controlador: _contraladorCompoValor,
              dica: _dicaCampoValor,
              icon: Icons.monetization_on,
              rotulo: _rotuloCampoValor,
            ),
            RaisedButton(
              child: Text(_textoBotao),
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