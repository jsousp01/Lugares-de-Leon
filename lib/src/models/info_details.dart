import 'dart:convert';

Detalles detallesFromJson(String str) => Detalles.fromJson(json.decode(str));

class Detalles {
    Detalles({
        this.idDetalle,
        required this.idFicha,
        required this.nombre,
        this.descripcionCorta,
        required this.descripcion,
        this.fechaInicio,
        this.horaInicio,
        this.fechaFin,
        this.horaFin,
        this.idIdioma,
        this.idImagen,
        this.latitud,
        this.longitud,
        this.direccion,
        this.email,
        this.telefono,
        this.importancia,
        this.urlImagen,
        this.media,
        this.rutas,
        this.promociones,
        this.subFichas,
    });

    int ?idDetalle;
    int idFicha;
    String nombre;
    String ?descripcionCorta;
    String descripcion;
    dynamic fechaInicio;
    dynamic horaInicio;
    dynamic fechaFin;
    dynamic horaFin;
    int? idIdioma;
    int? idImagen;
    double? latitud;
    double? longitud;
    String? direccion;
    String? email;
    String? telefono;
    int? importancia;
    String? urlImagen;
    Media? media;
    List<Ruta>? rutas;
    List<dynamic>? promociones;
    List<Detalles>? subFichas;

    factory Detalles.fromJson(Map<String, dynamic> json) => Detalles(
        idDetalle: json["idDetalle"],
        idFicha: json["idFicha"],
        nombre: json["nombre"],
        descripcionCorta: json["descripcionCorta"],
        descripcion: json["descripcion"],
        fechaInicio: json["fechaInicio"],
        horaInicio: json["horaInicio"],
        fechaFin: json["fechaFin"],
        horaFin: json["horaFin"],
        idIdioma: json["idIdioma"],
        idImagen: json["idImagen"],
        latitud: json["latitud"] == null ? null : json["latitud"].toDouble(),
        longitud: json["longitud"] == null ? null : json["longitud"].toDouble(),
        direccion: json["direccion"] == null ? null : json["direccion"],
        email: json["email"] == null ? null : json["email"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        importancia: json["importancia"],
        urlImagen: json["urlImagen"],
        media: Media.fromJson(json["media"]),
        rutas: List<Ruta>.from(json["rutas"].map((x) => Ruta.fromJson(x))),
        promociones: List<dynamic>.from(json["promociones"].map((x) => x)),
        subFichas: List<Detalles>.from(json["subFichas"].map((x) => Detalles.fromJson(x))),
    );
}

class Media {
    Media({
        this.images,
        this.audios,
        this.videos,
        this.links,
    });

    List<String>? images;
    List<String>? audios;
    List<String>? videos;
    List<dynamic>? links;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        images: List<String>.from(json["images"].map((x) => x)),
        audios: List<String>.from(json["audios"].map((x) => x)),
        videos: List<String>.from(json["videos"].map((x) => x)),
        links: List<dynamic>.from(json["links"].map((x) => x)),
    );
}

class Ruta {
    Ruta({
        this.idRuta,
        this.nombre,
        this.descripcion,
    });

    int? idRuta;
    String? nombre;
    String? descripcion;

    factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
        idRuta: json["idRuta"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );
}
