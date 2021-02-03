import 'package:flutter/material.dart';



class Comment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Comment();
  }
}

class _Comment extends State {
  TextEditingController commentText = TextEditingController();

  void postController() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              margin: EdgeInsets.only(
                  left: 5.0, right: 5.0, bottom: 0.0, top: 20.0),
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(const Radius.circular(15.0)),
                border: Border.all(width: 2.0, color: Colors.black38),
              ),
              child: ListView(
                children: <Widget>[Text("คอมเม็นต่างๆ")],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 5.0, top: 606.0),
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(const Radius.circular(15.0)),
                border: Border.all(width: 2.0, color: Colors.black38),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: commentText,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "กรุณาใส่ข้อความ",
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        )),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.teal,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 350,top:30),
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.teal,),
              onPressed:(){
                Navigator.of(context).pop();
              },),
          )
        ],
      ),
    );
  }
}
