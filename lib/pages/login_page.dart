import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

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
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'img/Logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserTextField(controller: emailController),
                  SizedBox(height: 15),
                  PasswordTextField(controller: contrasenaController),
                  SizedBox(height: 20.0),
                  ButtonLogin(
                    emailController: emailController,
                    contrasenaController: contrasenaController,
                  ),
                ],
              ),
            ),
          ],
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
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'ejemplo@correo.com',
          labelText: 'correo electrónico',
          border: InputBorder
              .none, // Para eliminar el borde predeterminado del TextField
        ),
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
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'contraseña',
          labelText: 'contraseña',
          border: InputBorder
              .none, // Para eliminar el borde predeterminado del TextField
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController contrasenaController;
  const ButtonLogin({
    Key? key,
    required this.emailController,
    required this.contrasenaController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
        child: Text('Iniciar sesión'),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        // Lógica para iniciar sesión
        String email = emailController.text;
        String contrasena = contrasenaController.text;
        if (email == 'ejemplo@correo.com' && contrasena == '123') {
          Navigator.pushNamed(context, '/home');
        } else {
          // Credenciales incorrectas
          final snackBar = SnackBar(
            content: Text(
              'Usuario y/o contraseña incorrectos',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
