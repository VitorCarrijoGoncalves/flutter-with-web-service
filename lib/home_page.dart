import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {

  Future<List> pegarUsuarios() async {

    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do servidor');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
      ),
      body: FutureBuilder<List>(
        future: pegarUsuarios(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar usuários'),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ListTile( 
                  //leading: CircleAvatar(
                    //backgroundColor: Colors.transparent,
                    //backgroundImage: NetworkImage(snapshot.data![index]['foto']),
                  //),
                  //title: Text('${snapshot.data![index]['title']} ${snapshot.data![index]['sobrenome']}'),
                  title: Text(snapshot.data![index]['title']),
                  //subtitle: Text(snapshot.data![index]['title']),
                  //trailing: Text(snapshot.data![index]['title']),
                );
              },);
          }

          return Center(
            child: CircularProgressIndicator(),
          );


        },
      ),
    );
  }

}