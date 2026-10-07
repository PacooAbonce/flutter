import 'package:flutter/material.dart';

import 'credencial_tokens.dart';
import 'datos_credencial.dart';
import 'lienzo_credencial.dart';

/// Frente del gafete. Coordenadas en pt medidas sobre el PDF.
class CredencialFrente extends StatelessWidget {
  const CredencialFrente({super.key, this.datos = DatosCredencial.vacia});

  final DatosCredencial datos;

  // ---- Geometría (pt) -------------------------------------------------
  static const rectRanura = Rect.fromLTRB(67.9, 8.6, 85.75, 15.0);
  static const rectEncabezado = Rect.fromLTRB(6, 21, 147, 35.5);
  static const rectFoto = Rect.fromLTRB(53.85, 44.25, 99.9, 99.9);
  static const grosorMarcoFoto = 0.85;
  // Franja del nombre: píldora + hojas. La píldora mide 55.25 pt como en el
  // diseño y crece (centrada, arrastrando las hojas) si el nombre no cabe.
  static const topNombre = 138.5;
  static const altoPildora = 10.625;
  static const anchoPildoraDiseno = 55.25;
  static const anchoPildoraMax = 112.0;
  static const tamanoHoja = Size(8.5, 9.2);
  static const centroClave = 160.9;
  static const centroAdscripcion = 182.3;
  static const rectLogoIssemym = Rect.fromLTRB(52, 202, 100, 215.5);
  static const rectCenefa = Rect.fromLTRB(14.5, 226, 138.5, 237.5);

  // ---- Estilos ---------------------------------------------------------
  static final _estiloDato = estiloCredencial(tamano: 6.1);
  static final _estiloAdscripcion = estiloCredencial(tamano: 6.1, altura: 1.15);
  static final _estiloNombre = estiloCredencial(
    tamano: 5.6,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return LienzoCredencial(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage(CredencialAssets.frenteFondo),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.medium,
          ),
        ),
        const RanuraPt(rectRanura),
        const ImagenPt(CredencialAssets.frenteEncabezado, rectEncabezado),

        Positioned.fromRect(rect: rectFoto, child: _MarcoFoto(foto: datos.foto)),

        Positioned(
          left: 6,
          right: 6,
          top: topNombre,
          height: altoPildora,
          child: _FranjaNombre(nombre: datos.nombre, estilo: _estiloNombre),
        ),

        // Sin dato se muestra el rótulo del PDF, para que la plantilla
        // vacía se vea idéntica al diseño.
        LineaTextoPt(
          datos.claveIssemym ?? 'Clave ISSEMYM',
          estilo: _estiloDato,
          centroY: centroClave,
          izquierda: 14,
          derecha: CredencialMedidas.ancho - 14,
        ),
        _Adscripcion(
          texto: datos.adscripcion ?? 'Adscripción',
          estilo: _estiloAdscripcion,
        ),

        const ImagenPt(CredencialAssets.frenteLogoIssemym, rectLogoIssemym),
        const ImagenPt(CredencialAssets.frenteCenefa, rectCenefa),
      ],
    );
  }
}

class _MarcoFoto extends StatelessWidget {
  const _MarcoFoto({this.foto});

  final ImageProvider? foto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CredencialColores.guinda,
          width: CredencialFrente.grosorMarcoFoto,
        ),
      ),
      child: foto == null
          ? null
          : Image(
              image: foto!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.medium,
            ),
    );
  }
}

class _FranjaNombre extends StatelessWidget {
  const _FranjaNombre({required this.nombre, required this.estilo});

  final String? nombre;
  final TextStyle estilo;

  @override
  Widget build(BuildContext context) {
    final hoja = CredencialFrente.tamanoHoja;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.fromSize(
          size: hoja,
          child: Image.asset(CredencialAssets.frenteHojaIzq, fit: BoxFit.fill),
        ),
        const SizedBox(width: 2.375),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: CredencialFrente.anchoPildoraDiseno,
            maxWidth: CredencialFrente.anchoPildoraMax,
          ),
          child: SizedBox(
            height: CredencialFrente.altoPildora,
            child: DecoratedBox(
              decoration: const ShapeDecoration(
                color: CredencialColores.guinda,
                shape: StadiumBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.5),
                child: Center(
                  widthFactor: 1,
                  child: nombre == null
                      ? null
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            nombre!.toUpperCase(),
                            style: estilo,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 1.875),
        SizedBox.fromSize(
          size: hoja,
          child: Image.asset(CredencialAssets.frenteHojaDer, fit: BoxFit.fill),
        ),
      ],
    );
  }
}

/// Adscripción: hasta dos líneas, porque los nombres de unidad suelen ser
/// largos. La primera línea queda en la posición del rótulo del PDF.
class _Adscripcion extends StatelessWidget {
  const _Adscripcion({required this.texto, required this.estilo});

  final String texto;
  final TextStyle estilo;

  @override
  Widget build(BuildContext context) {
    final altoLinea = estilo.fontSize! * estilo.height!;
    return Positioned(
      left: 14,
      right: 14,
      top: CredencialFrente.centroAdscripcion - altoLinea / 2,
      height: altoLinea * 2,
      child: Text(
        texto,
        style: estilo,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
