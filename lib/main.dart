import 'package:flutter/material.dart';
import 'package:gestion_bar/view/resumen_pedido_final.dart';
import 'view/home_view.dart';
import 'viewmodel/home_viewmodel.dart';
import 'model/pedido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final homeVm = HomeViewmodel();

    return MaterialApp(
      title: 'Gestion Bar - MVVM',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 245, 142, 57),
      ),
      home: MyHomePage(title: 'Cervecería Folks', homeViewmodel: homeVm),

      routes: {
        '/resumen': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is Pedido) {
            return ResumenPedidoView(pedido: args);
          } else {
            return Scaffold(
              appBar: AppBar(title: const Text('Resumen')),
              body: const Center(child: Text('No se encontró el pedido para mostrar')),
            );
          }
        },
      },
    );
  }
}
