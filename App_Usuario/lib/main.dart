import 'package:flutter/material.dart';
import 'inicio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barra de Navegación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    InicioScreen(),
    RoutesScreen(),
    ScheduleScreen(),
    LocationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido Inicio',
          style: TextStyle(
            color: Colors.black, // Cambia el color del texto del título a rojo
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green, // Cambia el color de fondo a verde aquí
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor:
              Colors.green, // Cambia el color de los íconos a blanco
          unselectedItemColor: Colors
              .black, // Cambia el color de los íconos no seleccionados a blanco
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Rutas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Horarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Localización',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página de Inicio',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class RoutesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página de Rutas',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página de Horarios',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página de Localización',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
