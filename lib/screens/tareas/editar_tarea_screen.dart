import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/database_provider.dart';

class EditarTareaScreen extends ConsumerStatefulWidget {
  final Tarea tarea;
  const EditarTareaScreen({super.key, required this.tarea});

  @override
  ConsumerState<EditarTareaScreen> createState() => _EditarTareaScreenState();
}

class _EditarTareaScreenState extends ConsumerState<EditarTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descripcionCtrl;
  DateTime? _fechaLimite;
  late String _prioridad;
  late String _estado;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    final t = widget.tarea;
    _tituloCtrl = TextEditingController(text: t.titulo);
    _descripcionCtrl = TextEditingController(text: t.descripcion ?? '');
    _prioridad = t.prioridad;
    _estado = t.estado;

    if (t.fechaLimite != null) {
      final partes = t.fechaLimite!.split('/');
      if (partes.length == 3) {
        _fechaLimite = DateTime(
          int.parse(partes[2]),
          int.parse(partes[1]),
          int.parse(partes[0]),
        );
      }
    }
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaLimite ?? DateTime.now(),
      firstDate: DateTime(2020),
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
      await db.updateTarea(
        TareasCompanion(
          id: drift.Value(widget.tarea.id),
          usuarioId: drift.Value(widget.tarea.usuarioId),
          titulo: drift.Value(_tituloCtrl.text.trim()),
          descripcion: drift.Value(
            _descripcionCtrl.text.trim().isEmpty
                ? null
                : _descripcionCtrl.text.trim(),
          ),
          fechaLimite: drift.Value(
            _fechaLimite != null ? _formatFecha(_fechaLimite!) : null,
          ),
          prioridad: drift.Value(_prioridad),
          estado: drift.Value(_estado),
        ),
      );
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

  Future<void> _eliminar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar esta tarea?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    try {
      final db = ref.read(databaseProvider);
      await db.deleteTarea(widget.tarea.id);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar la tarea')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarea'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: _eliminar,
          ),
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
                            ? 'Sin fecha límite'
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
                  ButtonSegment(value: 'alta', label: Text('Alta')),
                  ButtonSegment(value: 'media', label: Text('Media')),
                  ButtonSegment(value: 'baja', label: Text('Baja')),
                ],
                selected: {_prioridad},
                onSelectionChanged: (v) => setState(() => _prioridad = v.first),
              ),
              const SizedBox(height: 16),
              const Text(
                'Estado',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'pendiente', label: Text('Pendiente')),
                  ButtonSegment(value: 'completada', label: Text('Completada')),
                ],
                selected: {_estado == 'vencida' ? 'pendiente' : _estado},
                onSelectionChanged: (v) => setState(() => _estado = v.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
