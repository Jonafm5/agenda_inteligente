import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/tareas_provider.dart';
import '../../providers/eventos_provider.dart';

class ProductividadScreen extends ConsumerWidget {
  const ProductividadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tareasAsync = ref.watch(tareasProvider);
    final eventosAsync = ref.watch(eventosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Análisis de productividad'),
        centerTitle: true,
      ),
      body: tareasAsync.when(
        data: (tareas) {
          final completadas = tareas
              .where((t) => t.estado == 'completada')
              .length;
          final pendientes = tareas
              .where((t) => t.estado == 'pendiente')
              .length;
          final vencidas = tareas.where((t) => t.estado == 'vencida').length;
          final total = tareas.length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Resumen de tareas
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumen de tareas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatCard(
                            label: 'Total',
                            value: total,
                            color: Colors.deepPurple,
                          ),
                          _StatCard(
                            label: 'Completadas',
                            value: completadas,
                            color: Colors.green,
                          ),
                          _StatCard(
                            label: 'Pendientes',
                            value: pendientes,
                            color: Colors.orange,
                          ),
                          _StatCard(
                            label: 'Vencidas',
                            value: vencidas,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Gráfica de pastel
              if (total > 0)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Distribución de tareas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                if (completadas > 0)
                                  PieChartSectionData(
                                    value: completadas.toDouble(),
                                    color: Colors.green,
                                    title: '$completadas',
                                    radius: 80,
                                  ),
                                if (pendientes > 0)
                                  PieChartSectionData(
                                    value: pendientes.toDouble(),
                                    color: Colors.orange,
                                    title: '$pendientes',
                                    radius: 80,
                                  ),
                                if (vencidas > 0)
                                  PieChartSectionData(
                                    value: vencidas.toDouble(),
                                    color: Colors.red,
                                    title: '$vencidas',
                                    radius: 80,
                                  ),
                              ],
                              centerSpaceRadius: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _Leyenda(color: Colors.green, label: 'Completadas'),
                            const SizedBox(width: 16),
                            _Leyenda(color: Colors.orange, label: 'Pendientes'),
                            const SizedBox(width: 16),
                            _Leyenda(color: Colors.red, label: 'Vencidas'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Prioridades
              if (total > 0)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tareas por prioridad',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _BarraPrioridad(
                          label: 'Alta',
                          valor: tareas
                              .where((t) => t.prioridad == 'alta')
                              .length,
                          total: total,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 8),
                        _BarraPrioridad(
                          label: 'Media',
                          valor: tareas
                              .where((t) => t.prioridad == 'media')
                              .length,
                          total: total,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 8),
                        _BarraPrioridad(
                          label: 'Baja',
                          valor: tareas
                              .where((t) => t.prioridad == 'baja')
                              .length,
                          total: total,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Eventos
              eventosAsync.when(
                data: (eventos) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Eventos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatCard(
                              label: 'Total',
                              value: eventos.length,
                              color: Colors.deepPurple,
                            ),
                            _StatCard(
                              label: 'Regulares',
                              value: eventos
                                  .where((e) => e.subCategoria == 'regular')
                                  .length,
                              color: Colors.blue,
                            ),
                            _StatCard(
                              label: 'Importantes',
                              value: eventos
                                  .where(
                                    (e) => e.subCategoria == 'fecha_importante',
                                  )
                                  .length,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                loading: () => const SizedBox(),
                error: (e, _) => const SizedBox(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class _Leyenda extends StatelessWidget {
  final Color color;
  final String label;

  const _Leyenda({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _BarraPrioridad extends StatelessWidget {
  final String label;
  final int valor;
  final int total;
  final Color color;

  const _BarraPrioridad({
    required this.label,
    required this.valor,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final porcentaje = total > 0 ? valor / total : 0.0;
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(label, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: porcentaje,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('$valor', style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
