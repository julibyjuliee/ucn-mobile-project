import '../services/personas.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();

  TextEditingController textController = TextEditingController(text: "");
  // String _nombre, _apellido, _correo;

  void agregarUsuario() async {
    String nombre = nombreController.text;
    int edad = int.parse(edadController.text);

    Person person = Person(nombre: nombre, edad: edad);

    await addPersonasToFirestore(person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombres Y Apellidos',
                ),
              ),
              TextFormField(
                controller: edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    /* if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _agregarUsuario();
                    } */
                    agregarUsuario();
                    print(nombreController.text);
                    print(edadController.text);
                  },
                  child: const Text('Agregar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
