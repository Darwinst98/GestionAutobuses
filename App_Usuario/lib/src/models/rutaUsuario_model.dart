import 'dart:convert';

Ruta rutasFromJson(String str) => Ruta.fromJson(json.decode(str));

String rutasToJson(Ruta data) => json.encode(data.toJson());

class Ruta {
  Ruta({
    this.idRuta,
    this.idFlota,
    this.destino,
    this.imagenDestino,
    this.ruta,
    this.imagen
  });

  String? idRuta;
  String? idFlota;
  String? destino;
  String? imagenDestino;
  String? ruta;
  String? imagen;

  factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
        idRuta: json["idRuta"],
        idFlota: json["idFlota"],
        destino: json["destino"],
        imagenDestino: json["imagenDestino"],
        ruta: json["ruta"],
        imagen: json["imagen"],
      );

  factory Ruta.created() => Ruta();

  Map<String, dynamic> toJson() => {
        "idRuta": idRuta,
        "idFlota": idFlota,
        "destino": destino,
        "imagenDestino": imagenDestino,
        "ruta": ruta,
        "imagen": imagen
      };
}
