//informações do detalhe

import 'package:bloco_de_notas/model/anotacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalheAnotacaoPage extends StatefulWidget{
  final Anotacao anotacao;

  // faz o link com outra pagina
  const DetalheAnotacaoPage({Key? key, required this.anotacao}): super(key:key);

  @override
  DetalheAnotacaoPageState createState() => DetalheAnotacaoPageState();


}

class DetalheAnotacaoPageState extends State <DetalheAnotacaoPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Detalhes da Anotação'),
        centerTitle: false,
      ),
      body: _criarBody(),
    );
  }

  Widget _criarBody(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              Campo(descricao: 'Código')

            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Descrição')
            ],
          ),
        ],
      ),
    );
  }
}

class Campo extends  StatelessWidget {
  final String descricao;

  const Campo({Key? key, required this.descricao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Text(descricao,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}

