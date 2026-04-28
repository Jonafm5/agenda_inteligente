import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/usuario_provider.dart';
import '../../providers/database_provider.dart';

class EditarPerfilScreen extends ConsumerStatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  ConsumerState<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends ConsumerState<EditarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nombreCtrl;
  TextEditingController? _apellidosCtrl;
  DateTime? _fechaNacimiento;
  bool _guardando = false;
  bool _inicializado = false;

  @override
  void dispose() {
    _nombreCtrl?.dispose();
    _apellidosCtrl?.dispose();
    super.dispose();
  }

  void _inicializar(usuario) {
    if (_inicializado) return;
    _nombreCtrl = TextEditingController(text: usuario.nombre);
    _apellidosCtrl = TextEditingController(text: usuario.apellidos);
    final partes = usuario.fechaNacimiento.split('/');
    if (partes.length == 3) {
      _fechaNacimiento = DateTime(
        int.parse(partes[2]),
        int.parse(partes[1]),
        int.parse(partes[0]),
      );
    }
    _inicializado = true;
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento ?? DateTime(2000),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'MX'),
    );
    if (fecha != null) setState(() => _fechaNacimiento = fecha);
  }

  String _formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  Future<void> _guardar(usuario) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);

    try {
      final db = ref.read(databaseProvider);
      await db.updateUsuario(
        UsuariosCompanion(
          id: drift.Value(usuario.id),
          nombre: drift.Value(_nombreCtrl!.text.trim()),
          apellidos: drift.Value(_apellidosCtrl!.text.trim()),
          fechaNacimiento: drift.Value(
            _fechaNacimiento != null
                ? _formatFecha(_fechaNacimiento!)
                : usuario.fechaNacimiento,
          ),
          tema: drift.Value(usuario.tema),
          primerDia: drift.Value(usuario.primerDia),
          formatoHora: drift.Value(usuario.formatoHora),
        ),
      );
      ref.invalidate(usuarioProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar los cambios')),
        );
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioAsync = ref.watch(usuarioProvider);

    return usuarioAsync.when(
      data: (usuario) {
        if (usuario == null) return const SizedBox();
        _inicializar(usuario);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Editar Perfil'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: _guardando ? null : () => _guardar(usuario),
                child: _guardando
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Guardar',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'El nombre es obligatorio'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apellidosCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Apellidos',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Los apellidos son obligatorios'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _seleccionarFecha,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cake_outlined, color: Colors.grey),
                          const SizedBox(width: 12),
                          Text(
                            _fechaNacimiento == null
                                ? 'Fecha de nacimiento'
                                : _formatFecha(_fechaNacimiento!),
                            style: TextStyle(
                              fontSize: 16,
                              color: _fechaNacimiento == null
                                  ? Colors.grey[600]
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
