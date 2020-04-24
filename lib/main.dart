import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_api/api.dart';
import 'package:my_api/details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UsersListScreen(),
    );
  }
}

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    throw UnimplementedError();
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Center(child: Text('My Contacts')),
      ),
      body: Card(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                                child: ListTile(
                    leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://scx2.b-cdn.net/gfx/news/hires/2018/1-detectingfak.jpg'),
                ),
                    title: Text(users[index].name, style: TextStyle(fontFamily: 'Source Sans Pro',),),
                    subtitle: Text(users[index].email),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(),
                            settings: RouteSettings(
                                arguments: users[index],
                            ),
                          ));
                    }),
                              ),
              );
            }),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    throw UnimplementedError();
    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: new Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(radius: 150.0,
                  backgroundImage: NetworkImage(
                      'https://scx2.b-cdn.net/gfx/news/hires/2018/1-detectingfak.jpg'),
                ),
              SizedBox(height: 25.0),
              new Text(
                'Name: ' + user.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              SizedBox(height: 10.0),
              new Text(
                ' Username: ' + user.username,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(height: 10.0),
              new Text(
                'Email: ' + user.email,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              SizedBox(height: 10.0),
              new Text(
                'Phone: ' + user.phone,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
