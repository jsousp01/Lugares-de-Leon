import 'package:aplicacion1/src/models/info_files.dart';
import 'package:aplicacion1/src/pages/details_page.dart';
import 'package:aplicacion1/src/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class FavoritesPage extends StatefulWidget{
 
  static final String routeName = 'favorites';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}


class _FavoritesPageState extends State<FavoritesPage> {

  List<String>? _listaDeFavoritos = [];
  final prefs = UserPreferences();

  List<DatosFichas> data = <DatosFichas>[];
  Future<List<DatosFichas>> obtenerDatos() async {
    
    var url = Uri.parse('https://tuciudaddecerca-api.proconsi.com/Categoria?idCategoriaPadre=30&idIdioma=0&idProyecto=1');
    var response = await http.get(url);
    var datos = json.decode(response.body);
    var registros = <DatosFichas>[];

    for(datos in datos['fichas']){
      registros.add(DatosFichas.fromJson(datos));
    }

    return registros;
  }

  @override
  void initState() {

    super.initState();
    obtenerDatos().then((value){
      setState((){
        data.addAll(value);
      });
    });
    _update();
  }

  void _update() async {
    _listaDeFavoritos = prefs.getStringList('lista');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Favoritos'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[          
          if(data.isNotEmpty) 
            for (var i = 0; i < _listaDeFavoritos!.length; i++) _crearCard(context, i),
        ],
      ),
      drawer: _crearMenuLateral(context),
    );
  }


  Widget _crearCard(BuildContext context, int index) {

    //Buscar en que posición dentro de [data] se encuentra cada ficha de la lista de favoritos
    String idFicha = _listaDeFavoritos![index].toString();
    index = data.indexWhere(((element) => element.idFicha == idFicha));

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image(image: NetworkImage(data[index].urlImagen)),
            title: Text(data[index].nombre),
            subtitle: Text(data[index].descripcionCorta),
            trailing: TextButton(
                child: Text('Ver ficha'),
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      //Ir a página de detalles y actualizar esta después por si ha cambiado la lista de favoritos
                      builder: (context) => DetailsPage(data[index].idFicha))).then((value) {
                        setState(() {
                          _update();
                        });
                      });
                },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


  Drawer _crearMenuLateral(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Google-flutter-logo.png/799px-Google-flutter-logo.png')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.blue),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            title: Text('Favoritos'),
            onTap: (){ 
              Navigator.pop(context);
              Navigator.pushNamed(context, FavoritesPage.routeName);
            }
          ),
        ],
      ),
    );
  }

}