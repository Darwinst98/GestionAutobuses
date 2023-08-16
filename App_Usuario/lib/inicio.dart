import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  // Lista de cooperativas con sus nombres e imágenes
  final List<Map<String, String>> cooperativas = [
    {
      'nombre': 'Cooperativa de Trasporte Latacunga',
      'imagen': 'imagenes/copLatacunga.png',
    },
    {
      'nombre': 'Cooperativa de Transporte Cotopaxi',
      'imagen': 'imagenes/copCotopaxi.png',
    },
    {
      'nombre': 'Cooperativa de Trasporte Primavera',
      'imagen': 'imagenes/copPrimavera.png',
    },
    {
      'nombre': 'Cooperativa de Trasporte Baños',
      'imagen': 'imagenes/copBaños.png',
    },
    {
      'nombre': 'Cooperativa de Trasporte Ciro',
      'imagen': 'imagenes/copCiro.png',
    },
    {
      'nombre': 'Cooperativa de Trasporte Sangay',
      'imagen': 'imagenes/copSangay.png',
    },
    // Agrega más cooperativas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos columnas
          crossAxisSpacing: 10.0, // Espacio horizontal entre las imágenes
          mainAxisSpacing: 10.0, // Espacio vertical entre las imágenes
        ),
        itemCount: cooperativas.length,
        itemBuilder: (context, index) {
          return _buildCooperativaCard(cooperativas[index]);
        },
      ),
    );
  }

  Widget _buildCooperativaCard(Map<String, String> cooperativa) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              cooperativa['imagen']!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cooperativa['nombre']!,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
