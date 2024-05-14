import 'package:bloco_de_notas/dao/anotacao_dao.dart';
import 'package:bloco_de_notas/model/anotacao.dart';
import 'package:bloco_de_notas/pages/detalhe_anotaocao_page.dart';
import 'package:bloco_de_notas/widgets/conteudo_form_dialog.dart';
import 'package:flutter/material.dart';

class  ListaAnotacaoPage extends  StatefulWidget{

  @override
  _ListaAnotacaoPageState createState() => _ListaAnotacaoPageState();
}

class _ListaAnotacaoPageState extends State <ListaAnotacaoPage>{

  final _anotacoes = <Anotacao>[];
  final _dao = AnotacaoDao();

  var _carregando = false;

  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';
  static const ACAO_VISUALIZAR = 'visualizar';

  @override
  void initstate(){
    super.initState();
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(context),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: _abrirForm,
          child: Icon(Icons.add),
          tooltip: 'Nova Anotação'
      ),
    );
  }
  AppBar _criarAppBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Text('Anotações'),
      centerTitle: false,
    );
  }

  Widget _criarBody(){
    if(_carregando){
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Carregando suas Anotações!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    }

    if(_anotacoes.isEmpty){
      return  const Center(
        child: Text('Tudo certo por aqui!!!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (BuildContext context, int index){
        final anotacao = _anotacoes[index];
        return PopupMenuButton<String>(
          child: ListTile(
            title: Text('${anotacao.id} - ${anotacao.titulo}'
            ),
            subtitle: Text('${anotacao.descricao}'
            ),
          ),
          itemBuilder: (BuildContext context) => criarItensMenuPopUp(),
          onSelected: (String valorSelecionado){
            if (valorSelecionado == ACAO_EDITAR){
              _abrirForm(anotacaoAtual: anotacao);
            }else if (valorSelecionado == ACAO_EXCLUIR){
              _excluir(anotacao);
            }else{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetalheAnotacaoPage(anotacao: anotacao)));
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _anotacoes.length,
    );
  }

  List <PopupMenuEntry<String>> criarItensMenuPopUp(){
    return[
      const PopupMenuItem(
          value: ACAO_EDITAR,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.black),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Editar'),
              )
            ],
          )
      ),
      const PopupMenuItem(
          value: ACAO_EXCLUIR,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Excluir'),
              )
            ],
          )
      )
    ];
  }

  Future _excluir(Anotacao anotacao){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning, color: Colors.red,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Atenção', style: TextStyle(color: Colors.red),),
                )
              ],
            ),
            content: const Text('Tem certeza que deseja excluir esta anotação permanentemente?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    if (anotacao.id == null){
                      return;
                    }
                    _dao.remover(anotacao.id!).then((success){
                      if(success){
                        _atualizarLista();
                      }
                    });
                  },
                  child: const Text ('OK')
              ),
            ],
          );
        }
    );
  }

  void _abrirForm ({Anotacao? anotacaoAtual}){
    final key = GlobalKey <ConteudoFormDialogState>();
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(anotacaoAtual == null ? 'Nova Anotação' : 'Alterar Anotação? ${anotacaoAtual.id}'),
            content: ConteudoFormDialog(key: key, anotacaoAtual: anotacaoAtual),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                  onPressed: (){
                    if(key.currentState!.dadosValidados() && key.currentState != null){
                      setState(() {
                        final novaAnotacao = key.currentState!.novaAnotacao;
                        _dao.salvar(novaAnotacao).then((success){
                          if (success){
                            _atualizarLista();
                          }
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Salvar')
              ),
            ],
          );
        }
    );
  }

  void _atualizarLista () async{
    final anotacoes = await _dao.Lista();
    setState(() {
      _anotacoes.clear();
      if(anotacoes.isNotEmpty){
        _anotacoes.addAll(anotacoes);
      }
    });

  }

}