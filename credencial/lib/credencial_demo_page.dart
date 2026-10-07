import 'package:flutter/material.dart';

import 'credencial/credencial.dart';

/// Pantalla de prueba para revisar la maquetación: frente y reverso lado a
/// lado, con un interruptor para comparar contra la plantilla vacía.
class CredencialDemoPage extends StatefulWidget {
  const CredencialDemoPage({super.key});

  @override
  State<CredencialDemoPage> createState() => _CredencialDemoPageState();
}

class _CredencialDemoPageState extends State<CredencialDemoPage> {
  bool _conDatos = true;
  final _llaveFrente = GlobalKey();
  final _llaveReverso = GlobalKey();

  // Datos ficticios solo para maquetar.
  static final _ejemplo = DatosCredencial(
    nombre: 'María Fernanda López García',
    claveIssemym: '1234567',
    adscripcion: 'Unidad de Tecnologías de la Información',
    rfc: 'LOGM850101AB1',
    curp: 'LOGM850101MMCPRR09',
    vigencia: DateTime(2027, 12, 31),
    qr: 'https://ejemplo.issemym.gob.mx/credencial/1234567',
  );

  @override
  Widget build(BuildContext context) {
    final datos = _conDatos ? _ejemplo : DatosCredencial.vacia;
    return Scaffold(
      backgroundColor: const Color(0xFFE9E7E4),
      appBar: AppBar(
        title: const Text('Credencial de personal'),
        actions: [
          const Text('Con datos'),
          Switch(value: _conDatos, onChanged: (v) => setState(() => _conDatos = v)),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _Lado(
                titulo: 'Frente',
                child: RepaintBoundary(key: _llaveFrente, child: CredencialFrente(datos: datos)),
              ),
              _Lado(
                titulo: 'Reverso',
                child: RepaintBoundary(key: _llaveReverso, child: CredencialReverso(datos: datos)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Lado extends StatelessWidget {
  const _Lado({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SizedBox(
          width: 320,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
