
import 'package:bloco_de_notas/database/database_provider.dart';
import 'package:bloco_de_notas/model/anotacao.dart';

class AnotacaoDao{
  final dbProvider = DatabaseProvider.instance;

  Future<bool> salvar(Anotacao anotacao) async{
    final db = await dbProvider.database;
    final valores = anotacao.toMap();
    if(anotacao.id == null){
      anotacao.id = await db.insert(Anotacao.nome_tabela, valores);
      return true;
    }else {
      final registrosAtualizados = await db.update(
          Anotacao.nome_tabela, valores,
          where: '${Anotacao.campo_id} = ?',
          whereArgs: [anotacao.id]);

      return registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async{
    final db = await dbProvider.database;
    final removerRegistro = await db.delete(Anotacao.nome_tabela,
        where: '${Anotacao.campo_id} = ?', whereArgs: [id]);

    return removerRegistro > 0;
  }

  Future<List<Anotacao>> Lista({
    String filtro = '',
    String campoOrdenacao = Anotacao.campo_id,
    bool usarOrdemDecrescente = false,
  }) async{
    final db = await dbProvider.database;

    String? where;
    if(filtro.isNotEmpty){
      where = "UPPER(${Anotacao.campo_descricao}) LIKE '${filtro.toUpperCase()}%'";
    }

    var orderBy= campoOrdenacao;
    if (usarOrdemDecrescente){
      orderBy += ' DESC';
    }

    final resultado = await db.query(Anotacao.nome_tabela,
      columns: [Anotacao.campo_id, Anotacao.campo_titulo, Anotacao.campo_descricao],
      where: where,
      orderBy: orderBy,
    );
    return resultado.map((m) => Anotacao.fromMap(m)).toList();
  }
}