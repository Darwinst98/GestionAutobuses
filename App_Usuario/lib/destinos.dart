import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruebaflutter/inicio.dart';
import 'dart:convert';
import 'inicio.dart';

class DestinoScreen extends StatefulWidget {
  @override
  _DestinoScreenState createState() => _DestinoScreenState();
}

class _DestinoScreenState extends State<DestinoScreen> {
  List<Map<String, dynamic>> destinos = [];

  @override
  void initState() {
    super.initState();
    // Cargar los destinos desde la base de datos
    _loadDestinos();
  }

  Future<void> _loadDestinos() async {
    try {
      var url = Uri.parse(
          "https://us-central1-app-autobus.cloudfunctions.net/api/ruta");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> listBody = json.decode(response.body);
        setState(() {
          destinos = List<Map<String, dynamic>>.from(listBody);
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
        title: Text('Vienvenodo, puedes escoger tu Destino'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: destinos.length,
        itemBuilder: (context, index) {
          return _buildDestinoCard(destinos[index]);
        },
      ),
    );
  }

  Widget _buildDestinoCard(Map<String, dynamic> ruta) {
    final imageUrl = ruta['imagenDestino'] as String;
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
              ruta['destino'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InicioScreen()),
              );
            },
            child: Text('Coperativas con este destino'),
          ),
        ],
      ),
    );
  }
}
