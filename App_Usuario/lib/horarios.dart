import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'rutas.dart';

class HorariosScreen extends StatefulWidget {
  @override
  _HorariosScreenState createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen> {
  List<Horario> horarios = [];

  @override
  void initState() {
    super.initState();
    // Cargar los horarios desde la base de datos
    _loadHorarios();
  }

  Future<void> _loadHorarios() async {
    try {
      var url = Uri.parse(
          "https://us-central1-app-autobus.cloudfunctions.net/api/horario");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> listBody = json.decode(response.body);
        List<Horario> parsedHorarios =
            listBody.map((json) => Horario.fromJson(json)).toList();
        setState(() {
          horarios = parsedHorarios;
        });
      }
    } catch (ex) {
      print(ex);
    }
  }

  // Función para cambiar el color al presionar "Reservar"
  void _toggleReserva(int index) {
    setState(() {
      horarios[index].reservado = !horarios[index].reservado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Horarios de Autobuses',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (context, index) {
                  final horario = horarios[index];
                  return HorarioCard(
                    idFlota: horario.idFlota,
                    idRuta: horario.idRuta,
                    hora: horario.hora,
                    reservado: horario.reservado,
                    onReservaPressed: () {
                      _toggleReserva(index); // Cambiar el color al presionar "Reservar"
                    },
                    onMostrarRutaPressed: () {
                      // Navegar a la pantalla de la ruta
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RutasScreen(), // Reemplaza con tu pantalla de destino
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorarioCard extends StatelessWidget {
  final String idFlota;
  final String idRuta;
  final String hora;
  final bool reservado;
  final VoidCallback onReservaPressed;
  final VoidCallback onMostrarRutaPressed;

  HorarioCard({
    required this.idFlota,
    required this.idRuta,
    required this.hora,
    required this.reservado,
    required this.onReservaPressed,
    required this.onMostrarRutaPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      color: reservado ? Colors.green : Colors.white, // Cambia el color al reservar
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flota: $idFlota',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'reservar') {
                      onReservaPressed(); // Llama a la función al presionar "Reservar"
                    } else if (value == 'mostrar_ruta') {
                      onMostrarRutaPressed(); // Llama a la función al presionar "Mostrar Ruta"
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'reservar',
                      child: ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text('Reservar'),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'mostrar_ruta',
                      child: ListTile(
                        leading: Icon(Icons.map),
                        title: Text('Mostrar Ruta'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Ruta: $idRuta',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Horario: $hora',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Horario {
  final String idFlota;
  final String idRuta;
  final String hora;
  bool reservado;

  Horario({
    required this.idFlota,
    required this.idRuta,
    required this.hora,
    this.reservado = false,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      idFlota: json["idFlota"],
      idRuta: json["idRuta"],
      hora: json["hora"],
    );
  }
}
