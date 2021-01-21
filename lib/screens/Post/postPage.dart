import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Post/post.dart';

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostPage();
  }
}

class _PostPage extends State {
  String _urlGetPost =
      "https://api-application-project-final.herokuapp.com/Post/postList";

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Post()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: _getPost(),
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('Snapshot : ${{snapshot.data}}');
              if (snapshot.data == null) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int id) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text(
                                  '${snapshot.data[id].name_post}  ${snapshot.data[id].surname_post}'),
                              subtitle: Text(snapshot.data[id].datePost),
                            ),
                            Text(snapshot.data[id].textpost),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }

  Future<List<Post_data>> _getPost() async {
    print('connect to api get Post');

    var _data = await http.get(_urlGetPost);
    var jsonDataPost = jsonDecode(_data.body);
    print('Connect Success !');

    var dataJsonPost = jsonDataPost['data'];
    print('Data Post : ${dataJsonPost}');

    List<Post_data> post = [];
    for (var u in dataJsonPost) {
      Post_data _post = Post_data(u["id"], u["name_post"], u["surname_post"],
          u["textpost"], u["datePost"]);

      post.add(_post);
    }
    print('Post length : ${post.length}');
    return post;
  }
}

class Post_data {
  final int id;
  final String name_post;
  final String surname_post;
  final String textpost;
  final String datePost;

  Post_data(
      this.id, this.name_post, this.surname_post, this.textpost, this.datePost);
}
