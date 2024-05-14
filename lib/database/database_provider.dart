
import 'package:bloco_de_notas/model/anotacao.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  static const _dbName = "cadastro_Anotacoes.db";
  static const _dbVersion = 2;

  DatabaseProvider._init();
  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async{
    if(_database == null){
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async{
    String databasePath = await getDatabasesPath();
    String dbPath = '$databasePath/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute(
        '''
      CREATE TABLE ${Anotacao.nome_tabela}(
      ${Anotacao.campo_id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Anotacao.campo_titulo} TEXT NOT NULL,
      ${Anotacao.campo_descricao} TEXT NOT NULL 
      );
      '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async{
  }

  //Função pra quando fechar o app fechar o banco
  Future <void> close() async{
    if(_database != null) {
      await _database!.close();
    }

  }


}