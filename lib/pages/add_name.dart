import './graph_page.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
// ignore_for_file: prefer_const_constructors

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreApellidoController =
      TextEditingController(text: "");
  TextEditingController edadController = TextEditingController(text: "");
  TextEditingController hobbiesController = TextEditingController(text: "");

  bool mostrarCampoHobbies = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.grey[200],
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nombreApellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Nombres Y Apellidos',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los nombres y apellidos';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: edadController,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la edad';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'La edad solo puede contener caracteres numéricos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                if (mostrarCampoHobbies)
                  TextFormField(
                    controller: hobbiesController,
                    decoration: const InputDecoration(
                      labelText: 'Hobbies',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese los hobbies';
                      }
                      return null;
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mostrarCampoHobbies = true;
                        });
                      },
                      child: const Text('Agregar Hobbies'),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String nombreApellido = nombreApellidoController.text;
                          int edad = int.parse(edadController.text);
                          String hobbies = hobbiesController.text;

                          // Llamar a la función para agregar la persona y sus hobbies en Firestore
                          agregarPersonaConHobbies(
                              nombreApellido, edad, hobbies);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Agregado con éxito'),
                                content: Text(
                                    'El usuario se ha agregado correctamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(
                                          context); // Volver a la pantalla anterior
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Agregar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
