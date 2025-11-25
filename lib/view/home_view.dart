import 'package:gestion_bar/model/pedido.dart';
import 'package:gestion_bar/view/crear_pedido_view.dart';
import '../viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final HomeViewmodel homeViewmodel;
  const MyHomePage({super.key, required this.homeViewmodel, required this.title});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Pedido> pedidos = [
	Pedido(nombreMesa: 'A', numeroProductos: 2, precioTotal: 30.0),
	Pedido(nombreMesa: 'B', numeroProductos: 1, precioTotal: 15.0),
	Pedido(nombreMesa: 'C', numeroProductos: 4, precioTotal: 60.0),
  ];
  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(title: Text(widget.title)),
	  floatingActionButton: FloatingActionButton(
		onPressed: () async {
		  final nuevoPedido = await Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => CrearPedidoView(homeViewmodel: widget.homeViewmodel)),
		  );
		  if (nuevoPedido != null) {
			setState(() {
			  pedidos.add(nuevoPedido);
			});
		  }
		},
		child: const Icon(Icons.add),
	  ),
	  body: ListView.builder(
		  itemCount: pedidos.length,
		  itemBuilder: (context, index) {
			final pedido = pedidos[index];
			return ListTile(
			  title: Text('Mesa: ${pedido.nombreMesa}'),
			  subtitle: Text(
				'Productos: ${pedido.numeroProductos} - Total: \$${pedido.precioTotal.toStringAsFixed(2)}',
			  ),
			);
		  },
		),
	  );
  }
}