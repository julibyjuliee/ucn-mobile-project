import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphPage extends StatefulWidget {
  const GraphPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<String> hobbies = [];
  Map<String, int> personasPorHobby = {};

  @override
  void initState() {
    super.initState();
    obtenerHobbies().then((personasPorHobbyMap) {
      setState(() {
        personasPorHobby = personasPorHobbyMap;
        hobbies = personasPorHobbyMap.keys.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series<Map<String, Object>, String>(
        id: 'hobbies',
        domainFn: (entry, _) => entry['hobby'] as String,
        measureFn: (entry, _) => entry['cantidadPersonas'] as int,
        data: personasPorHobby.entries
            .map((entry) => {
                  'hobby': entry.key,
                  'cantidadPersonas': entry.value,
                })
            .toList(),
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadístico de Hobbies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: chart),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  String hobby = hobbies[index];
                  int cantidadPersonas = personasPorHobby[hobby] ?? 0;

                  if (hobby.isNotEmpty) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors
                            .grey[200], // Color de fondo suave (gris claro)
                        borderRadius:
                            BorderRadius.circular(10.0), // Bordes redondeados
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(hobby),
                        subtitle: Text('$cantidadPersonas personas'),
                      ),
                    );
                  } else {
                    return const SizedBox(); // Omitir la visualización si el hobby está vacío
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
