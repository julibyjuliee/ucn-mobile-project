import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreApellidoController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  String uid = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      if (arguments != null) {
        nombreApellidoController.text = arguments['nombre_Apellido'] ?? '';
        hobbiesController.text = arguments['hobbies'] ?? '';
        edadController.text = arguments['edad']?.toString() ?? '';
        uid = arguments['uid'] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuarios'),
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
                    labelText: 'Nombres y Apellidos',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      int edad = int.parse(edadController.text);
                      await updatePersonasToFirestore(
                              uid,
                              nombreApellidoController.text,
                              edad,
                              hobbiesController.text)
                          .then((value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Actualizado con éxito'),
                              content: Text(
                                  'El usuario se ha actualizado correctamente.'),
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
                      });
                    },
                    child: const Text('Actualizar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
