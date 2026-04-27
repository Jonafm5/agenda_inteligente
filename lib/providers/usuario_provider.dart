import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database_service.dart';
import 'database_provider.dart';

final usuarioProvider = FutureProvider<Usuario?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getUsuario();
});
