import 'package:aplicacion1/src/models/info_files.dart';
import 'package:aplicacion1/src/pages/details_page.dart';
import 'package:aplicacion1/src/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget{
 
  static final String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

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
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Fichas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          for (var i = 0; i < data.length; i++) _crearCard(context, i),
        ],
      ),
      drawer: _crearMenuLateral(context),
    );
  }


  Widget _crearCard(BuildContext context, int index) {

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
                  //Enviar informacion por ruta
                  //Navigator.pushNamed(context, DetailsPage.routeName, arguments: data[index].idFicha);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(data[index].idFicha),
                    ),
                  );
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