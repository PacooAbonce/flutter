import 'package:flutter/material.dart';

import 'credencial_tokens.dart';

/// Superficie de la tarjeta. Los hijos se posicionan en pt del PDF
/// (0,0 = esquina superior izquierda; 153.071 × 243.78) y el conjunto se
/// escala para llenar el ancho disponible respetando la proporción.
class LienzoCredencial extends StatelessWidget {
  const LienzoCredencial({
    super.key,
    required this.children,
    this.radioEsquina = CredencialMedidas.radioEsquina,
    this.colorFondo = Colors.white,
  });

  final List<Widget> children;
  final double radioEsquina;
  final Color colorFondo;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: CredencialMedidas.ancho / CredencialMedidas.alto,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radioEsquina),
          child: SizedBox.fromSize(
            size: CredencialMedidas.tamano,
            child: ColoredBox(
              color: colorFondo,
              child: Stack(children: children),
            ),
          ),
        ),
      ),
    );
  }
}

/// Imagen decorativa exportada del PDF, colocada en su rectángulo original.
class ImagenPt extends StatelessWidget {
  const ImagenPt(this.asset, this.rect, {super.key});

  final String asset;
  final Rect rect;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect,
      child: Image.asset(
        asset,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

/// Una línea de texto centrada horizontalmente entre [izquierda] y
/// [derecha], con el centro de sus mayúsculas en [centroY].
/// Si no cabe, se reduce (nunca se corta ni pasa a otra línea).
class LineaTextoPt extends StatelessWidget {
  const LineaTextoPt(
    this.texto, {
    super.key,
    required this.estilo,
    required this.centroY,
    this.izquierda = 0,
    this.derecha = CredencialMedidas.ancho,
  });

  final String texto;
  final TextStyle estilo;
  final double centroY;
  final double izquierda;
  final double derecha;

  /// Atajo para centrar en una X concreta con un ancho máximo.
  factory LineaTextoPt.enX(
    String texto, {
    Key? key,
    required TextStyle estilo,
    required double centroX,
    required double centroY,
    required double anchoMax,
  }) {
    return LineaTextoPt(
      texto,
      key: key,
      estilo: estilo,
      centroY: centroY,
      izquierda: centroX - anchoMax / 2,
      derecha: centroX + anchoMax / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final alto = estilo.fontSize! * (estilo.height ?? 1.0);
    return Positioned(
      left: izquierda,
      width: derecha - izquierda,
      top: centroY - alto / 2,
      height: alto,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(texto, style: estilo, maxLines: 1, softWrap: false),
        ),
      ),
    );
  }
}

/// Ranura para el broche del portagafete (contorno, sin relleno).
class RanuraPt extends StatelessWidget {
  const RanuraPt(this.rect, {super.key});

  final Rect rect;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(color: CredencialColores.guindaRanura, width: 0.5),
          ),
        ),
      ),
    );
  }
}

/// Línea horizontal para firma.
class LineaFirmaPt extends StatelessWidget {
  const LineaFirmaPt({
    super.key,
    required this.y,
    required this.x0,
    required this.x1,
    this.grosor = 0.5,
    this.color = CredencialColores.guindaRanura,
  });

  final double y;
  final double x0;
  final double x1;
  final double grosor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x0,
      width: x1 - x0,
      top: y - grosor / 2,
      height: grosor,
      child: ColoredBox(color: color),
    );
  }
}
