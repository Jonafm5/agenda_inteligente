import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/usuario_provider.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/perfil/configurar_perfil_screen.dart';
import '../../screens/calendario/calendario_screen.dart';
import '../../screens/tareas/tareas_screen.dart';
import '../../screens/configuracion/configuracion_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/perfil-setup',
        builder: (context, state) => const ConfigurarPerfilScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/calendario',
            builder: (context, state) => const CalendarioScreen(),
          ),
          GoRoute(
            path: '/tareas',
            builder: (context, state) => const TareasScreen(),
          ),
          GoRoute(
            path: '/configuracion',
            builder: (context, state) => const ConfiguracionScreen(),
          ),
        ],
      ),
    ],
  );
});

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/tareas')) return 1;
    if (location.startsWith('/configuracion')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/calendario');
      case 1:
        context.go('/tareas');
      case 2:
        context.go('/configuracion');
    }
  }
}
