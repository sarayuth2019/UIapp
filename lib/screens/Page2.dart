import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page2();
  }
}

class _Page2 extends State {
  TextEditingController textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(15.0)),
                border: Border.all(width: 2.0, color: Colors.black38),
                color: Colors.white),
            child: TextField(
              controller: textSearch,
              maxLines: null,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: "กรุณาใส่ข้อความ",
                  border: InputBorder.none,
                  icon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.teal,
                    ),
                    onPressed: () {},
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
