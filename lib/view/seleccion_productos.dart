import 'package:flutter/material.dart';
import 'package:gestion_bar/viewModel/home_viewmodel.dart';

class SeleccionProductos extends StatelessWidget {
  final HomeViewmodel homeViewmodel;
  const SeleccionProductos({super.key, required this.homeViewmodel});

  @override
  Widget build(BuildContext context) {
    final productos = homeViewmodel.productos;
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Productos')),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto.nombre),
            subtitle: Text('${producto.precio} €'),
            trailing: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
