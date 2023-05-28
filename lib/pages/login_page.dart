import 'package:flutter/material.dart';

// ignore_for_file: use_build_context_synchronously

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Image.asset(),
              SizedBox(
                height: 15.0,
              ),
              UserTextField(controller: emailController),
              SizedBox(
                height: 15,
              ),
              PasswordTextField(controller: contrasenaController),
              SizedBox(
                height: 20.0,
              ),
              ButtonLogin(
                emailController: emailController,
                contrasenaController: contrasenaController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  const UserTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'ejemplo@correo.com',
          labelText: 'correo electronico',
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'contraseña',
          labelText: 'contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController contrasenaController;
  const ButtonLogin(
      {Key? key,
      required this.emailController,
      required this.contrasenaController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
        child: Text('Iniciar sesión'),
      ),
      /*style: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),*/
      onPressed: () {
        // Lógica para iniciar sesión
        String email = emailController.text;
        String contrasena = contrasenaController.text;
        if (email == 'ejemplo@correo.com' && contrasena == '123') {
          Navigator.pushNamed(context, '/home');
        } else {
          print('Ingreso Incorrecto');
        }
      },
    );
  }
}
