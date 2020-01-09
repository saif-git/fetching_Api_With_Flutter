import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:async/async.dart';
void main() => runApp(new MaterialApp(
  home :new HomePage(),
));

class HomePage extends StatefulWidget{

  @override
  HomePageState createState()=>new HomePageState();
}

class HomePageState extends State<HomePage>{
final String url="https://jsonplaceholder.typicode.com/posts";

List data;

@override
void initState(){
  super.initState();
  this.getJsonData();
}

Future <String> getJsonData() async{
  var response = await http.get(
    Uri.encodeFull(url),
    headers: {"Accept":"Application/json"}
  );

  //print(response.body);

  setState((){
    var convertDateToJson = jsonDecode(response.body);
   // print(convertDateToJson);
    //data = convertDateToJson['title'];
    data = convertDateToJson;
    print(data);

  });
  return 'Success';
}

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar : new AppBar(
        title : new Text("data")
      ),

      body : new ListView.builder(
        itemCount:data == null ?0 :data.length,
        itemBuilder : (BuildContext context,int index){
          return new Container(
            child: new Center(

              child : new Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child : new Text(
                        data[index]['title']
                      ),
                      padding: new EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

      ),
    );
  }
}