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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PersonasRegistradas(),
          PromedioEdadWidget(),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color.fromRGBO(0, 29, 36, 14),
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
          ),
        ],
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

class PromedioEdadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Promedio de edad',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(0, 29, 36, 14),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        FutureBuilder<double>(
          future: getAverageAge(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double averageAge = snapshot.data!;
              return Text(
                '${averageAge.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: Color.fromRGBO(0, 29, 36, 14),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(0, 29, 36, 14)),
              );
            }
          },
        ),
      ],
    );
  }
}

class PersonasRegistradas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Center(
        child: FutureBuilder<int>(
          future: getNumberOfPersons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Número de personas registradas: ${snapshot.data}',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 29, 36, 14),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: LinearProgressIndicator(
                        value: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(0, 29, 36, 14)),
                        backgroundColor: Color.fromRGBO(0, 29, 36, 14),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  color: Color.fromRGBO(0, 29, 36, 14),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            } else {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(0, 29, 36, 14)),
              );
            }
          },
        ),
      ),
    );
  }
}
