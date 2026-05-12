import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/tareas_provider.dart';
import '../../providers/database_provider.dart';
import '../../core/utils/hora_utils.dart';
import '../../providers/usuario_provider.dart';

class TareasScreen extends ConsumerWidget {
  const TareasScreen({super.key});

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

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'completada':
        return const Color(0xFF10B981);
      case 'vencida':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  IconData _iconEstado(String estado) {
    switch (estado) {
      case 'completada':
        return Icons.check_circle_rounded;
      case 'vencida':
        return Icons.error_rounded;
      default:
        return Icons.radio_button_unchecked_rounded;
    }
  }

  int _ordenPrioridad(String prioridad) {
    switch (prioridad) {
      case 'alta':
        return 0;
      case 'media':
        return 1;
      case 'baja':
        return 2;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tareasAsync = ref.watch(tareasProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final usuarioAsync = ref.watch(usuarioProvider);
    final formatoHora = usuarioAsync.when(
      data: (u) => u?.formatoHora ?? '24h',
      loading: () => '24h',
      error: (_, __) => '24h',
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          const SliverAppBar(
            expandedHeight: 0,
            floating: true,
            snap: true,
            title: Text(
              'Tareas',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ],
        body: tareasAsync.when(
          data: (tareas) {
            final ahora = DateTime.now();
            for (final tarea in tareas) {
              if (tarea.estado == 'pendiente' && tarea.fechaLimite != null) {
                final partes = tarea.fechaLimite!.split('/');
                if (partes.length == 3) {
                  final fecha = DateTime(
                    int.parse(partes[2]),
                    int.parse(partes[1]),
                    int.parse(partes[0]),
                  );
                  if (fecha.isBefore(ahora)) {
                    ref
                        .read(databaseProvider)
                        .updateTarea(
                          TareasCompanion(
                            id: drift.Value(tarea.id),
                            usuarioId: drift.Value(tarea.usuarioId),
                            titulo: drift.Value(tarea.titulo),
                            descripcion: drift.Value(tarea.descripcion),
                            fechaLimite: drift.Value(tarea.fechaLimite),
                            horaLimite: drift.Value(tarea.horaLimite),
                            prioridad: drift.Value(tarea.prioridad),
                            estado: const drift.Value('vencida'),
                          ),
                        );
                  }
                }
              }
            }

            if (tareas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 48,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sin tareas pendientes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Toca + para agregar una tarea',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ],
                ),
              );
            }

            // Separar tareas por estado
            final pendientes =
                tareas.where((t) => t.estado == 'pendiente').toList()
                  //agregamos prioridad
                  ..sort(
                    (a, b) => _ordenPrioridad(
                      a.prioridad,
                    ).compareTo(_ordenPrioridad(b.prioridad)),
                  );
            final vencidas = tareas.where((t) => t.estado == 'vencida').toList()
              ..sort(
                (a, b) => _ordenPrioridad(
                  a.prioridad,
                ).compareTo(_ordenPrioridad(b.prioridad)),
              );
            final completadas =
                tareas.where((t) => t.estado == 'completada').toList()..sort(
                  (a, b) => _ordenPrioridad(
                    a.prioridad,
                  ).compareTo(_ordenPrioridad(b.prioridad)),
                );

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                if (vencidas.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Vencidas',
                    count: vencidas.length,
                    color: const Color(0xFFEF4444),
                  ),
                  ...vencidas.map(
                    (t) => _TareaCard(
                      tarea: t,
                      isDark: isDark,
                      colorPrioridad: _colorPrioridad(t.prioridad),
                      colorEstado: _colorEstado(t.estado),
                      iconEstado: _iconEstado(t.estado),
                      ref: ref,
                      formatoHora: formatoHora,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (pendientes.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Pendientes',
                    count: pendientes.length,
                    color: const Color(0xFFF59E0B),
                  ),
                  ...pendientes.map(
                    (t) => _TareaCard(
                      tarea: t,
                      isDark: isDark,
                      colorPrioridad: _colorPrioridad(t.prioridad),
                      colorEstado: _colorEstado(t.estado),
                      iconEstado: _iconEstado(t.estado),
                      ref: ref,
                      formatoHora: formatoHora,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (completadas.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Completadas',
                    count: completadas.length,
                    color: const Color(0xFF10B981),
                  ),
                  ...completadas.map(
                    (t) => _TareaCard(
                      tarea: t,
                      isDark: isDark,
                      colorPrioridad: _colorPrioridad(t.prioridad),
                      colorEstado: _colorEstado(t.estado),
                      iconEstado: _iconEstado(t.estado),
                      ref: ref,
                      formatoHora: formatoHora,
                    ),
                  ),
                ],
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tarea/crear'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TareaCard extends StatelessWidget {
  final Tarea tarea;
  final bool isDark;
  final Color colorPrioridad;
  final Color colorEstado;
  final IconData iconEstado;
  final WidgetRef ref;
  final String formatoHora;

  const _TareaCard({
    required this.tarea,
    required this.isDark,
    required this.colorPrioridad,
    required this.colorEstado,
    required this.iconEstado,
    required this.ref,
    required this.formatoHora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF2D2D4E) : const Color(0xFFEDE9FE),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: GestureDetector(
          onTap: () async {
            final nuevoEstado = tarea.estado == 'completada'
                ? 'pendiente'
                : 'completada';
            await ref
                .read(databaseProvider)
                .updateTarea(
                  TareasCompanion(
                    id: drift.Value(tarea.id),
                    usuarioId: drift.Value(tarea.usuarioId),
                    titulo: drift.Value(tarea.titulo),
                    descripcion: drift.Value(tarea.descripcion),
                    fechaLimite: drift.Value(tarea.fechaLimite),
                    horaLimite: drift.Value(tarea.horaLimite),
                    prioridad: drift.Value(tarea.prioridad),
                    estado: drift.Value(nuevoEstado),
                  ),
                );
          },
          child: Icon(iconEstado, color: colorEstado, size: 26),
        ),
        title: Text(
          tarea.titulo,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            decoration: tarea.estado == 'completada'
                ? TextDecoration.lineThrough
                : null,
            color: tarea.estado == 'completada' ? Colors.grey : null,
          ),
        ),
        subtitle: tarea.fechaLimite != null
            ? Text(
                'Vence: ${tarea.fechaLimite}'
                '${tarea.horaLimite != null ? ' a las ${formatearHora(tarea.horaLimite!, formatoHora)}' : ''}',
                style: TextStyle(
                  fontSize: 12,
                  color: tarea.estado == 'vencida'
                      ? const Color(0xFFEF4444)
                      : Colors.grey[500],
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: colorPrioridad,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: () => context.push('/tarea/editar', extra: tarea),
      ),
    );
  }
}
