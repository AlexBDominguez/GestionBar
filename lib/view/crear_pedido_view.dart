import 'package:flutter/material.dart';
import 'package:gestion_bar/model/pedido.dart';
import 'package:gestion_bar/view/seleccion_productos.dart';
import 'package:gestion_bar/viewModel/home_viewmodel.dart';

class CrearPedidoView extends StatefulWidget {
  final HomeViewmodel homeViewmodel;
  const CrearPedidoView({super.key, required this.homeViewmodel});

  @override
  State<CrearPedidoView> createState() => _CrearPedidoViewState();
}

class _CrearPedidoViewState extends State<CrearPedidoView> {
  final TextEditingController _mesaController = TextEditingController();
  final TextEditingController _productosController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeViewmodel = widget.homeViewmodel;
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _mesaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre de la Mesa',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _productosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número de Productos',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio Total',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final pedido = Pedido(
                  nombreMesa: _mesaController.text,
                  numeroProductos: int.tryParse(_productosController.text) ?? 0,
                  precioTotal: double.tryParse(_precioController.text) ?? 0.0,
                );
                homeViewmodel.addPedido(pedido);
                Navigator.pop(context, pedido);
              },
              child: const Text('Agregar Pedido'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SeleccionProductos(homeViewmodel: homeViewmodel),
                ),
              ),
              child: const Text('Seleccionar Productos'),
            ),
          ],
        ),
      ),
    );
  }
}
