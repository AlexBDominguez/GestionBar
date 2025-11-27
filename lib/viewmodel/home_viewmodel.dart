import 'package:gestion_bar/model/pedido_item.dart';
import 'package:gestion_bar/model/producto.dart';
import '../model/pedido.dart';

class HomeViewmodel {
  final List<Pedido> _pedidos = [];
  List<Pedido> get pedidos => _pedidos;  

  final List<Producto> _productos = [
    Producto(nombre: 'Paulaner', precio: 2.0),
    Producto(nombre: 'Maredsous', precio: 2.5),
    Producto(nombre: 'Guinness', precio: 2.75),
    Producto(nombre: 'Estrella Galicia', precio: 2.0),
    Producto(nombre: 'Punk IPA', precio: 2.5),
    Producto(nombre: 'Lindemans', precio: 2.7)
  ];

  List<Producto> get productos => _productos;

 HomeViewmodel() {
    _pedidos.addAll([
      Pedido(
        nombreMesa: 'Mesa A',
        items: [
          PedidoItem(producto: productos[0], cantidad: 2),
          PedidoItem(producto: productos[2], cantidad: 1),
        ],
      ),
      Pedido(
        nombreMesa: 'Mesa B',
        items: [
          PedidoItem(producto: productos[1], cantidad: 1),
        ],
      ),
      Pedido(
        nombreMesa: 'Reservado',
        items: [
          PedidoItem(producto: productsafe(3), cantidad: 3),
          PedidoItem(producto: productsafe(5), cantidad: 2),
        ],
      ),
    ]);
  }

  Producto productsafe(int idx) {
    if (idx < 0 || idx >= productos.length) return productos.first;
    return productos[idx];
  }

  void addPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

}