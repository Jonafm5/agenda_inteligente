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
    if (fecha != null) setState(() => _fechaNacimiento = fecha);
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1A1A2E), const Color(0xFF2D1B69)]
                        : [const Color(0xFF7C3AED), const Color(0xFF4C1D95)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PEAKLESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu agenda inteligente',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // Formulario
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Crea tu perfil',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Solo necesitamos algunos datos para comenzar',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _nombreCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
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
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1A1A2E)
                                : const Color(0xFFF8F7FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2D2D4E)
                                  : const Color(0xFFDDD6FE),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cake_outlined,
                                color: Colors.grey[500],
                              ),
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
                                      ? Colors.grey[500]
                                      : theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _guardando ? null : _guardar,
                          child: _guardando
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Comenzar'),
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
  }
}
