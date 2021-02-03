
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/Login/loginPage.dart';
import 'package:untitled/screens/Page3.dart';
import 'package:untitled/screens/Page4.dart';
import 'package:untitled/screens/Post/postPage.dart';
import 'package:untitled/screens/Profile/editprofile.dart';
import 'package:untitled/screens/Profile/profile.dart';
import 'package:untitled/screens/Search/searchPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State {
  
  String imageProfile =
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
  String imageBackground =
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("ECP Talk !")),actions: [IconButton(icon: Icon(Icons.logout), onPressed: (){})],
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
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("ชื่อผู้ใช้",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  accountEmail: Text(
                    "E-mail ผู้ใช้",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  currentAccountPicture:
                      CircleAvatar(backgroundImage: NetworkImage(imageProfile)),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(imageBackground))),
                ),
                Card(
                  child: ListTile(tileColor: Colors.black12,
                    title: Text("MyProfile"),
                    trailing: Icon(Icons.account_circle),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                  ),
                ),
                Card(
                  child: ListTile(tileColor: Colors.black12,
                    title: Text("EditProfile"),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditProfile()));
                    },
                  ),
                ),
                Card(
                  child: ListTile(tileColor: Colors.black12,
                    title: Text("Logout"),
                    trailing: Icon(Icons.exit_to_app),
                    onTap: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            PostPage(),
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
}
