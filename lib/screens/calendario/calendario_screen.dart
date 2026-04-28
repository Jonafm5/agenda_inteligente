import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/database/database_service.dart';
import '../../providers/eventos_provider.dart';

class CalendarioScreen extends ConsumerStatefulWidget {
  const CalendarioScreen({super.key});

  @override
  ConsumerState<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends ConsumerState<CalendarioScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<Evento> _eventosDelDia(List<Evento> todos, DateTime dia) {
    return todos.where((e) {
      final partes = e.fechaInicio.split('/');
      if (partes.length != 3) return false;
      final fecha = DateTime(
        int.parse(partes[2]),
        int.parse(partes[1]),
        int.parse(partes[0]),
      );

      if (e.subCategoria == 'fecha_importante') {
        return fecha.day == dia.day && fecha.month == dia.month;
      }

      if (fecha.isAfter(dia)) return false;

      switch (e.frecuencia) {
        case 'diario':
          return true;
        case 'semanal':
          final dias = e.diasSemana?.split(',') ?? [];
          final nombreDia = _nombreDia(dia.weekday);
          return dias.contains(nombreDia);
        case 'mensual':
          return fecha.day == dia.day;
        default:
          return isSameDay(fecha, dia);
      }
    }).toList();
  }

  String _nombreDia(int weekday) {
    const nombres = {
      1: 'lunes',
      2: 'martes',
      3: 'miercoles',
      4: 'jueves',
      5: 'viernes',
      6: 'sabado',
      7: 'domingo',
    };
    return nombres[weekday] ?? '';
  }

  Color _colorPrioridad(String prioridad) {
    switch (prioridad) {
      case 'alta':
        return Colors.red;
      case 'media':
        return Colors.orange;
      case 'baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventosAsync = ref.watch(eventosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendario'), centerTitle: true),
      body: eventosAsync.when(
        data: (todos) {
          final eventosHoy = _eventosDelDia(todos, _selectedDay);

          return Column(
            children: [
              TableCalendar<Evento>(
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                eventLoader: (day) => _eventosDelDia(todos, day),
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                locale: 'es_MX',
              ),
              const Divider(),
              Expanded(
                child: eventosHoy.isEmpty
                    ? Center(
                        child: Text(
                          'No hay eventos este día',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: eventosHoy.length,
                        itemBuilder: (context, index) {
                          final evento = eventosHoy[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _colorPrioridad(
                                  evento.prioridad,
                                ),
                                radius: 6,
                              ),
                              title: Text(evento.titulo),
                              subtitle: Text(evento.horaInicio),
                              trailing: Icon(
                                evento.subCategoria == 'fecha_importante'
                                    ? Icons.star
                                    : Icons.repeat,
                                color: Colors.grey,
                                size: 18,
                              ),
                              onTap: () {
                                context.push(
                                  '/evento/editar',
                                  extra: evento,
                                ); //On tap
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/evento/crear'),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
