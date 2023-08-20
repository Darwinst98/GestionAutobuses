import 'package:flutter/material.dart';
import 'acciones.dart';
import 'horarios.dart';

class InicioAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla de Administrador'),
      ),
      drawer: Navigation(), // Usa tu barra lateral aquí
      body: Center(
        child: Text('Contenido de la pantalla de administrador'),
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Flotas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminCrudScreen(title: 'Flotas'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Horarios'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HorariosScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Rutas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminCrudScreen(title: 'Rutas'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
