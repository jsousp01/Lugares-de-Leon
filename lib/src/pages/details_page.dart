import 'package:aplicacion1/src/models/info_details.dart';
import 'package:aplicacion1/src/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DetailsPage extends StatefulWidget{
 
  static final String routeName = 'details';
  
  String id;
  DetailsPage(this.id);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}


class _DetailsPageState extends State<DetailsPage> {

  final prefs = UserPreferences();
  List<String>? _listaDeFavoritos = [];
  Color _iconColor = Colors.white;

  Future<Detalles>? _detailsModel;
  Future<Detalles> obtenerDatos() async {

    String idFicha = widget.id;

    var url = Uri.parse('https://tuciudaddecerca-api.proconsi.com/Ficha?idFicha=$idFicha&TipoFicha=F&idIdioma=0&idProyecto=1');
    var response = await http.get(url);
    var jsonString = response.body;
    var jsonMap = json.decode(jsonString);
    var detailsModel = Detalles.fromJson(jsonMap);
    
    return detailsModel;
  }

  @override
  void initState() {
    _detailsModel = obtenerDatos();
    _listaDeFavoritos = prefs.getStringList('lista');

    super.initState();
  }

  void _setFavoritos(BuildContext context, String id) async{

    if(_listaDeFavoritos!.contains(id)) {
      _listaDeFavoritos!.remove(id);
      prefs.setStringList('lista', _listaDeFavoritos!);
      _showSnackBar(context, 'La ficha ha sido eliminada de tu lista de favoritos');
      
    } else {
      _listaDeFavoritos!.add(id);
      prefs.setStringList('lista', _listaDeFavoritos!);
      _showSnackBar(context, 'La ficha ha sido añadida a tu lista de favoritos');
    }
  }

  void _showSnackBar(BuildContext context, String mensaje) async {
    final snackBar = SnackBar(content: Text(mensaje), duration: Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    
    String idFicha = widget.id;
    //Obtener la id por paso de parametros por ruta
    //String idFicha = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: (_setColorBoton(idFicha))),
            tooltip: 'Añadir página a Favoritos',
            onPressed: () {
              _setFavoritos(context, idFicha);
              setState(() {
                _setColorBoton(idFicha);
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<Detalles>(
        future: _detailsModel,
        builder: (context, snapshot) {
          //Si llega información
          if(snapshot.hasData){
            return _contenidoPantalla(snapshot);

          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  MaterialColor _setColorBoton(String id) { 
    if(_listaDeFavoritos!.contains(id)) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Card _contenidoPantalla(AsyncSnapshot<Detalles> snapshot) {
    
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Nombre: ', style: TextStyle(fontSize: 18)),
              Text(snapshot.data!.nombre, style: TextStyle(fontSize: 16)),            
              SizedBox(height: 2),

              Text('Descripción: ', style: TextStyle(fontSize: 18)),
              Text(snapshot.data!.descripcion, style: TextStyle(fontSize: 16)),            
              SizedBox(height: 2),

              Text('Dirección: ', style: TextStyle(fontSize: 18)),
              Text(snapshot.data!.direccion!, style: TextStyle(fontSize: 16)),
              SizedBox(height: 2),

              Text('E-mail: ', style: TextStyle(fontSize: 18)),
              if(snapshot.data!.email!=null) 
                Text(snapshot.data!.email!, style: TextStyle(fontSize: 16))
              else
                Text('-', style: TextStyle(fontSize: 16)),
              SizedBox(height: 2),

              Text('Teléfono: ', style: TextStyle(fontSize: 18)),
              if(snapshot.data!.telefono!=null) 
                Text(snapshot.data!.telefono!, style: TextStyle(fontSize: 16))
              else
                Text('-', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              
              _listaFotos(snapshot),
            ],
          ),
        )
      )
    );
  }

  Container _listaFotos(AsyncSnapshot<Detalles> snapshot) {
    
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.media!.images!.length,
        itemBuilder: (context, index) {
          return Image.network(
            snapshot.data!.media!.images![index],
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          );
        }
      )
    );
  }

}