import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

class RutasScreen extends StatefulWidget {
  @override
  _RutasScreenState createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> {
  List<Map<String, dynamic>> rutas = [];

  @override
  void initState() {
    super.initState();
    // Cargar los destinos desde la base de datos
    _loadRutas();
  }

  Future<void> _loadRutas() async {
    try {
      var url = Uri.parse(
          "https://us-central1-app-autobus.cloudfunctions.net/api/ruta");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> listBody = json.decode(response.body);
        setState(() {
          rutas = List<Map<String, dynamic>>.from(listBody);
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
        title: Text('Bienvenido esta es tu ruta'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: rutas.length,
        itemBuilder: (context, index) {
          return _buildDestinoCard(rutas[index]);
        },
      ),
    );
  }

  Widget _buildDestinoCard(Map<String, dynamic> ruta) {
    final imageUrl = ruta['imagen'] as String;
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
              ruta['ruta'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Text('Inico'),
          ),
        ],
      ),
    );
  }
}
