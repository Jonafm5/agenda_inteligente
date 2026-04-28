import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database_service.dart';
import 'database_provider.dart';

final tareasProvider = StreamProvider<List<Tarea>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchTareas();
});
