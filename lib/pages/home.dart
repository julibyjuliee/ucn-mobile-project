import 'package:flutter/material.dart';
import '../services/firebase_service.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: FutureBuilder(
            future: getPersonas(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      // String edad = snapshot.data?[index]['edad']?.toString() ?? '';
                      return Column(children: [
                        Text(snapshot.data?[index]['nombre_Apellido']),
                        // Text(edad),
                      ]);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, '/addPage');
              },
              child: const Icon(Icons.add),
            ),
            );
  }
}
