import 'package:gestion_bar/view/crear_pedido_view.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'crear_pedido_view.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context){
    final pedidos = context.watch<HomeViewmodel>().pedidos;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoPedido = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearPedidoView())
          );
          if (nuevoPedido != null) {
            context.read<HomeViewmodel>().addPedido(nuevoPedido);
          }
        },
        child: Icon(Icons.add),
      ),
      
      body: Center(
        child: ListView.builder(
          itemCount: pedidos.length,
          itemBuilder: (context, index) {
            final pedido = pedidos[index];
            return ListTile(
              title: Text('Mesa: ${pedido.nombreMesa}'),
              subtitle: Text('Productos: ${pedido.numeroProductos} - Total: \$${pedido.precioTotal.toStringAsFixed(2)}'),
            );
          },
        ),
      ),
    );
  }

}