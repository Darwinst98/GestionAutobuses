import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'inicio_admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
     final loginBody = {
        "email":  _emailController.text,
        "password": _passwordController.text,
        "returnSecureToken": true
      };

final queryParams = {"key": "AIzaSyDJlraDBdCtcpWYEmj-yXCc00Gh0xiGJCk"};
 var uri = Uri.https("www.googleapis.com",
          "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams);
  var response = await http.post(uri, body: json.encode(loginBody));
 if (response.body.isEmpty)  developer.log("Error. Al iniciar sesion");
      Map<String, dynamic> decodedResp = json.decode(response.body);
      developer.log(decodedResp.toString());
  if (decodedResp.containsKey("idToken")) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InicioAdminScreen()), 
      );
  }
}

void _register() async {
  var uri = Uri.parse("https://us-central1-app-autobus.cloudfunctions.net/api/registro");
  final Map<String, String> _headers = {"content-type": "application/json"};
  var user = {
        "email":  _emailController.text,
        "password":  _passwordController.text
      };
    var response =
          await http.post(uri, headers: _headers, body:  json.encode(user));
  developer.log(response.body);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['status'] == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InicioAdminScreen()), 
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login y Registro'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
