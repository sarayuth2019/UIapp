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
      backgroundColor: Colors.black12,
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text(
                                  '${snapshot.data[index].name_post}  ${snapshot.data[index].surname_post}'),
                              subtitle: Text(snapshot.data[index].datePost),
                            ),
                            Text(snapshot.data[index].textpost),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'ถูกใจ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.teal,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'พูดคุย',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.teal,
                                ),
                              ],
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
    var jsonDataPost = jsonDecode(utf8.decode(_data.bodyBytes));
    print('Connect Success !');

    var dataJsonPost = jsonDataPost['data'];
    print('Data Post : ${dataJsonPost}');

    List<Post_data> post = [];
    for (var p in dataJsonPost) {
      Post_data _post = Post_data(p["id"], p["name_post"], p["surname_post"],
          p["textpost"], p["datePost"]);
      post.insert(0, _post);
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
