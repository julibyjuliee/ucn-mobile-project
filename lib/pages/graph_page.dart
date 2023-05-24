import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadístico de Hobbies'),
      ),
      body: ListView.builder(
        itemCount: hobbies.length,
        itemBuilder: (context, index) {
          String hobby = hobbies[index];
          int cantidadPersonas = personasPorHobby[hobby] ?? 0;

          if (hobby.isNotEmpty) {
            return ListTile(
              title: Text(hobby),
              subtitle: Text('$cantidadPersonas personas'),
            );
          } else {
            return const SizedBox(); // Omitir la visualización si el hobby está vacío
          }
        },
      ),
    );
  }
}
