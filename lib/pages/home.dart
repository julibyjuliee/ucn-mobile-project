import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.0,
            ),
          ),
          child: FutureBuilder(
            future: getPersonas(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                  columns: [
                    DataColumn(label: Text('Nombre y Apellido')),
                    DataColumn(label: Text('Edad')),
                  ],
                  rows: snapshot.data!.map<DataRow>((persona) {
                    return DataRow(cells: [
                      DataCell(Text(persona['nombre_Apellido'])),
                      DataCell(Text(persona['edad'].toString())),
                    ]);
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addPage');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
