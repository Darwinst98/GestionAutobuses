import 'dart:convert';

Horario horariosFromJson(String str) => Horario.fromJson(json.decode(str));

String horariosToJson(Horario data) => json.encode(data.toJson());

class Horario {
  Horario({
    this.idHorario,
    this.idFlota,
    this.idRuta,
    this.hora
  });

  String? idHorario;
  String? idFlota;
  String? idRuta;
  String? hora;

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        idHorario: json["idHorario"],
        idFlota: json["idFlota"],
        idRuta: json["idRuta"],
        hora: json["hora"],
      );

  factory Horario.created() => Horario();

  Map<String, dynamic> toJson() => {
        "idHorario": idHorario,
        "idFlota": idFlota,
        "idRuta": idRuta,
        "hora": hora,
      };
}
