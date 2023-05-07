import 'package:prueba/services/personas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Crear instancia de la base de datos
FirebaseFirestore db = FirebaseFirestore.instance; 

//Funcion para listar los datos

Future<List> getPersonas() async {
  List persona = [];
  CollectionReference collectionReferencePersonas = db.collection('personas');

  QuerySnapshot query = await collectionReferencePersonas.get();

  query.docs.forEach((documento) {
    //se le agrega la data que viene en la db en la lista persona
    persona.add(documento.data());
  });

  return persona;
}

//Registrar Usuarios

Future<void> addPersonasToFirestore(Person person) async {
  await FirebaseFirestore.instance.collection('personas').add(person.toMap());
}