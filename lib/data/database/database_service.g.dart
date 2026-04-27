// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidosMeta = const VerificationMeta(
    'apellidos',
  );
  @override
  late final GeneratedColumn<String> apellidos = GeneratedColumn<String>(
    'apellidos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaNacimientoMeta = const VerificationMeta(
    'fechaNacimiento',
  );
  @override
  late final GeneratedColumn<String> fechaNacimiento = GeneratedColumn<String>(
    'fecha_nacimiento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temaMeta = const VerificationMeta('tema');
  @override
  late final GeneratedColumn<String> tema = GeneratedColumn<String>(
    'tema',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('claro'),
  );
  static const VerificationMeta _primerDiaMeta = const VerificationMeta(
    'primerDia',
  );
  @override
  late final GeneratedColumn<String> primerDia = GeneratedColumn<String>(
    'primer_dia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('lunes'),
  );
  static const VerificationMeta _formatoHoraMeta = const VerificationMeta(
    'formatoHora',
  );
  @override
  late final GeneratedColumn<String> formatoHora = GeneratedColumn<String>(
    'formato_hora',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('24h'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    apellidos,
    fechaNacimiento,
    tema,
    primerDia,
    formatoHora,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('apellidos')) {
      context.handle(
        _apellidosMeta,
        apellidos.isAcceptableOrUnknown(data['apellidos']!, _apellidosMeta),
      );
    } else if (isInserting) {
      context.missing(_apellidosMeta);
    }
    if (data.containsKey('fecha_nacimiento')) {
      context.handle(
        _fechaNacimientoMeta,
        fechaNacimiento.isAcceptableOrUnknown(
          data['fecha_nacimiento']!,
          _fechaNacimientoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaNacimientoMeta);
    }
    if (data.containsKey('tema')) {
      context.handle(
        _temaMeta,
        tema.isAcceptableOrUnknown(data['tema']!, _temaMeta),
      );
    }
    if (data.containsKey('primer_dia')) {
      context.handle(
        _primerDiaMeta,
        primerDia.isAcceptableOrUnknown(data['primer_dia']!, _primerDiaMeta),
      );
    }
    if (data.containsKey('formato_hora')) {
      context.handle(
        _formatoHoraMeta,
        formatoHora.isAcceptableOrUnknown(
          data['formato_hora']!,
          _formatoHoraMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      apellidos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellidos'],
      )!,
      fechaNacimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_nacimiento'],
      )!,
      tema: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tema'],
      )!,
      primerDia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primer_dia'],
      )!,
      formatoHora: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formato_hora'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nombre;
  final String apellidos;
  final String fechaNacimiento;
  final String tema;
  final String primerDia;
  final String formatoHora;
  const Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.tema,
    required this.primerDia,
    required this.formatoHora,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['apellidos'] = Variable<String>(apellidos);
    map['fecha_nacimiento'] = Variable<String>(fechaNacimiento);
    map['tema'] = Variable<String>(tema);
    map['primer_dia'] = Variable<String>(primerDia);
    map['formato_hora'] = Variable<String>(formatoHora);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      apellidos: Value(apellidos),
      fechaNacimiento: Value(fechaNacimiento),
      tema: Value(tema),
      primerDia: Value(primerDia),
      formatoHora: Value(formatoHora),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      apellidos: serializer.fromJson<String>(json['apellidos']),
      fechaNacimiento: serializer.fromJson<String>(json['fechaNacimiento']),
      tema: serializer.fromJson<String>(json['tema']),
      primerDia: serializer.fromJson<String>(json['primerDia']),
      formatoHora: serializer.fromJson<String>(json['formatoHora']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'apellidos': serializer.toJson<String>(apellidos),
      'fechaNacimiento': serializer.toJson<String>(fechaNacimiento),
      'tema': serializer.toJson<String>(tema),
      'primerDia': serializer.toJson<String>(primerDia),
      'formatoHora': serializer.toJson<String>(formatoHora),
    };
  }

  Usuario copyWith({
    int? id,
    String? nombre,
    String? apellidos,
    String? fechaNacimiento,
    String? tema,
    String? primerDia,
    String? formatoHora,
  }) => Usuario(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    apellidos: apellidos ?? this.apellidos,
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    tema: tema ?? this.tema,
    primerDia: primerDia ?? this.primerDia,
    formatoHora: formatoHora ?? this.formatoHora,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellidos: data.apellidos.present ? data.apellidos.value : this.apellidos,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      tema: data.tema.present ? data.tema.value : this.tema,
      primerDia: data.primerDia.present ? data.primerDia.value : this.primerDia,
      formatoHora: data.formatoHora.present
          ? data.formatoHora.value
          : this.formatoHora,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellidos: $apellidos, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('tema: $tema, ')
          ..write('primerDia: $primerDia, ')
          ..write('formatoHora: $formatoHora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    apellidos,
    fechaNacimiento,
    tema,
    primerDia,
    formatoHora,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.apellidos == this.apellidos &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.tema == this.tema &&
          other.primerDia == this.primerDia &&
          other.formatoHora == this.formatoHora);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> apellidos;
  final Value<String> fechaNacimiento;
  final Value<String> tema;
  final Value<String> primerDia;
  final Value<String> formatoHora;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.tema = const Value.absent(),
    this.primerDia = const Value.absent(),
    this.formatoHora = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String apellidos,
    required String fechaNacimiento,
    this.tema = const Value.absent(),
    this.primerDia = const Value.absent(),
    this.formatoHora = const Value.absent(),
  }) : nombre = Value(nombre),
       apellidos = Value(apellidos),
       fechaNacimiento = Value(fechaNacimiento);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? apellidos,
    Expression<String>? fechaNacimiento,
    Expression<String>? tema,
    Expression<String>? primerDia,
    Expression<String>? formatoHora,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (apellidos != null) 'apellidos': apellidos,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (tema != null) 'tema': tema,
      if (primerDia != null) 'primer_dia': primerDia,
      if (formatoHora != null) 'formato_hora': formatoHora,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? apellidos,
    Value<String>? fechaNacimiento,
    Value<String>? tema,
    Value<String>? primerDia,
    Value<String>? formatoHora,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      tema: tema ?? this.tema,
      primerDia: primerDia ?? this.primerDia,
      formatoHora: formatoHora ?? this.formatoHora,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellidos.present) {
      map['apellidos'] = Variable<String>(apellidos.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<String>(fechaNacimiento.value);
    }
    if (tema.present) {
      map['tema'] = Variable<String>(tema.value);
    }
    if (primerDia.present) {
      map['primer_dia'] = Variable<String>(primerDia.value);
    }
    if (formatoHora.present) {
      map['formato_hora'] = Variable<String>(formatoHora.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellidos: $apellidos, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('tema: $tema, ')
          ..write('primerDia: $primerDia, ')
          ..write('formatoHora: $formatoHora')
          ..write(')'))
        .toString();
  }
}

class $TareasTable extends Tareas with TableInfo<$TareasTable, Tarea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaLimiteMeta = const VerificationMeta(
    'fechaLimite',
  );
  @override
  late final GeneratedColumn<String> fechaLimite = GeneratedColumn<String>(
    'fecha_limite',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prioridadMeta = const VerificationMeta(
    'prioridad',
  );
  @override
  late final GeneratedColumn<String> prioridad = GeneratedColumn<String>(
    'prioridad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('media'),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendiente'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    titulo,
    descripcion,
    fechaLimite,
    prioridad,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tareas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('fecha_limite')) {
      context.handle(
        _fechaLimiteMeta,
        fechaLimite.isAcceptableOrUnknown(
          data['fecha_limite']!,
          _fechaLimiteMeta,
        ),
      );
    }
    if (data.containsKey('prioridad')) {
      context.handle(
        _prioridadMeta,
        prioridad.isAcceptableOrUnknown(data['prioridad']!, _prioridadMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarea(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      fechaLimite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_limite'],
      ),
      prioridad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prioridad'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
    );
  }

  @override
  $TareasTable createAlias(String alias) {
    return $TareasTable(attachedDatabase, alias);
  }
}

class Tarea extends DataClass implements Insertable<Tarea> {
  final int id;
  final int usuarioId;
  final String titulo;
  final String? descripcion;
  final String? fechaLimite;
  final String prioridad;
  final String estado;
  const Tarea({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    this.descripcion,
    this.fechaLimite,
    required this.prioridad,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || fechaLimite != null) {
      map['fecha_limite'] = Variable<String>(fechaLimite);
    }
    map['prioridad'] = Variable<String>(prioridad);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  TareasCompanion toCompanion(bool nullToAbsent) {
    return TareasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      titulo: Value(titulo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      fechaLimite: fechaLimite == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaLimite),
      prioridad: Value(prioridad),
      estado: Value(estado),
    );
  }

  factory Tarea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarea(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      fechaLimite: serializer.fromJson<String?>(json['fechaLimite']),
      prioridad: serializer.fromJson<String>(json['prioridad']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String?>(descripcion),
      'fechaLimite': serializer.toJson<String?>(fechaLimite),
      'prioridad': serializer.toJson<String>(prioridad),
      'estado': serializer.toJson<String>(estado),
    };
  }

  Tarea copyWith({
    int? id,
    int? usuarioId,
    String? titulo,
    Value<String?> descripcion = const Value.absent(),
    Value<String?> fechaLimite = const Value.absent(),
    String? prioridad,
    String? estado,
  }) => Tarea(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    fechaLimite: fechaLimite.present ? fechaLimite.value : this.fechaLimite,
    prioridad: prioridad ?? this.prioridad,
    estado: estado ?? this.estado,
  );
  Tarea copyWithCompanion(TareasCompanion data) {
    return Tarea(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      fechaLimite: data.fechaLimite.present
          ? data.fechaLimite.value
          : this.fechaLimite,
      prioridad: data.prioridad.present ? data.prioridad.value : this.prioridad,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarea(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('prioridad: $prioridad, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    titulo,
    descripcion,
    fechaLimite,
    prioridad,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarea &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.fechaLimite == this.fechaLimite &&
          other.prioridad == this.prioridad &&
          other.estado == this.estado);
}

class TareasCompanion extends UpdateCompanion<Tarea> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> titulo;
  final Value<String?> descripcion;
  final Value<String?> fechaLimite;
  final Value<String> prioridad;
  final Value<String> estado;
  const TareasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.estado = const Value.absent(),
  });
  TareasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String titulo,
    this.descripcion = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.estado = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       titulo = Value(titulo);
  static Insertable<Tarea> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? fechaLimite,
    Expression<String>? prioridad,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (fechaLimite != null) 'fecha_limite': fechaLimite,
      if (prioridad != null) 'prioridad': prioridad,
      if (estado != null) 'estado': estado,
    });
  }

  TareasCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? titulo,
    Value<String?>? descripcion,
    Value<String?>? fechaLimite,
    Value<String>? prioridad,
    Value<String>? estado,
  }) {
    return TareasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      fechaLimite: fechaLimite ?? this.fechaLimite,
      prioridad: prioridad ?? this.prioridad,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fechaLimite.present) {
      map['fecha_limite'] = Variable<String>(fechaLimite.value);
    }
    if (prioridad.present) {
      map['prioridad'] = Variable<String>(prioridad.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('prioridad: $prioridad, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $EventosTable extends Eventos with TableInfo<$EventosTable, Evento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaInicioMeta = const VerificationMeta(
    'fechaInicio',
  );
  @override
  late final GeneratedColumn<String> fechaInicio = GeneratedColumn<String>(
    'fecha_inicio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horaInicioMeta = const VerificationMeta(
    'horaInicio',
  );
  @override
  late final GeneratedColumn<String> horaInicio = GeneratedColumn<String>(
    'hora_inicio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prioridadMeta = const VerificationMeta(
    'prioridad',
  );
  @override
  late final GeneratedColumn<String> prioridad = GeneratedColumn<String>(
    'prioridad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('media'),
  );
  static const VerificationMeta _subCategoriaMeta = const VerificationMeta(
    'subCategoria',
  );
  @override
  late final GeneratedColumn<String> subCategoria = GeneratedColumn<String>(
    'sub_categoria',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('regular'),
  );
  static const VerificationMeta _frecuenciaMeta = const VerificationMeta(
    'frecuencia',
  );
  @override
  late final GeneratedColumn<String> frecuencia = GeneratedColumn<String>(
    'frecuencia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diasSemanaMeta = const VerificationMeta(
    'diasSemana',
  );
  @override
  late final GeneratedColumn<String> diasSemana = GeneratedColumn<String>(
    'dias_semana',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    titulo,
    descripcion,
    fechaInicio,
    horaInicio,
    prioridad,
    subCategoria,
    frecuencia,
    diasSemana,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eventos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Evento> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
        _fechaInicioMeta,
        fechaInicio.isAcceptableOrUnknown(
          data['fecha_inicio']!,
          _fechaInicioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('hora_inicio')) {
      context.handle(
        _horaInicioMeta,
        horaInicio.isAcceptableOrUnknown(data['hora_inicio']!, _horaInicioMeta),
      );
    } else if (isInserting) {
      context.missing(_horaInicioMeta);
    }
    if (data.containsKey('prioridad')) {
      context.handle(
        _prioridadMeta,
        prioridad.isAcceptableOrUnknown(data['prioridad']!, _prioridadMeta),
      );
    }
    if (data.containsKey('sub_categoria')) {
      context.handle(
        _subCategoriaMeta,
        subCategoria.isAcceptableOrUnknown(
          data['sub_categoria']!,
          _subCategoriaMeta,
        ),
      );
    }
    if (data.containsKey('frecuencia')) {
      context.handle(
        _frecuenciaMeta,
        frecuencia.isAcceptableOrUnknown(data['frecuencia']!, _frecuenciaMeta),
      );
    }
    if (data.containsKey('dias_semana')) {
      context.handle(
        _diasSemanaMeta,
        diasSemana.isAcceptableOrUnknown(data['dias_semana']!, _diasSemanaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Evento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Evento(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      fechaInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_inicio'],
      )!,
      horaInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hora_inicio'],
      )!,
      prioridad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prioridad'],
      )!,
      subCategoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_categoria'],
      )!,
      frecuencia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frecuencia'],
      ),
      diasSemana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dias_semana'],
      ),
    );
  }

  @override
  $EventosTable createAlias(String alias) {
    return $EventosTable(attachedDatabase, alias);
  }
}

class Evento extends DataClass implements Insertable<Evento> {
  final int id;
  final int usuarioId;
  final String titulo;
  final String? descripcion;
  final String fechaInicio;
  final String horaInicio;
  final String prioridad;
  final String subCategoria;
  final String? frecuencia;
  final String? diasSemana;
  const Evento({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    this.descripcion,
    required this.fechaInicio,
    required this.horaInicio,
    required this.prioridad,
    required this.subCategoria,
    this.frecuencia,
    this.diasSemana,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['fecha_inicio'] = Variable<String>(fechaInicio);
    map['hora_inicio'] = Variable<String>(horaInicio);
    map['prioridad'] = Variable<String>(prioridad);
    map['sub_categoria'] = Variable<String>(subCategoria);
    if (!nullToAbsent || frecuencia != null) {
      map['frecuencia'] = Variable<String>(frecuencia);
    }
    if (!nullToAbsent || diasSemana != null) {
      map['dias_semana'] = Variable<String>(diasSemana);
    }
    return map;
  }

  EventosCompanion toCompanion(bool nullToAbsent) {
    return EventosCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      titulo: Value(titulo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      fechaInicio: Value(fechaInicio),
      horaInicio: Value(horaInicio),
      prioridad: Value(prioridad),
      subCategoria: Value(subCategoria),
      frecuencia: frecuencia == null && nullToAbsent
          ? const Value.absent()
          : Value(frecuencia),
      diasSemana: diasSemana == null && nullToAbsent
          ? const Value.absent()
          : Value(diasSemana),
    );
  }

  factory Evento.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Evento(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      fechaInicio: serializer.fromJson<String>(json['fechaInicio']),
      horaInicio: serializer.fromJson<String>(json['horaInicio']),
      prioridad: serializer.fromJson<String>(json['prioridad']),
      subCategoria: serializer.fromJson<String>(json['subCategoria']),
      frecuencia: serializer.fromJson<String?>(json['frecuencia']),
      diasSemana: serializer.fromJson<String?>(json['diasSemana']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String?>(descripcion),
      'fechaInicio': serializer.toJson<String>(fechaInicio),
      'horaInicio': serializer.toJson<String>(horaInicio),
      'prioridad': serializer.toJson<String>(prioridad),
      'subCategoria': serializer.toJson<String>(subCategoria),
      'frecuencia': serializer.toJson<String?>(frecuencia),
      'diasSemana': serializer.toJson<String?>(diasSemana),
    };
  }

  Evento copyWith({
    int? id,
    int? usuarioId,
    String? titulo,
    Value<String?> descripcion = const Value.absent(),
    String? fechaInicio,
    String? horaInicio,
    String? prioridad,
    String? subCategoria,
    Value<String?> frecuencia = const Value.absent(),
    Value<String?> diasSemana = const Value.absent(),
  }) => Evento(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    fechaInicio: fechaInicio ?? this.fechaInicio,
    horaInicio: horaInicio ?? this.horaInicio,
    prioridad: prioridad ?? this.prioridad,
    subCategoria: subCategoria ?? this.subCategoria,
    frecuencia: frecuencia.present ? frecuencia.value : this.frecuencia,
    diasSemana: diasSemana.present ? diasSemana.value : this.diasSemana,
  );
  Evento copyWithCompanion(EventosCompanion data) {
    return Evento(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      fechaInicio: data.fechaInicio.present
          ? data.fechaInicio.value
          : this.fechaInicio,
      horaInicio: data.horaInicio.present
          ? data.horaInicio.value
          : this.horaInicio,
      prioridad: data.prioridad.present ? data.prioridad.value : this.prioridad,
      subCategoria: data.subCategoria.present
          ? data.subCategoria.value
          : this.subCategoria,
      frecuencia: data.frecuencia.present
          ? data.frecuencia.value
          : this.frecuencia,
      diasSemana: data.diasSemana.present
          ? data.diasSemana.value
          : this.diasSemana,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Evento(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('horaInicio: $horaInicio, ')
          ..write('prioridad: $prioridad, ')
          ..write('subCategoria: $subCategoria, ')
          ..write('frecuencia: $frecuencia, ')
          ..write('diasSemana: $diasSemana')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    titulo,
    descripcion,
    fechaInicio,
    horaInicio,
    prioridad,
    subCategoria,
    frecuencia,
    diasSemana,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Evento &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.fechaInicio == this.fechaInicio &&
          other.horaInicio == this.horaInicio &&
          other.prioridad == this.prioridad &&
          other.subCategoria == this.subCategoria &&
          other.frecuencia == this.frecuencia &&
          other.diasSemana == this.diasSemana);
}

class EventosCompanion extends UpdateCompanion<Evento> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> titulo;
  final Value<String?> descripcion;
  final Value<String> fechaInicio;
  final Value<String> horaInicio;
  final Value<String> prioridad;
  final Value<String> subCategoria;
  final Value<String?> frecuencia;
  final Value<String?> diasSemana;
  const EventosCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.horaInicio = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.subCategoria = const Value.absent(),
    this.frecuencia = const Value.absent(),
    this.diasSemana = const Value.absent(),
  });
  EventosCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String titulo,
    this.descripcion = const Value.absent(),
    required String fechaInicio,
    required String horaInicio,
    this.prioridad = const Value.absent(),
    this.subCategoria = const Value.absent(),
    this.frecuencia = const Value.absent(),
    this.diasSemana = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       titulo = Value(titulo),
       fechaInicio = Value(fechaInicio),
       horaInicio = Value(horaInicio);
  static Insertable<Evento> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? fechaInicio,
    Expression<String>? horaInicio,
    Expression<String>? prioridad,
    Expression<String>? subCategoria,
    Expression<String>? frecuencia,
    Expression<String>? diasSemana,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (horaInicio != null) 'hora_inicio': horaInicio,
      if (prioridad != null) 'prioridad': prioridad,
      if (subCategoria != null) 'sub_categoria': subCategoria,
      if (frecuencia != null) 'frecuencia': frecuencia,
      if (diasSemana != null) 'dias_semana': diasSemana,
    });
  }

  EventosCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? titulo,
    Value<String?>? descripcion,
    Value<String>? fechaInicio,
    Value<String>? horaInicio,
    Value<String>? prioridad,
    Value<String>? subCategoria,
    Value<String?>? frecuencia,
    Value<String?>? diasSemana,
  }) {
    return EventosCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      horaInicio: horaInicio ?? this.horaInicio,
      prioridad: prioridad ?? this.prioridad,
      subCategoria: subCategoria ?? this.subCategoria,
      frecuencia: frecuencia ?? this.frecuencia,
      diasSemana: diasSemana ?? this.diasSemana,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<String>(fechaInicio.value);
    }
    if (horaInicio.present) {
      map['hora_inicio'] = Variable<String>(horaInicio.value);
    }
    if (prioridad.present) {
      map['prioridad'] = Variable<String>(prioridad.value);
    }
    if (subCategoria.present) {
      map['sub_categoria'] = Variable<String>(subCategoria.value);
    }
    if (frecuencia.present) {
      map['frecuencia'] = Variable<String>(frecuencia.value);
    }
    if (diasSemana.present) {
      map['dias_semana'] = Variable<String>(diasSemana.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventosCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('horaInicio: $horaInicio, ')
          ..write('prioridad: $prioridad, ')
          ..write('subCategoria: $subCategoria, ')
          ..write('frecuencia: $frecuencia, ')
          ..write('diasSemana: $diasSemana')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $TareasTable tareas = $TareasTable(this);
  late final $EventosTable eventos = $EventosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    tareas,
    eventos,
  ];
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nombre,
      required String apellidos,
      required String fechaNacimiento,
      Value<String> tema,
      Value<String> primerDia,
      Value<String> formatoHora,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> apellidos,
      Value<String> fechaNacimiento,
      Value<String> tema,
      Value<String> primerDia,
      Value<String> formatoHora,
    });

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidos => $composableBuilder(
    column: $table.apellidos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tema => $composableBuilder(
    column: $table.tema,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primerDia => $composableBuilder(
    column: $table.primerDia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formatoHora => $composableBuilder(
    column: $table.formatoHora,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidos => $composableBuilder(
    column: $table.apellidos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tema => $composableBuilder(
    column: $table.tema,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primerDia => $composableBuilder(
    column: $table.primerDia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formatoHora => $composableBuilder(
    column: $table.formatoHora,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get apellidos =>
      $composableBuilder(column: $table.apellidos, builder: (column) => column);

  GeneratedColumn<String> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tema =>
      $composableBuilder(column: $table.tema, builder: (column) => column);

  GeneratedColumn<String> get primerDia =>
      $composableBuilder(column: $table.primerDia, builder: (column) => column);

  GeneratedColumn<String> get formatoHora => $composableBuilder(
    column: $table.formatoHora,
    builder: (column) => column,
  );
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
          Usuario,
          PrefetchHooks Function()
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> apellidos = const Value.absent(),
                Value<String> fechaNacimiento = const Value.absent(),
                Value<String> tema = const Value.absent(),
                Value<String> primerDia = const Value.absent(),
                Value<String> formatoHora = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombre: nombre,
                apellidos: apellidos,
                fechaNacimiento: fechaNacimiento,
                tema: tema,
                primerDia: primerDia,
                formatoHora: formatoHora,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String apellidos,
                required String fechaNacimiento,
                Value<String> tema = const Value.absent(),
                Value<String> primerDia = const Value.absent(),
                Value<String> formatoHora = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nombre: nombre,
                apellidos: apellidos,
                fechaNacimiento: fechaNacimiento,
                tema: tema,
                primerDia: primerDia,
                formatoHora: formatoHora,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
      Usuario,
      PrefetchHooks Function()
    >;
typedef $$TareasTableCreateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String titulo,
      Value<String?> descripcion,
      Value<String?> fechaLimite,
      Value<String> prioridad,
      Value<String> estado,
    });
typedef $$TareasTableUpdateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> titulo,
      Value<String?> descripcion,
      Value<String?> fechaLimite,
      Value<String> prioridad,
      Value<String> estado,
    });

class $$TareasTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareasTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prioridad =>
      $composableBuilder(column: $table.prioridad, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$TareasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTable,
          Tarea,
          $$TareasTableFilterComposer,
          $$TareasTableOrderingComposer,
          $$TareasTableAnnotationComposer,
          $$TareasTableCreateCompanionBuilder,
          $$TareasTableUpdateCompanionBuilder,
          (Tarea, BaseReferences<_$AppDatabase, $TareasTable, Tarea>),
          Tarea,
          PrefetchHooks Function()
        > {
  $$TareasTableTableManager(_$AppDatabase db, $TareasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> fechaLimite = const Value.absent(),
                Value<String> prioridad = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => TareasCompanion(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                fechaLimite: fechaLimite,
                prioridad: prioridad,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String titulo,
                Value<String?> descripcion = const Value.absent(),
                Value<String?> fechaLimite = const Value.absent(),
                Value<String> prioridad = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => TareasCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                fechaLimite: fechaLimite,
                prioridad: prioridad,
                estado: estado,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTable,
      Tarea,
      $$TareasTableFilterComposer,
      $$TareasTableOrderingComposer,
      $$TareasTableAnnotationComposer,
      $$TareasTableCreateCompanionBuilder,
      $$TareasTableUpdateCompanionBuilder,
      (Tarea, BaseReferences<_$AppDatabase, $TareasTable, Tarea>),
      Tarea,
      PrefetchHooks Function()
    >;
typedef $$EventosTableCreateCompanionBuilder =
    EventosCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String titulo,
      Value<String?> descripcion,
      required String fechaInicio,
      required String horaInicio,
      Value<String> prioridad,
      Value<String> subCategoria,
      Value<String?> frecuencia,
      Value<String?> diasSemana,
    });
typedef $$EventosTableUpdateCompanionBuilder =
    EventosCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> titulo,
      Value<String?> descripcion,
      Value<String> fechaInicio,
      Value<String> horaInicio,
      Value<String> prioridad,
      Value<String> subCategoria,
      Value<String?> frecuencia,
      Value<String?> diasSemana,
    });

class $$EventosTableFilterComposer
    extends Composer<_$AppDatabase, $EventosTable> {
  $$EventosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get horaInicio => $composableBuilder(
    column: $table.horaInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoria => $composableBuilder(
    column: $table.subCategoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frecuencia => $composableBuilder(
    column: $table.frecuencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diasSemana => $composableBuilder(
    column: $table.diasSemana,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventosTableOrderingComposer
    extends Composer<_$AppDatabase, $EventosTable> {
  $$EventosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaInicio => $composableBuilder(
    column: $table.horaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoria => $composableBuilder(
    column: $table.subCategoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frecuencia => $composableBuilder(
    column: $table.frecuencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diasSemana => $composableBuilder(
    column: $table.diasSemana,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventosTable> {
  $$EventosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get horaInicio => $composableBuilder(
    column: $table.horaInicio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prioridad =>
      $composableBuilder(column: $table.prioridad, builder: (column) => column);

  GeneratedColumn<String> get subCategoria => $composableBuilder(
    column: $table.subCategoria,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frecuencia => $composableBuilder(
    column: $table.frecuencia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diasSemana => $composableBuilder(
    column: $table.diasSemana,
    builder: (column) => column,
  );
}

class $$EventosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventosTable,
          Evento,
          $$EventosTableFilterComposer,
          $$EventosTableOrderingComposer,
          $$EventosTableAnnotationComposer,
          $$EventosTableCreateCompanionBuilder,
          $$EventosTableUpdateCompanionBuilder,
          (Evento, BaseReferences<_$AppDatabase, $EventosTable, Evento>),
          Evento,
          PrefetchHooks Function()
        > {
  $$EventosTableTableManager(_$AppDatabase db, $EventosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String> fechaInicio = const Value.absent(),
                Value<String> horaInicio = const Value.absent(),
                Value<String> prioridad = const Value.absent(),
                Value<String> subCategoria = const Value.absent(),
                Value<String?> frecuencia = const Value.absent(),
                Value<String?> diasSemana = const Value.absent(),
              }) => EventosCompanion(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                fechaInicio: fechaInicio,
                horaInicio: horaInicio,
                prioridad: prioridad,
                subCategoria: subCategoria,
                frecuencia: frecuencia,
                diasSemana: diasSemana,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String titulo,
                Value<String?> descripcion = const Value.absent(),
                required String fechaInicio,
                required String horaInicio,
                Value<String> prioridad = const Value.absent(),
                Value<String> subCategoria = const Value.absent(),
                Value<String?> frecuencia = const Value.absent(),
                Value<String?> diasSemana = const Value.absent(),
              }) => EventosCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                fechaInicio: fechaInicio,
                horaInicio: horaInicio,
                prioridad: prioridad,
                subCategoria: subCategoria,
                frecuencia: frecuencia,
                diasSemana: diasSemana,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventosTable,
      Evento,
      $$EventosTableFilterComposer,
      $$EventosTableOrderingComposer,
      $$EventosTableAnnotationComposer,
      $$EventosTableCreateCompanionBuilder,
      $$EventosTableUpdateCompanionBuilder,
      (Evento, BaseReferences<_$AppDatabase, $EventosTable, Evento>),
      Evento,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$TareasTableTableManager get tareas =>
      $$TareasTableTableManager(_db, _db.tareas);
  $$EventosTableTableManager get eventos =>
      $$EventosTableTableManager(_db, _db.eventos);
}
