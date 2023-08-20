import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/rutaUsuario_model.dart';

class RutaService {
  RutaService();
  final String _rootUrl =
      "https://us-central1-app-autobus.cloudfunctions.net/api/ruta";

  Future<String> uploadImage(File image) async {
    final cloudinary = CloudinaryPublic('dlyytqayv', 'image_1', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image, folder: "flotas/"),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      return "" + e.toString();
    }
  }

  Future<List<Ruta>?> getRutas() async {
    List<Ruta> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final ruta = Ruta.fromJson(item);
        result.add(ruta);
      }
      return result;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return result;
    }
  }
}
