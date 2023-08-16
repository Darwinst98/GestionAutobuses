import 'package:flutter/material.dart';

class HorariosScreen extends StatelessWidget {
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
            HorarioCard(
              ruta: 'Ruta 1',
              horario: '8:00 AM - 9:30 AM',
            ),
            HorarioCard(
              ruta: 'Ruta 2',
              horario: '10:00 AM - 11:30 AM',
            ),
            HorarioCard(
              ruta: 'Ruta 3',
              horario: '1:00 PM - 2:30 PM',
            ),
          ],
        ),
      ),
    );
  }
}

class HorarioCard extends StatelessWidget {
  final String ruta;
  final String horario;

  HorarioCard({required this.ruta, required this.horario});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Ruta: $ruta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Horario: $horario',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
