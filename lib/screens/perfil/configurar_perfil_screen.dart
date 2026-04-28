import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/database/database_service.dart';
import '../../providers/database_provider.dart';

class ConfigurarPerfilScreen extends ConsumerStatefulWidget {
  const ConfigurarPerfilScreen({super.key});

  @override
  ConsumerState<ConfigurarPerfilScreen> createState() =>
      _ConfigurarPerfilScreenState();
}

class _ConfigurarPerfilScreenState
    extends ConsumerState<ConfigurarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _apellidosCtrl = TextEditingController();
  DateTime? _fechaNacimiento;
  bool _guardando = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidosCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final hoy = DateTime.now();
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime(hoy.year - 18, hoy.month, hoy.day),
      firstDate: DateTime(1920),
      lastDate: hoy,
      locale: const Locale('es', 'MX'),
    );
    if (fecha != null) {
      setState(() => _fechaNacimiento = fecha);
    }
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fechaNacimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona tu fecha de nacimiento'),
        ),
      );
      return;
    }

    setState(() => _guardando = true);

    try {
      final db = ref.read(databaseProvider);
      await db.insertUsuario(
        UsuariosCompanion.insert(
          nombre: _nombreCtrl.text.trim(),
          apellidos: _apellidosCtrl.text.trim(),
          fechaNacimiento:
              '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/'
              '${_fechaNacimiento!.month.toString().padLeft(2, '0')}/'
              '${_fechaNacimiento!.year}',
        ),
      );
      if (mounted) context.go('/calendario');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al guardar el perfil. Intenta de nuevo.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Bienvenido',
                  style: tema.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cuéntanos un poco sobre ti para comenzar',
                  style: tema.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),
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
                              : '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/'
                                    '${_fechaNacimiento!.month.toString().padLeft(2, '0')}/'
                                    '${_fechaNacimiento!.year}',
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
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _guardando ? null : _guardar,
                    child: _guardando
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Comenzar',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
