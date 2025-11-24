import 'package:flutter/material.dart';
import 'package:gestion_bar/model/pedido.dart';

class CrearPedidoView extends StatelessWidget {
  const CrearPedidoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Pedido')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final nuevoPedido = Pedido(
                  nombreMesa: 'Mesa A',
                  numeroProductos: 3,
                  precioTotal: 45.50,
                );
                Navigator.pop(context, nuevoPedido);
              },
              child: Text('Agregar Pedido'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
