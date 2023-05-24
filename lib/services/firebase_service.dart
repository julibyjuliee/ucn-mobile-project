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
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final person = {
      'nombre_Apellido': data['nombre_Apellido'],
      'edad': data['edad'],
      'uid': documento.id,
      'hobbies': data['hobbies'],
    };
    //se le agrega la data que viene en la db en la lista persona
    persona.add(person);
  });

  return persona;
}

//Registrar Usuarios

Future<void> addPersonasToFirestore(String nombreApellido, int edad) async {
  await FirebaseFirestore.instance
      .collection('personas')
      .add({"nombre_Apellido": nombreApellido, "edad": edad});
}

Future<void> updatePersonasToFirestore(
    String uid, String newNombreApellido, int newEdad, String newHobbie) async {
  await db.collection('personas').doc(uid).set({
    "nombre_Apellido": newNombreApellido,
    "edad": newEdad,
    "hobbies": newHobbie,
  }, SetOptions(merge: true));
}

//Eliminar usuarios
Future<void> eliminarUsuario(String uid) async {
  await db.collection('personas').doc(uid).delete();
}

//Calcular promedio de edad

Future<int> getPromedioEdad() async {
  CollectionReference usersRef =
      FirebaseFirestore.instance.collection('personas');
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

//Registrar Usuarios con hobbies

Future<void> agregarPersonaConHobbies(
    String nombreApellido, int edad, String hobbies) async {
  await FirebaseFirestore.instance.collection('personas').add({
    "nombre_Apellido": nombreApellido,
    "edad": edad,
    "hobbies": hobbies,
  });
}

//Obtener los hobbies de la persona

Future<Map<String, int>> obtenerHobbies() async {
  Map<String, int> personasPorHobby = {};

  CollectionReference personasCollection =
      FirebaseFirestore.instance.collection('personas');

  try {
    QuerySnapshot querySnapshot = await personasCollection.get();

    querySnapshot.docs.forEach((doc) {
      if (doc.exists) {
        // Obtener el valor del campo "hobbies" de cada documento
        String hobbiesString = doc['hobbies'];

        // Convertir la cadena de hobbies en una lista
        List<String> hobbies = hobbiesString.split(',');

        // Actualizar el conteo de personas para cada hobby
        hobbies.forEach((hobby) {
          hobby = hobby
              .trim(); // Eliminar posibles espacios en blanco alrededor del hobby
          personasPorHobby[hobby] = (personasPorHobby[hobby] ?? 0) + 1;
        });
      }
    });
  } catch (e) {
    print('Error al obtener los hobbies: $e');
  }

  return personasPorHobby;
}
