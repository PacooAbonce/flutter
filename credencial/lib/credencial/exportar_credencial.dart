import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'credencial_tokens.dart';

/// Captura un lado de la credencial envuelto en un RepaintBoundary con [llave]
/// y lo devuelve como PNG al [dpi] indicado (300 dpi = 638 × 1016 px).
Future<Uint8List> exportarCredencialPng(GlobalKey llave, {double dpi = 300}) async {
  final boundary = llave.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final anchoPx = CredencialMedidas.ancho / 72 * dpi;
  final imagen = await boundary.toImage(pixelRatio: anchoPx / boundary.size.width);
  final bytes = await imagen.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}
