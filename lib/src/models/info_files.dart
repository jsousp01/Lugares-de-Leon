
class DatosFichas{

  String idFicha = '';
  String nombre = '';
  String descripcionCorta = '';
  String urlImagen = '';

  DatosFichas(this.idFicha, this.nombre, this.descripcionCorta, this.urlImagen);

  DatosFichas.fromJson(Map<String, dynamic> json){
    idFicha = json['idFicha'].toString();
    nombre = json['nombre'];
    descripcionCorta = json['descripcionCorta'];
    urlImagen = json['urlImagen'];
  }

  @override
  String toString() {
    return idFicha;
  }
}