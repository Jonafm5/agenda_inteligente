import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database_service.dart';
import 'database_provider.dart';

final eventosProvider = StreamProvider<List<Evento>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchEventos();
});
