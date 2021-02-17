import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/Login/data_login.dart';
import 'package:untitled/screens/Login/loginPage.dart';
import 'package:untitled/screens/Page3.dart';
import 'package:untitled/screens/Page4.dart';
import 'package:untitled/screens/Post/postPage.dart';
import 'package:untitled/screens/Profile/editprofile.dart';
import 'package:untitled/screens/Profile/profile.dart';
import 'package:untitled/screens/Search/searchPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage(
    this.id,
  );

  final int id;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage(id);
  }
}

class _HomePage extends State {
  _HomePage(
    this.id,
  );

  final int id;
  UserLogin _userLogin;
  String urlUser = "https://testheroku11111.herokuapp.com/User/";
  String imageProfile =
      "https://ecp.eng.rmuti.ac.th/wp-content/uploads/2019/12/40554453_1853273344768778_1816059919623782400_n.jpg";

  @override
  Widget build(BuildContext context) {
    print("HomePage ID Login : ${id}");
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("ECP Talk !")),
            actions: [
              IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
            ],
            backgroundColor: Colors.orange[600],
            bottom: TabBar(tabs: <Widget>[
              Tab(
                text: "หน้าหลัก",
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "ผู้คน",
                icon: Icon(Icons.supervisor_account, color: Colors.white),
              ),
              Tab(
                text: "แจ้งเตือน",
                icon: Icon(Icons.notifications_active, color: Colors.white),
              ),
              Tab(
                text: "ข้อความ",
                icon: Icon(Icons.mail, color: Colors.white),
              ),
            ]),
          ),
          drawer: FutureBuilder(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Drawer(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: UserAccountsDrawerHeader(
                          accountName: Text(_userLogin.username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          accountEmail: Text(
                            _userLogin.email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.teal[200],
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                    child: Text(
                                      "${_userLogin.name[0]}",
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    base64Decode(_userLogin.picture),
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imageProfile))),
                        ),
                      ),
                      Container(
                        color: Colors.blueGrey,
                        height: 500,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.orange[600],
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("MyProfile",
                                    style: TextStyle(color: Colors.white)),
                                trailing: Icon(Icons.account_circle,
                                    color: Colors.white),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(id)));
                                },
                              ),
                            ),
                            Card(
                              color: Colors.orange[600],
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("EditProfile",
                                    style: TextStyle(color: Colors.white)),
                                trailing: Icon(Icons.edit, color: Colors.white),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                },
                              ),
                            ),
                            Card(
                              color: Colors.orange[600],
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("Logout",
                                    style: TextStyle(color: Colors.white)),
                                trailing: Icon(Icons.exit_to_app,
                                    color: Colors.white),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
          body: TabBarView(children: <Widget>[
            PostPage(id),
            SearchPage(),
            Page3(),
            Page4(),
          ]),
        ),
        length: 4,
        initialIndex: 0,
      ),
    );
  }

  Future<void> getUser() async {
    var dataUser = await http.get("${urlUser}/${id}");
    var _dataUser = jsonDecode(utf8.decode(dataUser.bodyBytes));
    var _user = _dataUser['data'];
    _userLogin = UserLogin.fromJson(_user);
    print('user id homepage : ${_userLogin.id}');
    return _userLogin;
  }
}
