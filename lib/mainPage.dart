
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/TopSaga/Desktop/UIApp/lib/Login/loginPage.dart';
import 'package:untitled/screens/Page1.dart';
import 'package:untitled/screens/Page2.dart';
import 'package:untitled/screens/Page3.dart';
import 'package:untitled/screens/Page4.dart';
import 'package:untitled/screens/editprofile.dart';
import 'package:untitled/screens/post.dart';
import 'package:untitled/screens/profile.dart';



class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State {
  String imageProfile = "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
  String imageBackground = "https://www.jpl.nasa.gov/images/spitzer/20190827/3-PIA10181-640x309.jpg";
  //เงื่อนไข logout
  void logout() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text("AppPro"),
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
                  accountName: Text("ชื่อผู้ใช้",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  accountEmail: Text("E-mail ผู้ใช้",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ),),
                  currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(imageProfile)),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(imageBackground)
                      )
                  ),
                ),
                ListTile(
                  title: Text("MyProfile"),
                  trailing: Icon(Icons.account_circle),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile()));
                  },
                ),
                ListTile(
                  title: Text("EditProfile"),
                  trailing: Icon(Icons.edit),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile()));
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: (){
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),









          body: TabBarView(children: <Widget>[
            Page1(),
            Page2(),
            Page3(),
            Page4(),
          ]),
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
        ),
        length: 4,
        initialIndex: 0,
      ),
    );
  }
}
