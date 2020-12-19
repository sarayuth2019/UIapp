import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/TopSaga/Desktop/UIApp/lib/RegisterPage/registerPage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/main.dart';

void main() => runApp(MaterialApp(
      home: LoginPage(),
    ));

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login();
  }
}

class _Login extends State {
  final globalKey = GlobalKey<ScaffoldState>();
  final user = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold( key: globalKey,
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(margin: EdgeInsets.only(top:110,bottom: 40),
              child: Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    "Let's Talk !",
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.teal,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    "Let's Talk !",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
            Container(
              margin:
                  EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5.0, top: 5.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
                border: Border.all(width: 2.0, color: Colors.black38),
              ),
              child: TextField(
                controller: user,
                decoration: InputDecoration(
                    hintText: "Username",
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    icon: Icon(Icons.account_circle)),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5.0, top: 5.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
                border: Border.all(width: 2.0, color: Colors.black38),
              ),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    icon: Icon(Icons.vpn_key)),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 5.0),
              decoration: BoxDecoration(),
              child: RaisedButton(
                onPressed: toLogin,
                child: Text("Login"),
                color: Colors.teal,
                textColor: Colors.white,
              ),
            ),
            Container(
                child: Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.blueAccent, fontSize: 15),
            )),
            Container(
              margin:
                  EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
              decoration: BoxDecoration(),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("Register"),
                color: Colors.black12,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void toLogin() {
    Map params = Map();
    params['username'] = user.text;
    params['password'] = pass.text;
    http
        .post('https://api-application-project-final.herokuapp.com/Login/login',
            body: params)
        .then((res) {
      print(res.body);

      Map _userMap = jsonDecode(res.body) as Map;
      var statusData = _userMap['status'];
      print(statusData);

      final snackBar = SnackBar(content: Text('กรุณาตรวจสอบ Username,Password'));

      setState(() {
        if (statusData == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));

        }else if (statusData == 0 ){
          globalKey.currentState.showSnackBar(snackBar);
        }
          else{print('State error');}

      });
    });
  }
}
