
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/comment.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page1();
  }
}

class _Page1 extends State {
  List<String> textInput = [null];
  String _textInput = "เอาไว้ลิงค์ข้อความจากดาต้าเยส";
  String imageProfile = "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
  int _like = 0;

  void _likeCount() {
    setState(() {
      _like++;
    });
  }

  Widget cardTemplate(String textInput) {
    var textInput = _textInput;

    return Card(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(imageProfile),),
              title: Text("ชื่อผู้ที่โพส",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            Text(textInput.toString()),
            Row(
              children: <Widget>[
                RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.teal,
                        ),
                        Text("$_like"),
                      ],
                    ),
                    onPressed: _likeCount),
                Expanded(
                  child: RaisedButton(
                      child: Text("แสดงความคิดเห็น"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Comment()));
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children:
            textInput.map((textInput) => cardTemplate(textInput)).toList(),
      ),
    );
  }
}
