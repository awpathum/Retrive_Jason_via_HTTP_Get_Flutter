/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('http://10.22.167.36:3000/appfam');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String identityNumber;
  final String nameOfWife;
  /*final int userId;
  final int id;
  final String title;
  final String body;*/

  Post({this.identityNumber, this.nameOfWife});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      
      identityNumber: json['Identity_number'],
      nameOfWife : json['Name_of_wife'],
      /*userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],*/
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.nameOfWife);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
             // return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}*/


import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final String url = "https://swapi.co/api/people/";
  //final String url = "http://localhost:3000/appfam";

  final String url = "https://calm-sierra-62191.herokuapp.com/";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    //var response = await http.get(Uri.encodeFull(url));
    print(response.body);

    setState(() {
      print("*****");
      var convertDataToJson = jsonDecode(response.body);
      
      //var convertDataToJson = JSON.decode(response.body);
      //data = convertDataToJson["results"];
      data = convertDataToJson;
      print(data);
    }
    );
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrive Jason via HTTP Get"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Text(data[index]['Identity_number']),
                      padding: EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
