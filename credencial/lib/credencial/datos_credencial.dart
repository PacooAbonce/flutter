import 'package:flutter/widgets.dart';

/// Datos variables que se imprimen sobre la plantilla.
///
/// Todo es opcional para poder ver la plantilla vacía (idéntica al PDF)
/// mientras se conecta con la fuente real (SAPI / alta de personal).
@immutable
class DatosCredencial {
  const DatosCredencial({
    this.nombre,
    this.claveIssemym,
    this.adscripcion,
    this.rfc,
    this.curp,
    this.vigencia,
    this.foto,
    this.firmaServidor,
    this.firmaDirector,
    this.qr,
  });

  /// Plantilla sin datos.
  static const vacia = DatosCredencial();

  final String? nombre;
  final String? claveIssemym;
  final String? adscripcion;
  final String? rfc;
  final String? curp;
  final DateTime? vigencia;

  /// Fotografía del servidor público (proporción del marco ≈ 0.83, tipo infantil).
  final ImageProvider? foto;

  /// Imágenes de firma con fondo transparente (PNG).
  final ImageProvider? firmaServidor;
  final ImageProvider? firmaDirector;

  /// Contenido del QR (p. ej. URL de validación). Si es null se deja el
  /// espacio vacío.
  final String? qr;

  DatosCredencial copyWith({
    String? nombre,
    String? claveIssemym,
    String? adscripcion,
    String? rfc,
    String? curp,
    DateTime? vigencia,
    ImageProvider? foto,
    ImageProvider? firmaServidor,
    ImageProvider? firmaDirector,
    String? qr,
  }) {
    return DatosCredencial(
      nombre: nombre ?? this.nombre,
      claveIssemym: claveIssemym ?? this.claveIssemym,
      adscripcion: adscripcion ?? this.adscripcion,
      rfc: rfc ?? this.rfc,
      curp: curp ?? this.curp,
      vigencia: vigencia ?? this.vigencia,
      foto: foto ?? this.foto,
      firmaServidor: firmaServidor ?? this.firmaServidor,
      firmaDirector: firmaDirector ?? this.firmaDirector,
      qr: qr ?? this.qr,
    );
  }
}
