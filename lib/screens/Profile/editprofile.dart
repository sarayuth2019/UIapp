import 'package:flutter/material.dart';


class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProfile();
  }
}

class _EditProfile extends State {
  String imageProfile =
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
  String imageBackground =
      "https://www.jpl.nasa.gov/images/spitzer/20190827/3-PIA10181-640x309.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageBackground),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(imageProfile),
                            maxRadius: 70,
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: "ชื่อผู้ใช้"),
                        ),
                        trailing: Icon(Icons.edit)),
                    ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: "E-mail"),
                        ),
                        trailing: Icon(Icons.edit)),
                    ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: "ติดต่อ"),
                        ),
                        trailing: Icon(Icons.edit)),
                    ListTile(
                        title: TextField(
                          decoration:
                              InputDecoration(hintText: "วัน-เดือน-ปีเกิด"),
                        ),
                        trailing: Icon(Icons.edit)),
                    ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: "อื่นๆ"),
                        ),
                        trailing: Icon(Icons.edit)),
                    ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: "อื่นๆ"),
                        ),
                        trailing: Icon(Icons.edit)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                        child: Text("บันทึก"),
                        color: Colors.teal,
                        onPressed: () {}),
                    RaisedButton(
                        child: Text("ยกเลิก"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
