import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_service.g.dart';

// ── Tablas ────────────────────────────────────────────

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get apellidos => text()();
  TextColumn get fechaNacimiento => text()();
  TextColumn get tema => text().withDefault(const Constant('claro'))();
  TextColumn get primerDia => text().withDefault(const Constant('lunes'))();
  TextColumn get formatoHora => text().withDefault(const Constant('24h'))();
}

class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get fechaLimite => text().nullable()();
  TextColumn get horaLimite => text().nullable()();
  TextColumn get prioridad => text().withDefault(const Constant('media'))();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
}

class Eventos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get fechaInicio => text()();
  TextColumn get horaInicio => text()();
  TextColumn get prioridad => text().withDefault(const Constant('media'))();
  TextColumn get subCategoria =>
      text().withDefault(const Constant('regular'))();
  TextColumn get frecuencia => text().nullable()();
  TextColumn get diasSemana => text().nullable()();
}

// ── Base de datos ─────────────────────────────────────

@DriftDatabase(tables: [Usuarios, Tareas, Eventos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Usuario
  Future<Usuario?> getUsuario() =>
      (select(usuarios)..limit(1)).getSingleOrNull();

  Future<int> insertUsuario(UsuariosCompanion usuario) =>
      into(usuarios).insert(usuario);

  Future<bool> updateUsuario(UsuariosCompanion usuario) =>
      update(usuarios).replace(usuario);

  // Tareas
  Stream<List<Tarea>> watchTareas() => select(tareas).watch();

  Future<int> insertTarea(TareasCompanion tarea) => into(tareas).insert(tarea);

  Future<bool> updateTarea(TareasCompanion tarea) =>
      update(tareas).replace(tarea);

  Future<int> deleteTarea(int id) =>
      (delete(tareas)..where((t) => t.id.equals(id))).go();

  // Eventos
  Stream<List<Evento>> watchEventos() => select(eventos).watch();

  Future<int> insertEvento(EventosCompanion evento) =>
      into(eventos).insert(evento);

  Future<bool> updateEvento(EventosCompanion evento) =>
      update(eventos).replace(evento);

  Future<int> deleteEvento(int id) =>
      (delete(eventos)..where((e) => e.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'agenda_inteligente.db'));
    return NativeDatabase.createInBackground(file);
  });
}
