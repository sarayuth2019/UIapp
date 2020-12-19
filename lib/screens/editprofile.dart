import 'package:flutter/material.dart';
import 'package:untitled/main.dart';


class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProfile();
  }
}

class _EditProfile extends State {
  String imageProfile =
      "https://scontent.fkkc2-1.fna.fbcdn.net/v/t1.0-9/s960x960/92014565_2991956970872911_1636431682791800832_o.jpg?_nc_cat=105&_nc_sid=85a577&_nc_eui2=AeEAGmpD3eVezDnxbJmKaM7GOLka4AVZNxo4uRrgBVk3GmvAxO4n89z82KGo7AWF1VGi2OE8O2K2k5EzeJt26-T0&_nc_ohc=OxBulA_DQaQAX8zBTKP&_nc_oc=AQlFo9ck3f_lUz4-JjdbUAUWiLc3qYnkwN2tTRSpxHTDBYVmZt46t116qIS9baB4pUM&_nc_ht=scontent.fkkc2-1.fna&_nc_tp=7&oh=bea03a81723fe80034e5a9917496ae9a&oe=5F5E3B9D";
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
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
