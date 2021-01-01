import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/loginPage.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPage();
  }
}

class _RegisterPage extends State {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _checkData = false;
  String username, password, confirmPassword, name, surname, email;
  TextEditingController pass = TextEditingController();
  //วันเดือนปี
  DateTime _birthdate;

  var scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _birthdate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.teal,
          title: new Text('Register'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              // ignore: deprecated_member_use
              autovalidate: _checkData,
              child: pageUI(),
            ),
          ),
        ),
      ),
    );
  }

// หน้าแสดง UI
  Widget pageUI() {
    return new Column(
      children: [
        Text(
          "สมัคสมาชิก",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          maxLength: 12,
          validator: validateUsername,
          decoration: InputDecoration(hintText: "Username"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.next,
          onSaved: (String val) {
            username = val;
          },
        ),
        TextFormField(
          controller: pass,
          maxLength: 12,
          validator: validatePassword,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.next,
          onSaved: (String val) {
            password = val;
          },
        ),
        TextFormField(
          maxLength: 12,
          validator: validateConfirmPass,
          obscureText: true,
          decoration: InputDecoration(hintText: "ConfirmPassword"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.next,
          onSaved: (String val) {
            confirmPassword = val;
          },
        ),
        TextFormField(
          maxLength: 32,
          validator: validateName,
          decoration: InputDecoration(hintText: "Name"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.next,
          onSaved: (String val) {
            name = val;
          },
        ),
        TextFormField(
          maxLength: 32,
          validator: validateSurname,
          decoration: InputDecoration(hintText: "Surname"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.next,
          onSaved: (String val) {
            surname = val;
          },
        ),
        TextFormField(
          maxLength: 32,
          validator: validateEmail,
          decoration: InputDecoration(hintText: "Email"),
          keyboardType: TextInputType.text,
          textInputAction:TextInputAction.done,
          onSaved: (String val) {
            email = val;
          },
        ),
        ListTile(
            title: Text(
                "วัน-เดือน-ปีเกิด: ${_birthdate.day}-${_birthdate.month}-${_birthdate.year}"),
            trailing: Icon(Icons.date_range),
            onTap: selectData),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.teal,
                onPressed: _sendToCheckText,
                child: Text(
                  "สมัคสาชิก",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

//ใส่วันเดือนปีเกิด/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  selectData() async {
    DateTime birthday = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 60),
      initialDate: _birthdate,
    );
    if (birthday != null)
      setState(() {
        _birthdate = birthday;
      });
  }

//เช็ค text ที่เข้ามา
  String validateUsername(String value) {
    String pattern = r'(^[a-zA-Z0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "กรุณากรอกชื่อผู้ใช้";
    } else if (!regExp.hasMatch(value)) {
      return "ชื่อผู้ใช้ต้องใช้ตัวอักษร a-z,A-Z,0-1 เท่านั้น";
    } else if (value.length < 6) {
      return "กรุณากรอกชื่อผู้ใช้ 6-12 ตัว";
    } else if (value.length > 12) {
      return "กรุณากรอกชื่อผู้ใช้ 6-12 ตัว";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "กรุณากรอกพาสเวิร์ด";
    } else if (value.length < 6) {
      return "กรุณากรอกพาสเวิร์ด 6-12 ตัว";
    } else if (value.length > 12) {
      return "กรุณากรอกพาสเวิร์ด 6-12 ตัว";
    } else {
      return null;
    }
  }

  String validateConfirmPass(String value) {
    if (value.length == 0) {
      return "กรุณากรอกพาสเวิร์ดให้ตรงกัน";
    } else if (value != pass.text) {
      return "กรุณากรอกพาสเวิร์ดให้ตรงกัน";
    }
    return null;
  }

  String validateName(String value) {
    if (value.length == 0) {
      return "กรุณากรอกชื่อ";
    } else {
      return null;
    }
  }

  String validateSurname(String value) {
    if (value.length == 0) {
      return "กรุณากรอกนามสกุล";
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "กรุณากรอกอีเมล";
    } else if (!regExp.hasMatch(value)) {
      return "รูปแบบอีเมลไม่ถูกต้อง";
    }
    return null;
  }

  _sendToCheckText() {
    if (_key.currentState.validate()) {
      // No error
      _key.currentState.save();
      print("Username $username");
      print("Password $password");
      print("Email $email");
      print("birthday $_birthdate");
      saveToDB();
    } else {
      //Have error
      setState(() {
        _checkData = true;
        print("Fill out the form correctly");
      });
    }
  }

  void saveToDB() {
    //ส่งค่าไปยัง api
    Map params = Map();
    params['username'] = username.toString();
    params['password'] = password.toString();
    params['name'] = name.toString();
    params['surname'] = surname.toString();
    params['email'] = email.toString();
    params['birthday'] = _birthdate.toString();
    http
        .post(
            'https://api-application-project-final.herokuapp.com/Register/register',
            body: params)
        .then((res) {
      print(res.body);

      //นำค่าจาก aip มาใช้
      Map _registerMap = jsonDecode(res.body) as Map;
      var registerStatus = _registerMap['status'];
      print(registerStatus);

      setState(() {
        if (registerStatus == 1) {
          print("register Success !");
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else if (registerStatus == 0) {
          print("username Duplicate !");
          scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Username นี้มีผู้ใช้แล้ว')));
        } else {
          print('State error');
        }
      });
    });
  }
}
