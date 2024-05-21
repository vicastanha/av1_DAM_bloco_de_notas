import 'package:bloco_de_notas/pages/filtros_page.dart';
import 'package:flutter/material.dart';
import 'package:bloco_de_notas/pages/lista_page_anotacoes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloco de Notas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      home: ListaAnotacaoPage (),
      routes: {
        FiltroPage.ROUTE_NAME: (BuildContext context) => FiltroPage(),
      },
    );
  }
}

