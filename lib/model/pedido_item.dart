import 'producto.dart';

class PedidoItem {
  final Producto producto;
  int cantidad;

  PedidoItem({
    required this.producto,
    required this.cantidad,
  });

  double get subtotal => producto.precio * cantidad;
}
