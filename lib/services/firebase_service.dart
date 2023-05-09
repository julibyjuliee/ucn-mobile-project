import '../services/personas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Crear instancia de la base de datos
FirebaseFirestore db = FirebaseFirestore.instance; 

//Funcion para listar los datos

Future<List> getPersonas() async {
  List persona = [];
  CollectionReference collectionReferencePersonas = db.collection('personas');

  QuerySnapshot query = await collectionReferencePersonas.orderBy('nombre_Apellido').get();

  query.docs.forEach((documento) {
    //se le agrega la data que viene en la db en la lista persona
    persona.add(documento.data());
  });

  return persona;
}

//Registrar Usuarios

Future<void> addPersonasToFirestore(String nombreApellido, int edad) async {
  await FirebaseFirestore.instance.collection('personas').add({"nombre_Apellido": nombreApellido,"edad": edad});
}