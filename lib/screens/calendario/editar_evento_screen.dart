import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/database_provider.dart';

class EditarEventoScreen extends ConsumerStatefulWidget {
  final Evento evento;
  const EditarEventoScreen({super.key, required this.evento});

  @override
  ConsumerState<EditarEventoScreen> createState() => _EditarEventoScreenState();
}

class _EditarEventoScreenState extends ConsumerState<EditarEventoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descripcionCtrl;

  late DateTime _fechaInicio;
  late TimeOfDay _horaInicio;
  late String _prioridad;
  late String _subCategoria;
  late String _frecuencia;
  late List<String> _diasSeleccionados;
  bool _guardando = false;

  final List<Map<String, String>> _dias = [
    {'key': 'lunes', 'label': 'L'},
    {'key': 'martes', 'label': 'M'},
    {'key': 'miercoles', 'label': 'Mi'},
    {'key': 'jueves', 'label': 'J'},
    {'key': 'viernes', 'label': 'V'},
    {'key': 'sabado', 'label': 'S'},
    {'key': 'domingo', 'label': 'D'},
  ];

  @override
  void initState() {
    super.initState();
    final e = widget.evento;
    _tituloCtrl = TextEditingController(text: e.titulo);
    _descripcionCtrl = TextEditingController(text: e.descripcion ?? '');
    _prioridad = e.prioridad;
    _subCategoria = e.subCategoria;
    _frecuencia = e.frecuencia ?? 'diario';
    _diasSeleccionados = e.diasSemana?.split(',') ?? [];

    final partes = e.fechaInicio.split('/');
    _fechaInicio = DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );

    final horaParts = e.horaInicio.split(':');
    _horaInicio = TimeOfDay(
      hour: int.parse(horaParts[0]),
      minute: int.parse(horaParts[1]),
    );
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
      initialDate: _fechaInicio,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('es', 'MX'),
    );
    if (fecha != null) setState(() => _fechaInicio = fecha);
  }

  Future<void> _seleccionarHora() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: _horaInicio,
    );
    if (hora != null) setState(() => _horaInicio = hora);
  }

  String _formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  String _formatHora(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_subCategoria == 'regular' &&
        _frecuencia == 'semanal' &&
        _diasSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos un día de la semana'),
        ),
      );
      return;
    }

    setState(() => _guardando = true);

    try {
      final db = ref.read(databaseProvider);
      await db.updateEvento(
        EventosCompanion(
          id: drift.Value(widget.evento.id),
          usuarioId: drift.Value(widget.evento.usuarioId),
          titulo: drift.Value(_tituloCtrl.text.trim()),
          descripcion: drift.Value(
            _descripcionCtrl.text.trim().isEmpty
                ? null
                : _descripcionCtrl.text.trim(),
          ),
          fechaInicio: drift.Value(_formatFecha(_fechaInicio)),
          horaInicio: drift.Value(_formatHora(_horaInicio)),
          prioridad: drift.Value(_prioridad),
          subCategoria: drift.Value(_subCategoria),
          frecuencia: drift.Value(
            _subCategoria == 'fecha_importante' ? null : _frecuencia,
          ),
          diasSemana: drift.Value(
            _frecuencia == 'semanal' && _subCategoria == 'regular'
                ? _diasSeleccionados.join(',')
                : null,
          ),
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
        title: const Text('Eliminar evento'),
        content: const Text(
          '¿Estás seguro? Se eliminará este evento y todas sus repeticiones futuras.',
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
      await db.deleteEvento(widget.evento.id);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar el evento')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Evento'),
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
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
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
                            Text(_formatFecha(_fechaInicio)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _seleccionarHora,
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
                              Icons.access_time,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(_formatHora(_horaInicio)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                'Tipo de evento',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'regular', label: Text('Regular')),
                  ButtonSegment(
                    value: 'fecha_importante',
                    label: Text('Fecha importante'),
                  ),
                ],
                selected: {_subCategoria},
                onSelectionChanged: (v) =>
                    setState(() => _subCategoria = v.first),
              ),
              const SizedBox(height: 16),
              if (_subCategoria == 'regular') ...[
                const Text(
                  'Frecuencia',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'diario', label: Text('Diario')),
                    ButtonSegment(value: 'semanal', label: Text('Semanal')),
                    ButtonSegment(value: 'mensual', label: Text('Mensual')),
                  ],
                  selected: {_frecuencia},
                  onSelectionChanged: (v) =>
                      setState(() => _frecuencia = v.first),
                ),
                const SizedBox(height: 16),
                if (_frecuencia == 'semanal') ...[
                  const Text(
                    'Días de la semana',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _dias.map((dia) {
                      final seleccionado = _diasSeleccionados.contains(
                        dia['key'],
                      );
                      return FilterChip(
                        label: Text(dia['label']!),
                        selected: seleccionado,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _diasSeleccionados.add(dia['key']!);
                            } else {
                              _diasSeleccionados.remove(dia['key']!);
                            }
                          });
                        },
                        selectedColor: Colors.deepPurple.withOpacity(0.2),
                        checkmarkColor: Colors.deepPurple,
                      );
                    }).toList(),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
