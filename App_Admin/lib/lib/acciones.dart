import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoautobuses/src/models/flotas_model.dart';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:proyectoautobuses/src/service/flotas_service.dart';

class AdminCrudScreen extends StatefulWidget {
  final String title;

  AdminCrudScreen({required this.title});

  @override
  State<AdminCrudScreen> createState() => _AdminCrudScreenState();
}

class _AdminCrudScreenState extends State<AdminCrudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar ${widget.title}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _navigateToEditScreen(context);
              },
              icon: Icon(Icons.add),
              tooltip: 'Agregar ${widget.title}',
            ),
            IconButton(
              onPressed: () {
                // Lógica para editar
              },
              icon: Icon(Icons.edit),
              tooltip: 'Editar ${widget.title}',
            ),
            IconButton(
              onPressed: () {
                // Lógica para eliminar
              },
              icon: Icon(Icons.delete),
              tooltip: 'Eliminar ${widget.title}',
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FlotaService _flotaservice = FlotaService();
  late Flota _flota;

  // Declaración de variables para nombre y descripción
  String _nombre = '';
  String _descripcion = '';

  @override
  void initState() {
    super.initState();
    _flota = Flota.created();
  }

  File? _selectedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) {
                setState(() {
                  _nombre = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Descripción'),
              onChanged: (value) {
                setState(() {
                  _descripcion = value;
                });
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: _selectedImage == null
                  ? Text('Seleccionar imagen')
                  : Image.file(_selectedImage!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null) {
                  _flota.imagen = await _flotaservice.uploadImage(_selectedImage!);
                }

                // Asigna los valores de nombre y descripción a la instancia de Flota
                _flota.descripcion = _descripcion;
                _flota.nomCoperativa = _nombre;

                int estado = await _flotaservice.postFlota(_flota);
                developer.log("Estoy guardando $estado");
                if (estado == 201) {
                  final snackBar = SnackBar(
                    content: const Text('Flota Guardada...'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class HorariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla de horarios'),
      ),
    );
  }
}
