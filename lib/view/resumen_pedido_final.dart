import 'package:flutter/material.dart';
import '../model/pedido.dart';
import '../model/pedido_item.dart';

class ResumenPedidoView extends StatelessWidget {
  final Pedido pedido;
  const ResumenPedidoView({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mesa / Nombre: ${pedido.nombreMesa}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Productos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Expanded(
              child: ListView.separated(
                itemCount: pedido.items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  final PedidoItem it = pedido.items[i];
                  return ListTile(
                    title: Text(it.producto.nombre),
                    subtitle: Text('${it.producto.precio.toStringAsFixed(2)} € x ${it.cantidad}'),
                    trailing: Text('${it.subtotal.toStringAsFixed(2)} €'),
                  );
                },
              ),
            ),
            const Divider(),
            Text('Total: ${pedido.precioTotal.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
