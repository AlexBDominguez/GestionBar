import 'package:flutter/material.dart';
import '../viewmodel/home_viewmodel.dart';
import '../model/pedido.dart';
import 'crear_pedido_view.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final HomeViewmodel homeViewmodel;
  const MyHomePage({super.key, required this.title, required this.homeViewmodel});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pedidos = widget.homeViewmodel.pedidos;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevo = await Navigator.push<Pedido?>(
            context,
            MaterialPageRoute(
              builder: (_) => CrearPedidoView(homeViewmodel: widget.homeViewmodel),
            ),
          );

          // Comprobar mounted antes de setState
          if (!mounted) return;

          if (nuevo != null) {
            widget.homeViewmodel.addPedido(nuevo);
            setState(() {}); // actualizamos vista
          }
        },        
        tooltip: 'Nuevo pedido',
        child: const Icon(Icons.add),
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No hay pedidos'))
          : ListView.separated(
              itemCount: pedidos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final Pedido p = pedidos[i];
                return ListTile(
                  title: Text(p.nombreMesa),
                  subtitle: Text('Productos: ${p.numeroProductos} - Total: ${p.precioTotal.toStringAsFixed(2)} €'),
                );
              },
            ),
    );
  }
}
