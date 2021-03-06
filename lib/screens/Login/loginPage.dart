import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/homePage.dart';
import 'package:untitled/screens/Login/data_login.dart';
import 'package:untitled/screens/Register/registerPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
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
  UserLogin userLogin;
  final globalKey = GlobalKey<ScaffoldState>();
  final user = TextEditingController();
  final pass = TextEditingController();
  String urlApiLogin = "https://testheroku11111.herokuapp.com/User/Login";
  final snackBarLoginConnect =
      SnackBar(content: Text("Please wait a moment, Logging in..."));
  final snackBarLoginFail =
      SnackBar(content: Text("กรุณาตรวจสอบ Username,Password"));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      key: globalKey,
      body: Container(
        color: Colors.blueGrey[600],
        height: 700,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      "ECP Shop !",
                      style: TextStyle(
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.orange[600],
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      "ECP Shop !",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 25.0, right: 25.0, bottom: 5.0, top: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border:
                        Border.all(width: 2.0, color: Colors.orange[600]),
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
                  margin: EdgeInsets.only(
                      left: 25.0, right: 25.0, bottom: 5.0, top: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border:
                        Border.all(width: 2.0, color: Colors.orange[600]),
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
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 0.0, top: 5.0),
                  child: RaisedButton(
                    onPressed: _toLogin,
                    child: Text("Login"),
                    color: Colors.orange[600],
                    textColor: Colors.white,
                  ),
                ),
                Container(
                    child: Text(
                  "Don't have an account ?",
                  style:
                      TextStyle(color: Colors.blueAccent, fontSize: 15),
                )),
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
                  child: RaisedButton(
                    onPressed: () {
                      print('Go To PageRegister !');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text("Register"),
                    color: Colors.white54,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*  void toLogin() {
    globalKey.currentState.showSnackBar(snackBarLoginConnect);
    Map<String, String> params = Map();
    params['username'] = user.text;
    params['password'] = pass.text;
    //String paramsString = Uri(queryParameters: params).query;
    //print(paramsString);
    //var newUrlApiLogin = urlApiLogin+'?'+paramsString;
    http.post(urlApiLogin, body: params).then((res) {
      print(res.body);

      Map _userMap = jsonDecode(res.body) as Map;
      var statusData = _userMap['status'];
      print("statusData:$statusData");

      setState(() {
        if (statusData == 1) {
          print("Login Success");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (statusData == 0) {
          globalKey.currentState.showSnackBar(snackBarLoginFail);
        } else {
          print('error not connected to API');
        }
      });
    });
  }

 */

  void _toLogin() {
    globalKey.currentState.showSnackBar(snackBarLoginConnect);
    Map params = Map();
    params['username'] = user.text;
    params['password'] = pass.text;
    http.post(urlApiLogin, body: params).then((res) {
      print("connect to API Login...");
      Map jsonDataLogin = jsonDecode(res.body) as Map;
      var statusLogin = jsonDataLogin['status'];
      var dataUserLogin = jsonDataLogin['data'];
      print("Status Data : ${statusLogin}");

      setState(() {
        if (statusLogin == 1) {
          userLogin = UserLogin.fromJson(dataUserLogin);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        userLogin.id,
                      )));
        } else if (statusLogin == 0) {
          globalKey.currentState.showSnackBar(snackBarLoginFail);
        }
      });
    });
  }
}
