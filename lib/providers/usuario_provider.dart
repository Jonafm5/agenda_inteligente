import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database_service.dart';
import 'database_provider.dart';

final usuarioProvider = FutureProvider<Usuario?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getUsuario();
});

final temaProvider = Provider<ThemeMode>((ref) {
  final usuario = ref.watch(usuarioProvider);
  return usuario.when(
    data: (u) => u?.tema == 'oscuro' ? ThemeMode.dark : ThemeMode.light,
    loading: () => ThemeMode.light,
    error: (_, __) => ThemeMode.light,
  );
});
