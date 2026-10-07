import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'credencial_tokens.dart';
import 'datos_credencial.dart';
import 'lienzo_credencial.dart';

/// Reverso del gafete. Coordenadas en pt medidas sobre el PDF.
class CredencialReverso extends StatelessWidget {
  const CredencialReverso({super.key, this.datos = DatosCredencial.vacia});

  final DatosCredencial datos;

  // ---- Geometría (pt) -------------------------------------------------
  static const rectRanura = Rect.fromLTRB(68.05, 8.37, 85.92, 14.77);
  static const centroRotulos = 32.9;
  static const xRfc = 39.7;
  static const xCurp = 106.25;
  static const centroValores = 43.0;
  static const lineaFirmaX0 = 27.23;
  static const lineaFirmaX1 = 124.54;
  static const yFirmaServidor = 80.65;
  static const yFirmaDirector = 121.55;
  static const rectFirmaServidor = Rect.fromLTRB(38, 52, 114, 79.8);
  static const rectFirmaDirector = Rect.fromLTRB(38, 93, 114, 120.7);
  static const rectQr = Rect.fromLTRB(55.0, 157.8, 98.2, 200.9);
  static const centroVigencia = 227.3;

  // ---- Estilos ---------------------------------------------------------
  static final _rotulo = estiloCredencial(
    tamano: 6.3,
    color: CredencialColores.guinda,
  );
  static final _valor = estiloCredencial(tamano: 5.6, peso: FontWeight.w600);
  static final _leyendaFirma = estiloCredencial(
    tamano: 6.4,
    peso: FontWeight.w400,
    color: CredencialColores.guinda,
  );
  static final _vigencia = estiloCredencial(
    tamano: 6.6,
    color: CredencialColores.guinda,
  );

  @override
  Widget build(BuildContext context) {
    return LienzoCredencial(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage(CredencialAssets.reversoFondo),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.medium,
          ),
        ),
        const RanuraPt(rectRanura),

        // RFC / CURP
        LineaTextoPt.enX('RFC', estilo: _rotulo, centroX: xRfc, centroY: centroRotulos, anchoMax: 60),
        LineaTextoPt.enX('CURP', estilo: _rotulo, centroX: xCurp, centroY: centroRotulos, anchoMax: 60),
        if (datos.rfc != null)
          LineaTextoPt.enX(datos.rfc!, estilo: _valor, centroX: xRfc, centroY: centroValores, anchoMax: 54),
        if (datos.curp != null)
          LineaTextoPt.enX(datos.curp!, estilo: _valor, centroX: xCurp, centroY: centroValores, anchoMax: 72),

        // Firma del servidor público
        if (datos.firmaServidor != null)
          Positioned.fromRect(rect: rectFirmaServidor, child: _Firma(datos.firmaServidor!)),
        const LineaFirmaPt(y: yFirmaServidor, x0: lineaFirmaX0, x1: lineaFirmaX1),
        LineaTextoPt('Firma del Servidor Público', estilo: _leyendaFirma, centroY: 90.25),

        // Firma del(de la) director(a)
        if (datos.firmaDirector != null)
          Positioned.fromRect(rect: rectFirmaDirector, child: _Firma(datos.firmaDirector!)),
        const LineaFirmaPt(y: yFirmaDirector, x0: lineaFirmaX0, x1: lineaFirmaX1),
        LineaTextoPt('Firma del(de la) Director(a) de', estilo: _leyendaFirma, centroY: 131.15),
        // Nota: el PDF dice "Desarollo"; aquí va corregido.
        LineaTextoPt('Administración y Desarrollo de Personal', estilo: _leyendaFirma, centroY: 138.7),

        // QR
        if (datos.qr != null)
          Positioned.fromRect(
            rect: rectQr,
            child: QrImageView(
              data: datos.qr!,
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              gapless: true,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: CredencialColores.texto,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: CredencialColores.texto,
              ),
            ),
          ),

        LineaTextoPt(
          'Vigencia:  ${_fecha(datos.vigencia)}',
          estilo: _vigencia,
          centroY: centroVigencia,
        ),
      ],
    );
  }

  static String _fecha(DateTime? f) {
    if (f == null) return '    /    /    ';
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${dos(f.day)} / ${dos(f.month)} / ${f.year}';
  }
}

class _Firma extends StatelessWidget {
  const _Firma(this.imagen);

  final ImageProvider imagen;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imagen,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      filterQuality: FilterQuality.medium,
    );
  }
}
