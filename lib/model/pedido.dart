import 'pedido_item.dart';

class Pedido {
  String nombreMesa;
  List<PedidoItem> items;

  Pedido({required this.nombreMesa, List<PedidoItem>? items})
    : items = items ?? [];

  int get numeroProductos => items.fold(0, (sum, it) => sum + it.cantidad);

  double get precioTotal => items.fold(0.0, (sum, it) => sum + it.subtotal);
}
