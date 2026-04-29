import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/tareas_provider.dart';
import '../../providers/database_provider.dart';

class TareasScreen extends ConsumerWidget {
  const TareasScreen({super.key});

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

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'completada':
        return Colors.green;
      case 'vencida':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _iconEstado(String estado) {
    switch (estado) {
      case 'completada':
        return Icons.check_circle;
      case 'vencida':
        return Icons.error_outline;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tareasAsync = ref.watch(tareasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tareas'), centerTitle: true),
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
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tienes tareas pendientes',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tareas.length,
            itemBuilder: (context, index) {
              final tarea = tareas[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
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
                    child: Icon(
                      _iconEstado(tarea.estado),
                      color: _colorEstado(tarea.estado),
                    ),
                  ),
                  title: Text(
                    tarea.titulo,
                    style: TextStyle(
                      decoration: tarea.estado == 'completada'
                          ? TextDecoration.lineThrough
                          : null,
                      color: tarea.estado == 'vencida' ? Colors.red : null,
                    ),
                  ),
                  subtitle: tarea.fechaLimite != null
                      ? Text(
                          'Vence: ${tarea.fechaLimite}'
                          '${tarea.horaLimite != null ? ' a las ${tarea.horaLimite}' : ''}',
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _colorPrioridad(tarea.prioridad),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => context.push('/tarea/editar', extra: tarea),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tarea/crear'),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
