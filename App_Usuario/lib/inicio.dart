import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'horarios.dart';

class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  List<Map<String, dynamic>> cooperativas = [];

  @override
  void initState() {
    super.initState();
    // Cargar las cooperativas desde la base de datos
    _loadCooperativas();
  }

  Future<void> _loadCooperativas() async {
    try {
      var url = Uri.parse(
          "https://us-central1-app-autobus.cloudfunctions.net/api/flota");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> listBody = json.decode(response.body);
        setState(() {
          cooperativas = List<Map<String, dynamic>>.from(listBody);
        });
      }
    } catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooperativas'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: cooperativas.length,
        itemBuilder: (context, index) {
          return _buildCooperativaCard(cooperativas[index]);
        },
      ),
    );
  }

  Widget _buildCooperativaCard(Map<String, dynamic> flota) {
    final imageUrl = flota['imagen'] as String;
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              flota['nomCoperativa'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              flota['descripcion'],
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HorariosScreen()),
              );
            },
            child: Text('Horarios que cubre esta cooperativa'),
          ),
        ],
      ),
    );
  }
}
