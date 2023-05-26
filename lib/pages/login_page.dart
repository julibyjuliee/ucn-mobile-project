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
              UserTextField(),
              SizedBox(
                height: 15,
              ),
              PasswordTextField(),
              SizedBox(
                height: 20.0,
              ),
              // _bottonLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'contraseña',
          labelText: 'contraseña',
        ),
        onChanged: (value) {},
      ),
    );
  }
}

/* class ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        // Lógica para iniciar sesión
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
        child: Text('Iniciar sesión'),
      ),
    );
  }
} */
