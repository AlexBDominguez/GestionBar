import 'package:gestion_bar/model/producto.dart';
import '../model/pedido.dart';
import 'package:flutter/material.dart';

class HomeViewmodel extends ChangeNotifier {
  final List<Pedido> _pedidos = [];
  List<Pedido> get pedidos => _pedidos;

  addPedido(Pedido pedido){
    _pedidos.add(pedido);
    notifyListeners();
  }

  final List<Producto> _productos = [
    Producto(nombre: 'Paulaner', precio: 2.0),
    Producto(nombre: 'Maredsous', precio: 2.5),
    Producto(nombre: 'Guinness', precio: 2.75),
    Producto(nombre: 'Estrella Galicia', precio: 2.0),
    Producto(nombre: 'Punk IPA', precio: 2.5),
    Producto(nombre: 'Lindemans', precio: 2.7)
  ];

  List<Producto> get productos => _productos;

}
