import 'package:bloco_de_notas/model/anotacao.dart';
import 'package:intl/intl.dart';

class Anotacao{
  static const nome_tabela= 'anotacao';
  static const campo_id =  '_id';
  static const campo_titulo = 'titulo';
  static const campo_descricao = 'descricaos';


  int id;
  String titulo;
  String descricao;

  Anotacao({required this.id, required this.titulo, required this.descricao});

  Map<String, dynamic> toMap() => <String, dynamic>{
    campo_id: id,
    campo_titulo:titulo,
    campo_descricao:descricao,

  };

  factory Anotacao.fromMap(Map<String, dynamic > map) => Anotacao(
    id: map[campo_id] is int ? map[campo_id] : null,
    titulo: map[campo_titulo] is String ? map[campo_titulo] : '',
    descricao: map[campo_descricao] is String ? map[campo_descricao] : ''
    ,
  );
}