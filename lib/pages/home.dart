import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
// ignore_for_file: use_build_context_synchronously

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
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
                          DataColumn(
                            label: SizedBox(
                              width: 90,
                              child: Text('Nombre y Apellido'),
                            ),
                          ),
                          DataColumn(label: Text('Edad')),
                          DataColumn(
                            label: Text('Acciones'),
                          ),
                        ],
                        rows: snapshot.data!.map<DataRow>((persona) {
                          final uid = persona['uid'];
                          final nombreApellido = persona['nombre_Apellido'];
                          final edad = persona['edad'].toString();

                          return DataRow(cells: [
                            DataCell(Text(nombreApellido)),
                            DataCell(Text(edad)),
                            DataCell(Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      '/editPage',
                                      arguments: {
                                        'nombre_Apellido': nombreApellido,
                                        'edad': edad,
                                        'uid': uid,
                                      },
                                    );
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.orange, // Color naranja
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Espacio entre el ícono y el texto
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Confirmar eliminación'),
                                          content: const Text(
                                              '¿Estás seguro de eliminar este usuario?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isDeleting = true;
                                                });
                                                await eliminarUsuario(
                                                    uid); // Función para eliminar al usuario
                                                setState(() {
                                                  _isDeleting = false;
                                                });
                                                Navigator.of(context).pop();
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Eliminación exitosa'),
                                                      content: const Text(
                                                          'El usuario se eliminó correctamente.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Aceptar'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text('Eliminar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Espacio entre el ícono y el texto
                                    ],
                                  ),
                                )
                              ],
                            )),
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
        FutureBuilder<int>(
          future: getPromedioEdad(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int averageAge = snapshot.data!;
              return Text(
                '$averageAge Años',
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
          future: getNumeroDePersonas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Personas registradas: ${snapshot.data}',
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
