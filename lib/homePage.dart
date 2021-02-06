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
    print("ID Login HomePage : ${id}");
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
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("ECP Talk !")),
            actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
            backgroundColor: Colors.teal,
            bottom: TabBar(tabs: <Widget>[
              Tab(
                text: "หน้าหลัก",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "ค้นหา",
                icon: Icon(Icons.search),
              ),
              Tab(
                text: "แจ้งเตือน",
                icon: Icon(Icons.notifications_active),
              ),
              Tab(
                text: "ข้อความ",
                icon: Icon(Icons.mail),
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
                        child: UserAccountsDrawerHeader(
                          accountName: Text(_userLogin.username,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          accountEmail: Text(
                            _userLogin.email,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: MemoryImage(base64Decode(_userLogin.picture)),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imageProfile))),
                        ),
                      ),
                      Container(color: Colors.teal,
                        height: 500,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white70,
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("MyProfile"),
                                trailing: Icon(Icons.account_circle),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(id)));
                                },
                              ),
                            ),
                            Card(
                              color: Colors.white70,
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("EditProfile"),
                                trailing: Icon(Icons.edit),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                },
                              ),
                            ),
                            Card(
                              color: Colors.white70,
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text("Logout"),
                                trailing: Icon(Icons.exit_to_app),
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
