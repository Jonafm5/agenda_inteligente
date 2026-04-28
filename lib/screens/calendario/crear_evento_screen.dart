import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/database_provider.dart';
import '../../providers/usuario_provider.dart';

class CrearEventoScreen extends ConsumerStatefulWidget {
  const CrearEventoScreen({super.key});

  @override
  ConsumerState<CrearEventoScreen> createState() => _CrearEventoScreenState();
}

class _CrearEventoScreenState extends ConsumerState<CrearEventoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  DateTime? _fechaInicio;
  TimeOfDay? _horaInicio;
  String _prioridad = 'media';
  String _subCategoria = 'regular';
  String _frecuencia = 'diario';
  bool _guardando = false;

  final List<String> _diasSeleccionados = [];
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
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('es', 'MX'),
    );
    if (fecha != null) setState(() => _fechaInicio = fecha);
  }

  Future<void> _seleccionarHora() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) setState(() => _horaInicio = hora);
  }

  String _formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  String _formatHora(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fechaInicio == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona la fecha del evento')),
      );
      return;
    }
    if (_horaInicio == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona la hora del evento')),
      );
      return;
    }
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
      final usuario = await ref.read(usuarioProvider.future);

      await db.insertEvento(
        EventosCompanion.insert(
          usuarioId: usuario!.id,
          titulo: _tituloCtrl.text.trim(),
          descripcion: drift.Value(
            _descripcionCtrl.text.trim().isEmpty
                ? null
                : _descripcionCtrl.text.trim(),
          ),
          fechaInicio: _formatFecha(_fechaInicio!),
          horaInicio: _formatHora(_horaInicio!),
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
          const SnackBar(content: Text('Error al guardar el evento')),
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
        title: const Text('Nuevo Evento'),
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
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),

              // Fecha y hora
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
                            Text(
                              _fechaInicio == null
                                  ? 'Fecha'
                                  : _formatFecha(_fechaInicio!),
                              style: TextStyle(
                                color: _fechaInicio == null
                                    ? Colors.grey[600]
                                    : Colors.black,
                              ),
                            ),
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
                            Text(
                              _horaInicio == null
                                  ? 'Hora'
                                  : _formatHora(_horaInicio!),
                              style: TextStyle(
                                color: _horaInicio == null
                                    ? Colors.grey[600]
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Prioridad
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
              const SizedBox(height: 16),

              // Subcategoría
              const Text(
                'Tipo de evento',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'regular',
                    label: Text('Regular'),
                    icon: Icon(Icons.repeat),
                  ),
                  ButtonSegment(
                    value: 'fecha_importante',
                    label: Text('Fecha importante'),
                    icon: Icon(Icons.star),
                  ),
                ],
                selected: {_subCategoria},
                onSelectionChanged: (v) =>
                    setState(() => _subCategoria = v.first),
              ),
              const SizedBox(height: 16),

              // Frecuencia (solo para regular)
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

                // Días de la semana (solo para semanal)
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
