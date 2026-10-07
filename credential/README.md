# Credencial de personal ISSEMyM (Flutter)

App móvil (Android / iOS) para capturar los datos de un empleado, ver la
credencial (frente y reverso) y exportarla a PDF para imprimir o compartir.

## Puesta en marcha

1. Crea el proyecto base (genera las carpetas android/ e ios/):

       flutter create --org mx.gob.issemym --platforms android,ios credencial_issemym

2. Copia encima de ese proyecto el contenido de este paquete
   (reemplaza pubspec.yaml, lib/ y test/; agrega assets/).

3. Coloca los logos en assets/images/ (ver LEEME.txt).

4. Solo iOS: agrega en ios/Runner/Info.plist, dentro de <dict>:

       <key>NSCameraUsageDescription</key>
       <string>Se usa la cámara para tomar la foto de la credencial.</string>
       <key>NSPhotoLibraryUsageDescription</key>
       <string>Se usa la galería para elegir la foto de la credencial.</string>

5. Instala dependencias y ejecuta:

       flutter pub get
       flutter run

## Estructura

    lib/
      main.dart                          Arranque, tema y español (es-MX)
      config/tema_credencial.dart        Medidas, colores, textos y rutas de assets
      models/empleado.dart               Datos de la credencial + datos de ejemplo
      widgets/credencial_widgets.dart    Frente y reverso en Flutter
      services/pdf_credencial_service.dart  Mismo diseño generado como PDF
      screens/
        formulario_screen.dart           Captura de datos y foto
        vista_previa_screen.dart         Vista de frente / reverso
        pdf_screen.dart                  Vista previa PDF, imprimir y compartir

## Para ajustar a la plantilla de Oficialía Mayor

- Colores, textos y tamaños: lib/config/tema_credencial.dart.
- Acomodo de elementos: está en dos lugares que deben coincidir,
  widgets/credencial_widgets.dart (pantalla) y
  services/pdf_credencial_service.dart (PDF).
- Contenido del QR: getter `datosQr` en models/empleado.dart. Para producción
  se recomienda una URL de verificación en lugar de datos en claro.

## Formatos de PDF

- Tarjeta PVC: una página por cara, a 53.98 x 85.6 mm (CR80), para
  impresoras de credenciales.
- Hoja carta: frente y reverso lado a lado, a tamaño real, con línea de corte.
  Imprimir al 100 % (sin "ajustar a página").

## Fuente

Montserrat, licencia SIL Open Font License (assets/fonts/OFL.txt).
