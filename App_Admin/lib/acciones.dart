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
  final FlotaService _flotaService = FlotaService();
  late List<Flota> _flotas = [];

  @override
  void initState() {
    super.initState();
    _getFlotas();
  }

  void _getFlotas() async {
    List<Flota>? flotas = await _flotaService.getFlotas();
    if (flotas != null) {
      setState(() {
        _flotas = flotas;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar ${widget.title}'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getFlotas();
        },
        child: ListView.builder(
          itemCount: _flotas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_flotas[index].nomCoperativa ?? ''),
              subtitle: Text(_flotas[index].descripcion ?? ''),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'editar') {
                    // Lógica para editar la flota
                  } else if (value == 'eliminar') {
                    // Lógica para eliminar la flota
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'editar',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'eliminar',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Eliminar'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    ).then((_) {
      // Refresh the list when returning from EditScreen
      _getFlotas();
    });
  }
}

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FlotaService _flotaService = FlotaService();
  late Flota _flota;
  String _nombre = '';
  String _descripcion = '';
  File? _selectedImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _flota = Flota();
  }

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
                  _flota.imagen =
                      await _flotaService.uploadImage(_selectedImage!);
                }
                _flota.descripcion = _descripcion;
                _flota.nomCoperativa = _nombre;
                int estado = await _flotaService.postFlota(_flota);
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
