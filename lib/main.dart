import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:prueba/pages/home.dart';
import 'package:prueba/pages/add_name.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Bienvenido A Nuestra App',
      initialRoute: '/',
      routes: {
        '/' : (context) => const MyHomePage(),
        '/addPage' : (context) => const AddPage(),
      }
    );
  }
}
