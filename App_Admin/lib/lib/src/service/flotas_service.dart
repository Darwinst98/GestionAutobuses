import 'dart:io';


import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/flotas_model.dart';

class FlotaService {
  FlotaService();
  final String _rootUrl =
      "https://us-central1-app-autobus.cloudfunctions.net/api/flota";

  Future<String> uploadImage(File image) async {
    final cloudinary =
        CloudinaryPublic('dlyytqayv', 'image_1', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image,
            folder: "flotas/"),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      return "" + e.toString();
    }
  }

  Future<int> postFlota(Flota flota) async {
    try {
      var uri = Uri.parse(_rootUrl);
      String _FlotaBody = flotasToJson(flota);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response =
          await http.post(uri, headers: _headers, body: _FlotaBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      return result;
    } catch (ex) {
      return 500;
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

  Future<int> putFlota(Flota flota) async {
    try {
      var uri = Uri.parse(_rootUrl);
      String _FlotaBody = flotasToJson(flota);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response =
          await http.put(uri, headers: _headers, body: _FlotaBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      return result;
    } catch (ex) {
      return 500;
    }
  }

  Future<int> deleteFlota(Flota flota) async {
    try {
      var uri = Uri.parse(_rootUrl);
      String _FlotaBody = flotasToJson(flota);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response =
          await http.delete(uri, headers: _headers, body: _FlotaBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      return result;
    } catch (ex) {
      return 500;
    }
  }
}

