import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/database/database_service.dart';
import '../../providers/eventos_provider.dart';
import '../../providers/usuario_provider.dart';

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
        return const Color(0xFFEF4444);
      case 'media':
        return const Color(0xFFF59E0B);
      case 'baja':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventosAsync = ref.watch(eventosProvider);
    final usuarioAsync = ref.watch(usuarioProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primerDia = usuarioAsync.when(
      data: (u) => u?.primerDia == 'domingo'
          ? StartingDayOfWeek.sunday
          : StartingDayOfWeek.monday,
      loading: () => StartingDayOfWeek.monday,
      error: (_, __) => StartingDayOfWeek.monday,
    );

    return Scaffold(
      body: eventosAsync.when(
        data: (todos) {
          final eventosHoy = _eventosDelDia(todos, _selectedDay);

          return NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                expandedHeight: 0,
                floating: true,
                snap: true,
                title: const Text(
                  'PEAKLESS',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    fontSize: 20,
                  ),
                ),
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF7C3AED),
                      radius: 16,
                      child: usuarioAsync.when(
                        data: (u) => Text(
                          u?.nombre.substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        loading: () => const SizedBox(),
                        error: (_, __) => const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            body: Column(
              children: [
                // Calendario
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF2D2D4E)
                          : const Color(0xFFEDE9FE),
                    ),
                  ),
                  child: TableCalendar<Evento>(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2030),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    startingDayOfWeek: primerDia,
                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                      });
                    },
                    eventLoader: (day) => _eventosDelDia(todos, day),
                    calendarStyle: CalendarStyle(
                      markerDecoration: const BoxDecoration(
                        color: Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: TextStyle(
                        color: isDark
                            ? const Color(0xFFA78BFA)
                            : const Color(0xFF7C3AED),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF7C3AED),
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                    locale: 'es_MX',
                  ),
                ),

                // Header de eventos
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Eventos del día',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (eventosHoy.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C3AED),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${eventosHoy.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Lista de eventos
                Expanded(
                  child: eventosHoy.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_available_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Sin eventos este día',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          itemCount: eventosHoy.length,
                          itemBuilder: (context, index) {
                            final evento = eventosHoy[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1A1A2E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF2D2D4E)
                                      : const Color(0xFFEDE9FE),
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _colorPrioridad(evento.prioridad),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                title: Text(
                                  evento.titulo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  evento.horaInicio,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        evento.subCategoria ==
                                            'fecha_importante'
                                        ? const Color(
                                            0xFFF59E0B,
                                          ).withOpacity(0.15)
                                        : const Color(
                                            0xFF7C3AED,
                                          ).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    evento.subCategoria == 'fecha_importante'
                                        ? Icons.star_rounded
                                        : Icons.repeat_rounded,
                                    color:
                                        evento.subCategoria ==
                                            'fecha_importante'
                                        ? const Color(0xFFF59E0B)
                                        : const Color(0xFF7C3AED),
                                    size: 16,
                                  ),
                                ),
                                onTap: () => context.push(
                                  '/evento/editar',
                                  extra: evento,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/evento/crear'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
