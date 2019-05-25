import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Comment>> fetchTodos(int postid) async {
  final response = await http
      .get('https://jsonplaceholder.typicode.com/posts/${postid}/comments');

  List<Comment> todoApi = [];

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      var todo = Comment.fromJson(body[i]);
      if (todo.postId == postid) {
        todoApi.add(todo);
      }
    }
    print(todoApi.length);
    return todoApi;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}

class CommentPost extends StatelessWidget {
  // Declare a field that holds the Todo
  final int id;
  // final int album_id;
  // In the constructor, require a Todo
  CommentPost({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: fetchTodos(this.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return createListView(context, snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Comment> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5),
            child: new Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Text(
                      '${(values[index].postId).toString()} : ${values[index].id}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      '${(values[index].body).toString()}',
                      style:
                          TextStyle(fontSize: 18),
                    ),
                     Text(
                      '${(values[index].name).toString()}',
                      style:
                          TextStyle(fontSize: 18),
                    ),
                    Text(
                      '(${(values[index].email).toString()})',
                      style:
                          TextStyle(fontSize: 18),
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
