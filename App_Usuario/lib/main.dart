import 'package:flutter/material.dart';
import 'inicio.dart';
import 'horarios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barra de Búsqueda y Navegación',
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
    HorariosScreen(),
    LocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido Inicio',
          style: TextStyle(
            color: Colors.black, // Cambia el color del texto del título a negro
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.green,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(),
              );
            },
          ),
        ],
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
          selectedItemColor: Colors
              .green, // Cambia el color de los íconos seleccionados a verde
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

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementa la lógica para mostrar los resultados de búsqueda
    return Center(
      child: Text('Resultados de la búsqueda para "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implementa la lógica para mostrar sugerencias mientras el usuario escribe
    return Center(
      child: Text('Escribe la ruta deseada'),
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
