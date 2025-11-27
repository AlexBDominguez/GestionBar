import 'package:flutter/material.dart';
import 'view/home_view.dart';
import 'viewmodel/home_viewmodel.dart';
import 'view/resumen_pedido_final.dart';
import 'model/pedido.dart';

void main() {
  final homeViewmodel = HomeViewmodel();
  runApp(MyApp(homeViewmodel: homeViewmodel));
}

class MyApp extends StatelessWidget {
  final HomeViewmodel homeViewmodel;
  const MyApp({super.key, required this.homeViewmodel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Cervecería Folks', homeViewmodel: homeViewmodel),
      routes: {
        '/resumen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Pedido;
          return ResumenPedidoView(pedido: args);
        },
      },
    );
  }
}
