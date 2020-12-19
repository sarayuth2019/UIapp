
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/post.dart';

class Page3 extends StatelessWidget {
  String image =
      "https://scontent.fkkc2-1.fna.fbcdn.net/v/t1.0-9/s960x960/58784964_1923045707800161_4312147723529748480_o.jpg?_nc_cat=103&_nc_sid=85a577&_nc_eui2=AeGqQmlZTyGpXyhOBwP_YLAPjGrJ4RPlgLmMasnhE-WAuUGCYryWp0OTkP9tqSlkJenTTa1fFI61RtZ23es0mD29&_nc_ohc=PZGQRZWF13MAX_sLiyj&_nc_ht=scontent.fkkc2-1.fna&_nc_tp=7&oh=21d49e1a448e3dd117192524688e8972&oe=5F5FDA7D";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 430),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
              border: Border.all(width: 2.0, color: Colors.black38),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                  title: Column(
                    children: <Widget>[
                      Text(
                        "ผู้แสดงความคิดเห็นในโพสของคุณ !",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 20, top: 5),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Post()));
                                },
                                child: Text(
                                  "ไปยังโพส",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 20, top: 5),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Post()));
                                },
                                child: Text(
                                  "พูดคุย",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
