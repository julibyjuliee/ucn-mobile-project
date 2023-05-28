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
  String selectedHobby = 'Cocinar'; // Opción predeterminada
  bool showHobbiesField =
      false; // Variable para controlar la visibilidad del campo de selección de hobbies

  List<String> hobbies = ['Cocinar', 'Bailar', 'El Fútbol', 'Otros'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Agregar Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Color de fondo suave (gris claro)
                  borderRadius:
                      BorderRadius.circular(10.0), // Bordes redondeados
                ),
                child: TextFormField(
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
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Color de fondo suave (gris claro)
                  borderRadius:
                      BorderRadius.circular(10.0), // Bordes redondeados
                ),
                child: TextFormField(
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
              ),
              const SizedBox(height: 16.0),
              if (showHobbiesField) // Mostrar el campo de selección de hobbies solo si showHobbiesField es true
                Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.grey[200], // Color de fondo suave (gris claro)
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordes redondeados
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedHobby,
                    decoration: const InputDecoration(
                      labelText: 'Hobbies',
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedHobby = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Seleccione un hobby') {
                        return 'Por favor seleccione un hobby';
                      }
                      return null;
                    },
                    items: hobbies.map((hobby) {
                      return DropdownMenuItem<String>(
                        value: hobby,
                        child: Text(hobby),
                      );
                    }).toList(),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showHobbiesField =
                            true; // Mostrar el campo de selección de hobbies al hacer clic en el botón
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
                        agregarPersonaConHobbies(
                            nombreApellido, edad, selectedHobby);
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
                                    Navigator.pop(context, true);
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
    );
  }
}
