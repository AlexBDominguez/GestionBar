import 'package:flutter/material.dart';
import '../model/producto.dart';
import '../model/pedido_item.dart';

class SeleccionarProductosView extends StatefulWidget {
  final List<Producto> catalogo;
  const SeleccionarProductosView({super.key, required this.catalogo});

  @override
  State<SeleccionarProductosView> createState() => _SeleccionarProductosViewState();
}

class _SeleccionarProductosViewState extends State<SeleccionarProductosView> {
  final List<PedidoItem> seleccionados = [];

  @override
  Widget build(BuildContext context) {
    final productosDisponibles = widget.catalogo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar productos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productosDisponibles.length,
              itemBuilder: (context, index) {
                final producto = productosDisponibles[index];

                final idx = seleccionados.indexWhere(
                  (it) => it.producto.nombre == producto.nombre,
                );
                final yaSeleccionado = idx != -1;
                final cantidad = yaSeleccionado ? seleccionados[idx].cantidad : 0;

                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text("${producto.precio.toStringAsFixed(2)} €"),
                  trailing: yaSeleccionado? 
                  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (cantidad > 1) {
                                    seleccionados[idx].cantidad--;
                                  } else {
                                    seleccionados.removeAt(idx);
                                  }
                                });
                              },
                            ),
                            Text('$cantidad'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  seleccionados[idx].cantidad++;
                                });
                              },
                            ),
                          ],
                        )
                      : IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              seleccionados.add(PedidoItem(producto: producto, cantidad: 1));
                            });
                          },
                        ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, seleccionados); 
                },
                child: const Text("Confirmar"),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
