import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Medidas tomadas del PDF original (Illustrator), en puntos tipográficos (pt).
///
/// Toda la maquetación trabaja en este sistema de coordenadas: la tarjeta
/// mide 153.071 × 243.78 pt (CR80 vertical, 54 × 86 mm) y se escala al
/// tamaño real en pantalla con un FittedBox. Así las posiciones se copian
/// directo del archivo de diseño sin conversiones.
abstract final class CredencialMedidas {
  static const double ancho = 153.071;
  static const double alto = 243.78;
  static const Size tamano = Size(ancho, alto);

  /// Radio estándar de esquina CR80 (3.18 mm). El PDF viene a sangre recta;
  /// esto solo afecta la vista en pantalla.
  static const double radioEsquina = 9.0;

  /// Puntos por milímetro, por si se requiere convertir medidas de impresión.
  static const double ptPorMm = 72 / 25.4;
}

abstract final class CredencialColores {
  static const guinda = Color(0xFF9E1A3E);
  static const guindaRanura = Color(0xFF851A33);
  static const dorado = Color(0xFFB58A46);
  static const texto = Color(0xFF231F20);
  static const naranjaIssemym = Color(0xFFEA511E);
}

abstract final class CredencialAssets {
  static const _base = 'assets/credencial/';
  static const frenteFondo = '${_base}frente_fondo.png';
  static const frenteEncabezado = '${_base}frente_encabezado.png';
  static const frenteLogoIssemym = '${_base}frente_logo_issemym.png';
  static const frenteCenefa = '${_base}frente_cenefa.png';
  static const frenteHojaIzq = '${_base}frente_hoja_izq.png';
  static const frenteHojaDer = '${_base}frente_hoja_der.png';
  static const reversoFondo = '${_base}reverso_fondo.png';
}

/// Tipografía. El PDF trae el texto convertido a curvas; Montserrat es la
/// alternativa libre más cercana a la geométrica del diseño. Si el área de
/// diseño confirma la familia original (p. ej. Gotham), solo se cambia aquí.
///
/// height: 1.0 + leading uniforme hace que la caja de cada línea mida
/// exactamente fontSize y que el centro de la caja coincida con el centro
/// de las mayúsculas; por eso las posiciones se expresan como "centro de
/// mayúsculas" medido en el PDF.
TextStyle estiloCredencial({
  required double tamano,
  FontWeight peso = FontWeight.w700,
  Color color = CredencialColores.texto,
  double altura = 1.0,
}) {
  return GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: tamano,
      fontWeight: peso,
      color: color,
      height: altura,
      leadingDistribution: TextLeadingDistribution.even,
      letterSpacing: 0,
    ),
  );
}
