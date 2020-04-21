import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/users'),
        headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["name"]);
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
              child: ListTile(
                onTap: () {

                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://s3.amazonaws.com/uifaces/faces/twitter/marcoramires/128.jpg'),
                ),
                title: Text('Name: \n' + data[index]['name'],
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro', fontSize: 15.0)),
                trailing: Column(
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: Text('email: \n'+
                          data[index]['email'],
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro', fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
