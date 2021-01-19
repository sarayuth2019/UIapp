
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/TopSaga/Desktop/UIApp/lib/screens/Post/post.dart';

class Page3 extends StatelessWidget {
  String image = "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
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
