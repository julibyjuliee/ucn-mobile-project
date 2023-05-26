import '../pages/home.dart';
import 'firebase_options.dart';
import '../pages/add_name.dart';
import '../pages/edit_name.dart';
import '../pages/graph_page.dart';
import '../pages/login_page.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bienvenido A Nuestra App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => const MyHomePage(),
          '/addPage': (context) => const AddPage(),
          '/editPage': (context) => const EditPage(),
          '/graph': (context) => const GraphPage(),
        });
  }
}
