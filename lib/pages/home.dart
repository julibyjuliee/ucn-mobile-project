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
      backgroundColor: Colors.grey[200],
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
                child: FutureBuilder(
                  future: getPersonas(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final persona = snapshot.data![index];
                          final uid = persona['uid'];
                          final nombreApellido = persona['nombre_Apellido'];
                          final edad = persona['edad'].toString();
                          final hobbies = persona['hobbies'];

                          return Card(
                            child: ListTile(
                              title: Text(
                                nombreApellido,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Edad: $edad'),
                                  Text('Hobbies: $hobbies'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        '/editPage',
                                        arguments: {
                                          'nombre_Apellido': nombreApellido,
                                          'edad': edad,
                                          'uid': uid,
                                          'hobbies': hobbies,
                                        },
                                      );
                                      if (result != null &&
                                          result is bool &&
                                          result) {
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Confirmar eliminación',
                                            ),
                                            content: const Text(
                                              '¿Estás seguro de eliminar este usuario?',
                                            ),
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
                                                  await eliminarUsuario(uid);
                                                  setState(() {
                                                    _isDeleting = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (
                                                      BuildContext context,
                                                    ) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          'Eliminación exitosa',
                                                        ),
                                                        content: const Text(
                                                          'El usuario se eliminó correctamente.',
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              'Aceptar',
                                                            ),
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
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/addPage');
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/graph');
            },
            child: const Icon(Icons.bar_chart),
          ),
        ],
      ),
    );
  }
}

class PromedioEdadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Color de fondo suave (gris claro)
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text(
              'Promedio de edad',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(0, 29, 36, 14),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 9),
          FutureBuilder<int>(
            future: getPromedioEdad(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int averageAge = snapshot.data!;
                return Text(
                  '$averageAge años',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 29, 36, 14),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(0, 29, 36, 14),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class PersonasRegistradas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Color de fondo suave (gris claro)
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
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
