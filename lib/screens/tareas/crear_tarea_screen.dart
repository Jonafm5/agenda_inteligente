import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/database_provider.dart';
import '../../providers/usuario_provider.dart';

class CrearTareaScreen extends ConsumerStatefulWidget {
  const CrearTareaScreen({super.key});

  @override
  ConsumerState<CrearTareaScreen> createState() => _CrearTareaScreenState();
}

class _CrearTareaScreenState extends ConsumerState<CrearTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  DateTime? _fechaLimite;
  String _prioridad = 'media';
  bool _guardando = false;

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      locale: const Locale('es', 'MX'),
    );
    if (fecha != null) setState(() => _fechaLimite = fecha);
  }

  String _formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    try {
      final db = ref.read(databaseProvider);
      final usuario = await ref.read(usuarioProvider.future);

      await db.insertTarea(
        TareasCompanion.insert(
          usuarioId: usuario!.id,
          titulo: _tituloCtrl.text.trim(),
          descripcion: drift.Value(
            _descripcionCtrl.text.trim().isEmpty
                ? null
                : _descripcionCtrl.text.trim(),
          ),
          fechaLimite: drift.Value(
            _fechaLimite != null ? _formatFecha(_fechaLimite!) : null,
          ),
          prioridad: drift.Value(_prioridad),
        ),
      );
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la tarea')),
        );
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Tarea'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _guardando ? null : _guardar,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'El título es obligatorio'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
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
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _fechaLimite == null
                            ? 'Fecha límite (opcional)'
                            : _formatFecha(_fechaLimite!),
                        style: TextStyle(
                          color: _fechaLimite == null
                              ? Colors.grey[600]
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Prioridad',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'alta',
                    label: Text('Alta'),
                    icon: Icon(Icons.arrow_upward),
                  ),
                  ButtonSegment(
                    value: 'media',
                    label: Text('Media'),
                    icon: Icon(Icons.remove),
                  ),
                  ButtonSegment(
                    value: 'baja',
                    label: Text('Baja'),
                    icon: Icon(Icons.arrow_downward),
                  ),
                ],
                selected: {_prioridad},
                onSelectionChanged: (v) => setState(() => _prioridad = v.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
