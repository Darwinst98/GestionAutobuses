// To parse this JSON data, do
//
//     final Flotas = FlotasFromJson(jsonString);

import 'dart:convert';

Flota flotasFromJson(String str) => Flota.fromJson(json.decode(str));

String flotasToJson(Flota data) => json.encode(data.toJson());

class Flota {
  Flota({
    this.idFlota,
    this.nomCoperativa,
    this.descripcion,
    this.imagen,
  });

  String? idFlota;
  String? nomCoperativa;
  String? descripcion;
  String? imagen;

  factory Flota.fromJson(Map<String, dynamic> json) => Flota(
        idFlota: json["idFlota"],
        nomCoperativa: json["nomCoperativa"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
      );

  factory Flota.created() => Flota();

  Map<String, dynamic> toJson() => {
        "idFlota": idFlota,
        "nomCoperativa": nomCoperativa,
        "descripcion": descripcion,
        "imagen": imagen
      };
}
