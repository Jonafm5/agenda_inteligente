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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          const SliverAppBar(
            expandedHeight: 0,
            floating: true,
            snap: true,
            title: Text(
              'Configuración',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ],
        body: usuarioAsync.when(
          data: (usuario) {
            if (usuario == null) return const SizedBox();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Perfil
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [const Color(0xFF1A1A2E), const Color(0xFF2D1B69)]
                          : [const Color(0xFF7C3AED), const Color(0xFF4C1D95)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          usuario.nombre.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${usuario.nombre} ${usuario.apellidos}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Nac. ${usuario.fechaNacimiento}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.push('/configuracion/perfil'),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sección Apariencia
                _SectionTitle(title: 'Apariencia'),
                const SizedBox(height: 12),

                _ConfigCard(
                  isDark: isDark,
                  child: Column(
                    children: [
                      _ConfigItem(
                        icon: Icons.dark_mode_outlined,
                        title: 'Tema',
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'claro',
                              label: Text('Claro'),
                              icon: Icon(Icons.light_mode, size: 16),
                            ),
                            ButtonSegment(
                              value: 'oscuro',
                              label: Text('Oscuro'),
                              icon: Icon(Icons.dark_mode, size: 16),
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
                      ),
                      _Divider(isDark: isDark),
                      _ConfigItem(
                        icon: Icons.calendar_today_outlined,
                        title: 'Primer día',
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'lunes', label: Text('Lunes')),
                            ButtonSegment(value: 'domingo', label: Text('Dom')),
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
                      ),
                      _Divider(isDark: isDark),
                      _ConfigItem(
                        icon: Icons.access_time_outlined,
                        title: 'Formato hora',
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: '24h', label: Text('24h')),
                            ButtonSegment(value: '12h', label: Text('12h')),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sección Productividad
                _SectionTitle(title: 'Estadísticas'),
                const SizedBox(height: 12),

                _ConfigCard(
                  isDark: isDark,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bar_chart_rounded,
                        color: Color(0xFF7C3AED),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Análisis de productividad',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Ver estadísticas y gráficas',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => context.push('/configuracion/productividad'),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }
}

class _ConfigCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  const _ConfigCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2D2D4E) : const Color(0xFFEDE9FE),
        ),
      ),
      child: child,
    );
  }
}

class _ConfigItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const _ConfigItem({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF7C3AED), size: 18),
          ),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          child,
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: isDark ? const Color(0xFF2D2D4E) : const Color(0xFFEDE9FE),
      height: 1,
    );
  }
}
