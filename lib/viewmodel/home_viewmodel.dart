import '../model/pedido.dart';
import 'package:flutter/material.dart';

class HomeViewmodel extends ChangeNotifier {
  final List<Pedido> _pedidos = [];
  List<Pedido> get pedidos => _pedidos;

  addPedido(Pedido pedido){
    _pedidos.add(pedido);
    notifyListeners();
  }

}
