import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database_service.dart';
import '../../providers/usuario_provider.dart';
import '../../providers/database_provider.dart';

class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuarioAsync = ref.watch(usuarioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración'), centerTitle: true),
      body: usuarioAsync.when(
        data: (usuario) {
          if (usuario == null) return const SizedBox();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Perfil
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Perfil',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () =>
                                context.push('/configuracion/perfil'),
                            child: const Text('Editar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${usuario.nombre} ${usuario.apellidos}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Nacimiento: ${usuario.fechaNacimiento}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Interfaz
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.palette_outlined,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Interfaz',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Tema
                      const Text(
                        'Tema',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'claro',
                            label: Text('Claro'),
                            icon: Icon(Icons.light_mode),
                          ),
                          ButtonSegment(
                            value: 'oscuro',
                            label: Text('Oscuro'),
                            icon: Icon(Icons.dark_mode),
                          ),
                        ],
                        selected: {usuario.tema},
                        onSelectionChanged: (v) async {
                          final db = ref.read(databaseProvider);
                          await db.updateUsuario(
                            UsuariosCompanion(
                              id: drift.Value(usuario.id),
                              nombre: drift.Value(usuario.nombre),
                              apellidos: drift.Value(usuario.apellidos),
                              fechaNacimiento: drift.Value(
                                usuario.fechaNacimiento,
                              ),
                              tema: drift.Value(v.first),
                              primerDia: drift.Value(usuario.primerDia),
                              formatoHora: drift.Value(usuario.formatoHora),
                            ),
                          );
                          ref.invalidate(usuarioProvider);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Primer día
                      const Text(
                        'Primer día de la semana',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'lunes', label: Text('Lunes')),
                          ButtonSegment(
                            value: 'domingo',
                            label: Text('Domingo'),
                          ),
                        ],
                        selected: {usuario.primerDia},
                        onSelectionChanged: (v) async {
                          final db = ref.read(databaseProvider);
                          await db.updateUsuario(
                            UsuariosCompanion(
                              id: drift.Value(usuario.id),
                              nombre: drift.Value(usuario.nombre),
                              apellidos: drift.Value(usuario.apellidos),
                              fechaNacimiento: drift.Value(
                                usuario.fechaNacimiento,
                              ),
                              tema: drift.Value(usuario.tema),
                              primerDia: drift.Value(v.first),
                              formatoHora: drift.Value(usuario.formatoHora),
                            ),
                          );
                          ref.invalidate(usuarioProvider);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Formato de hora
                      const Text(
                        'Formato de hora',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: '24h', label: Text('24 horas')),
                          ButtonSegment(value: '12h', label: Text('12 horas')),
                        ],
                        selected: {usuario.formatoHora},
                        onSelectionChanged: (v) async {
                          final db = ref.read(databaseProvider);
                          await db.updateUsuario(
                            UsuariosCompanion(
                              id: drift.Value(usuario.id),
                              nombre: drift.Value(usuario.nombre),
                              apellidos: drift.Value(usuario.apellidos),
                              fechaNacimiento: drift.Value(
                                usuario.fechaNacimiento,
                              ),
                              tema: drift.Value(usuario.tema),
                              primerDia: drift.Value(usuario.primerDia),
                              formatoHora: drift.Value(v.first),
                            ),
                          );
                          ref.invalidate(usuarioProvider);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Análisis de productividad
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.bar_chart,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Análisis de productividad'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/configuracion/productividad'),
                ),
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
