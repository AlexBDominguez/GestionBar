import 'package:flutter/material.dart';
import '../viewmodel/home_viewmodel.dart';
import '../model/pedido.dart';
import '../model/pedido_item.dart';
import 'seleccion_productos.dart';


///Vista que permite crear un nuevo pedido, definiendo la mesa/nombre
/// y los productos seleccionados.

class CrearPedidoView extends StatefulWidget {
  final HomeViewmodel homeViewmodel;
  const CrearPedidoView({super.key, required this.homeViewmodel});

  @override
  State<CrearPedidoView> createState() => _CrearPedidoViewState();
}

class _CrearPedidoViewState extends State<CrearPedidoView> {
  final TextEditingController _mesaController = TextEditingController();
  List<PedidoItem> _itemsSeleccionados = [];


  /// Calcula el precio total del pedido basado en los items seleccionados.
  double get _total =>
      _itemsSeleccionados.fold(0.0, (s, it) => s + it.subtotal);
  int get _numeroProductos =>
      _itemsSeleccionados.fold(0, (s, it) => s + it.cantidad);

  @override
  void dispose() {
    _mesaController.dispose();
    super.dispose();
  }

/// Navega a la vista de selección de productos y actualiza los items seleccionados.
  Future<void> _irSeleccionProductos() async {
    final resultado = await Navigator.push<List<PedidoItem>?>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SeleccionarProductosView(catalogo: widget.homeViewmodel.productos),
      ),
    );

///Verifica si la vista sigue montada antes de actualizar el estado.
    if (!mounted) return;

    if (resultado != null) {
      setState(() {
        _itemsSeleccionados = resultado;
      });
    }
  }

  /// Navega a la vista de resumen del pedido.
  Future<void> _verResumen() async {
    /// Validaciones antes de mostrar el resumen.
    if (_itemsSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay productos para mostrar en el resumen.'),
        ),
      );
      return;
    }
    if (_mesaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduce nombre de mesa antes de ver resumen.'),
        ),
      );
      return;
    }

    final pedidoTemp = Pedido(
      nombreMesa: _mesaController.text.trim(),
      items: List.from(_itemsSeleccionados),
    );

    await Navigator.pushNamed(context, '/resumen', arguments: pedidoTemp);

    if (!mounted) return;
    setState(() {});
  }

/// Valida y guarda el pedido, retornándolo a la vista anterior.
  void _guardarPedido() {
    final nombre = _mesaController.text.trim();
    if (nombre.isEmpty) {
      _showAlert('Debes introducir la mesa o nombre del pedido.');
      return;
    }
    if (_itemsSeleccionados.isEmpty) {
      _showAlert('Debes seleccionar al menos un producto.');
      return;
    }

    final pedido = Pedido(
      nombreMesa: nombre,
      items: List.from(_itemsSeleccionados),
    );
    Navigator.pop(context, pedido);
  }

/// Muestra una alerta con el mensaje proporcionado.
  void _showAlert(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validación'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

/// Construye la interfaz de usuario para crear un pedido.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _mesaController,
              decoration: const InputDecoration(
                labelText: 'Mesa / Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Text('Productos seleccionados: $_numeroProductos'),
                ),
                ElevatedButton(
                  onPressed: _irSeleccionProductos,
                  child: const Text('Añadir productos'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _itemsSeleccionados.isEmpty
                  ? const Center(child: Text('No hay productos seleccionados.'))
                  : ListView.separated(
                      itemCount: _itemsSeleccionados.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, i) {
                        final it = _itemsSeleccionados[i];
                        return ListTile(
                          title: Text(it.producto.nombre),
                          subtitle: Text(
                            '${it.producto.precio.toStringAsFixed(2)} € x ${it.cantidad}',
                          ),
                          trailing: Text('${it.subtotal.toStringAsFixed(2)} €'),
                        );
                      },
                    ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    ElevatedButton(
                      onPressed: _verResumen,
                      child: const Text('Ver resumen'),
                    ),
                    ElevatedButton(
                      onPressed: _guardarPedido,
                      child: const Text('Guardar pedido'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Total: ${_total.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
