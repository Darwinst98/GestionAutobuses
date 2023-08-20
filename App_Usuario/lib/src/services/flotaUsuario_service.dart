import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/flotaUsuario_model.dart';

class FlotaService {
  FlotaService();
  final String _rootUrl =
      "https://us-central1-app-autobus.cloudfunctions.net/api/flota";

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

  Future<List<Flota>?> getFlotas() async {
    List<Flota> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final flota = Flota.fromJson(item);
        result.add(flota);
      }
      return result;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return result;
    }
  }
}
