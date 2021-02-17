import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Login/data_login.dart';


class Post extends StatefulWidget {
  Post(this.id);
  final int id;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Post(id);
  }
}

class _Post extends State {
  _Post(this.id);
  final int id;
  UserLogin _userLoginPost;
  final globalKey = GlobalKey<ScaffoldState>();
  final snackBarPost0 = SnackBar(content: Text("กำลังโพสข้อความ..."));
  final snackBarPost1 = SnackBar(content: Text("โพสข้อความสำเร็จ !"));
  final snackBarPost2 = SnackBar(content: Text("โพสผิดพลาด !"));
  final snackBarPost3 =
  SnackBar(content: Text("กรุณากรอกข้อความที่ต้องการโพส !"));
  String urlApiUser = 'https://testheroku11111.herokuapp.com/User/';
  String urlApiPost =
      "https://testheroku11111.herokuapp.com/Post/post";
  String _textPost;
  TextEditingController textPost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.blueGrey,
        key: globalKey,
        body: FutureBuilder(
          future: getUserId(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return Center(child: CircularProgressIndicator());
            }
            else{
              return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
                    border: Border.all(width: 2.0, color: Colors.orange[600]),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.insert_comment,
                          color: Colors.orange[600],
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                    color: Colors.black12,
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
                  decoration: BoxDecoration(),
                  child: RaisedButton(
                    onPressed: _checkTextPost,
                    child: Text("Post"),
                    color: Colors.orange[600],
                    textColor: Colors.white,
                  ),
                ),
              ]);
            }
          },)
    );
  }

  Future<void> getUserId() async {
    var dataUser = await http.get("${urlApiUser}/${id}");
    var _dataUser = jsonDecode(utf8.decode(dataUser.bodyBytes));
    var _user = _dataUser['data'];
    _userLoginPost = UserLogin.fromJson(_user);
    print('Post User ID : ${_userLoginPost.id} Name Post : ${_userLoginPost.name}');
    return _userLoginPost;
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
    globalKey.currentState.showSnackBar(snackBarPost0);
    Map params = Map();
    params['textPost'] = _textPost.toString();
    params['picturePost'] = null.toString();
    params['name'] = _userLoginPost.name.toString();
    params['surname'] = _userLoginPost.surname.toString();
    params['picture'] = _userLoginPost.picture.toString();
    params['user_id'] = _userLoginPost.id.toString();
    http.post(urlApiPost, body: params).then((res) {
      print('connect to api post');
      print('NamePost : ${_userLoginPost.name.toString()} ${_userLoginPost.surname.toString()}');
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