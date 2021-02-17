import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Login/data_login.dart';
import 'package:untitled/screens/Post/post.dart';

class PostPage extends StatefulWidget {
  PostPage(this.id);

  final int id;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostPage(id);
  }
}

class _PostPage extends State {
  _PostPage(this.id);

  final int id;
  String _urlGetPost = "https://testheroku11111.herokuapp.com/Post/postList";
  String urlUser = "https://testheroku11111.herokuapp.com/User/";

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[600],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Post(id)));
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
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal[200],
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Center(
                                        child: Text(
                                            "${snapshot.data[index].name_post[0]}"),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      child: Image.memory(
                                        base64Decode(snapshot.data[index].picture_user),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(
                                  '${snapshot.data[index].name_post}  ${snapshot.data[index].surname_post}'),
                              subtitle:
                                  Text("${snapshot.data[index].datePost}"),
                            ),
                            Text("${snapshot.data[index].textPost}"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    print(
                                        'User  : ${snapshot.data[index].picture_user}');
                                  },
                                  child: Text(
                                    'ถูกใจ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.orange[600],
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
                                  color: Colors.orange[600],
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
    print(dataJsonPost);
    List<Post_data> post = [];
    for (var p in dataJsonPost) {
      Post_data _post = Post_data(
          p['id'],
          p['textPost'],
          p['picturePost'],
          p['datePost'],
          p['name'],
          p['surname'],
          p['picture'],
          p['user_id']);

      post.insert(0, _post);
    }
    print('Post length : ${post.length}');
    return post;
  }
}

class Post_data {
  Post_data(
    this.id,
    this.textPost,
    this.picturePost,
    this.datePost,
    this.name_post,
    this.surname_post,
    this.picture_user,
    this.user_id,
  );

  final int id;
  final String textPost;
  final String picturePost;
  final String datePost;
  final String name_post;
  final String surname_post;
  final String picture_user;
  final int user_id;
}
