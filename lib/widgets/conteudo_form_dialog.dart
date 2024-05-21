
import 'package:bloco_de_notas/widgets/conteudo_form_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/anotacao.dart';

class ConteudoFormDialog extends StatefulWidget{
  final Anotacao? anotacaoAtual;

  ConteudoFormDialog({ Key? key, this.anotacaoAtual}) : super(key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();
}

class ConteudoFormDialogState extends State<ConteudoFormDialog>{

  final formKey = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.anotacaoAtual != null){
      tituloController.text = widget.anotacaoAtual!.titulo;
      descricaoController.text = widget.anotacaoAtual!.descricao;
    }
  }

  @override
  Widget build(BuildContext context){
    return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'Informe o título!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (String? valor){
                if (valor == null || valor.isEmpty){
                  return 'Informe a descrição!';
                }
                return null;
              },
            ),
          ],

        )
    );
  }


  bool dadosValidados() => formKey.currentState?.validate() == true;

  Anotacao get novaAnotacao => Anotacao(
    id: widget.anotacaoAtual?.id ?? null,
    titulo: tituloController.text,
    descricao: descricaoController.text

  );
}