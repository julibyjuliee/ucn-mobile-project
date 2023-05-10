import 'package:cloud_firestore/cloud_firestore.dart';

//Crear instancia de la base de datos
FirebaseFirestore db = FirebaseFirestore.instance;

//Funcion para listar los datos

Future<List> getPersonas() async {
  List persona = [];
  CollectionReference collectionReferencePersonas = db.collection('personas');

  QuerySnapshot query =
      await collectionReferencePersonas.orderBy('nombre_Apellido').get();

  query.docs.forEach((documento) {
    //se le agrega la data que viene en la db en la lista persona
    persona.add(documento.data());
  });

  return persona;
}

//Registrar Usuarios

Future<void> addPersonasToFirestore(String nombreApellido, int edad) async {
  await FirebaseFirestore.instance
      .collection('personas')
      .add({"nombre_Apellido": nombreApellido, "edad": edad});
}

//Editar usuarios

//Eliminar usuarios

//Calcular promedio de edad

Future<int> getPromedioEdad() async {
  CollectionReference usersRef = FirebaseFirestore.instance.collection('personas');
  QuerySnapshot snapshot = await usersRef.get();

  int edadTotal = 0;
  int numeroTotalUsuarios = snapshot.size;

  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    edadTotal += data['edad'] as int;
  });

  return edadTotal ~/ numeroTotalUsuarios;
}


//Calcular promedio de edad

Future<int> getNumeroDePersonas() async {
  CollectionReference personsRef =
      FirebaseFirestore.instance.collection('personas');
  QuerySnapshot snapshot = await personsRef.get();
  int numberOfPersons = snapshot.size;
  return numberOfPersons;
}
