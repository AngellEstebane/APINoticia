import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRAR USUARIO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes realizar la lógica de registro de usuario.
                // Puedes almacenar los valores de _usernameController.text y _passwordController.text
                // en algún lugar, como una base de datos o una lista en memoria.
                // Por ahora, simplemente imprimiré los valores.
                print('Usuario registrado:');
                print('Usuario: ${_usernameController.text}');
                print('Contraseña: ${_passwordController.text}');
                // Puedes agregar más lógica según tus necesidades.
              },
              child: Text('REGISTRAR'),
            ),
          ],
        ),
      ),
    );
  }
}
