import 'package:flutter/material.dart';

void main() {
  runApp(const ControlHabitosApp());
}

// Colección tipada: modelo de datos para cada hábito
class Habito {
  final String nombre;
  final String meta;
  final IconData icono;
  int contador;

  Habito({
    required this.nombre,
    required this.meta,
    required this.icono,
    this.contador = 0,
  });
}

// App raíz (StatelessWidget porque no guarda estado mutable)
class ControlHabitosApp extends StatelessWidget {
  const ControlHabitosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de hábitos',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const PantallaHabitos(),
    );
  }
}

// StatelessWidget propio para contenido fijo (encabezado visual)
class EncabezadoHabitos extends StatelessWidget {
  final String subtitulo;

  const EncabezadoHabitos({super.key, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitulo,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          const Text('Toca +1 cada vez que completes tu hábito.'),
        ],
      ),
    );
  }
}

// StatefulWidget porque los contadores cambian en pantalla
class PantallaHabitos extends StatefulWidget {
  const PantallaHabitos({super.key});

  @override
  State<PantallaHabitos> createState() => _PantallaHabitosState();
}

class _PantallaHabitosState extends State<PantallaHabitos> {
  // Lista genérica tipada con 3 hábitos personalizados
  final List<Habito> _habitos = [
    Habito(nombre: 'Tomar agua', meta: 'Meta: 8 vasos', icono: Icons.water_drop),
    Habito(nombre: 'Estudiar Flutter', meta: 'Meta: 2 bloques', icono: Icons.menu_book),
    Habito(nombre: 'Caminar / Ejercicio', meta: 'Meta: 30 min', icono: Icons.directions_walk),
  ];

  void _incrementar(int index) {
    setState(() {
      _habitos[index].contador++;
    });
  }

  void _reiniciarDia() {
    setState(() {
      for (final habito in _habitos) {
        habito.contador = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de hábitos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const EncabezadoHabitos(subtitulo: 'Seguimiento diario'),
            Expanded(
              child: ListView.builder(
                itemCount: _habitos.length,
                itemBuilder: (context, index) {
                  final habito = _habitos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(habito.icono, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    habito.nombre,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(habito.meta),
                                  Text('Realizados: ${habito.contador}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _incrementar(index),
                              child: const Text('+1'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _reiniciarDia,
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar día'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  