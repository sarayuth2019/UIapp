import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/mainPage.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Post();
  }
}

class _Post extends State {
  final globalKey = GlobalKey<ScaffoldState>();
  final snackBarPost1 = SnackBar(content: Text("โพสข้อความสำเร็จ !"));
  final snackBarPost2 = SnackBar(content: Text("โพสผิดพลาด !"));
  final snackBarPost3 = SnackBar(content: Text("กรุณากรอกข้อความที่ต้องการโพส !"));
  String urlApiPost =
      "https://api-application-project-final.herokuapp.com//Post/post";
  int _id = 1;
  String _namePost = "wanmongkon";
  String _surNamePost = "keawhanam";
  String _textPost;
  TextEditingController textPost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
            border: Border.all(width: 2.0, color: Colors.black38),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.insert_comment,
                  color: Colors.teal,
                ),
                title: TextField(
                  controller: textPost,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "กรุณาใส่ข้อความ",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
          decoration: BoxDecoration(),
          child: RaisedButton(
            onPressed: _checkTextPost,
            child: Text("Post"),
            color: Colors.teal,
            textColor: Colors.white,
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
          decoration: BoxDecoration(),
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("Go back"),
            color: Colors.black12,
            textColor: Colors.white,
          ),
        ),
      ]),
    );
  }

  void _checkTextPost() {
    _textPost = textPost.text;
    setState(() {
      if (_textPost.length != 0) {
        _sendPostToDB();
      } else if (_textPost.length == 0) {
        print("Don't post Text not null !");
        return globalKey.currentState.showSnackBar(snackBarPost3);
      }
    });
  }

  void _sendPostToDB() {
    Map params = Map();
    params['id'] = _id.toString();
    params['name_post'] = _namePost.toString();
    params['surname_post'] = _surNamePost.toString();
    params['textpost'] = _textPost.toString();
    http.post(urlApiPost, body: params).then((res) {
      print('connect to api post');
      print('NamePost : ${_namePost.toString()} ${_surNamePost.toString()}');
      print('TextPost : ${_textPost.toString()}');
      print(res.body);
      Map _dataPost = jsonDecode(res.body) as Map;
      var _statusPost = _dataPost['status'];
      print("StatusPost : ${_statusPost}");
      setState(() {
        if (_statusPost == 1) {
          globalKey.currentState.showSnackBar(snackBarPost1);
        } else {
          return globalKey.currentState.showSnackBar(snackBarPost2);
        }
      });
    });
  }
}
