import 'package:flutter/material.dart';
import 'package:untitled/main.dart';


class Post extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Post();
  }
}

class _Post extends State {
  TextEditingController postText = TextEditingController();

  void postController() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
            border: Border.all(width: 2.0, color: Colors.black38),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.queue,
                  color: Colors.teal,
                ),
                title: TextField(
                  maxLines: null,
                  controller: postText,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "กรุณาใส่ข้อความ",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
          decoration: BoxDecoration(),
          child: RaisedButton(
            onPressed: postController,
            child: Text("Post"),
            color: Colors.teal,
            textColor: Colors.white,
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 2.0),
          decoration: BoxDecoration(),
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("Go back"),
            color: Colors.black12,
            textColor: Colors.white,
          ),
        ),
      ]),
    );
  }
}
