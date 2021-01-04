import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/mainPage.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile();
  }
}

class _Profile extends State {
  String imageProfile =
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";
  String imageBackground =
      "https://www.jpl.nasa.gov/images/spitzer/20190827/3-PIA10181-640x309.jpg";

  double _rating = 3.0;


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
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 90, right: 90),
                        child: Row(
                          children: [
                            RatingBar.builder(
                                allowHalfRating: true,
                                initialRating: 3,
                                minRating: 1,
                                itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                  print(_rating);
                                }),
                            Text("$_rating")
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("ชื่อ"), Text("นามสกุล")],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.alternate_email),
                      title: Text("E-mail"),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake),
                      title: Text("วัน-เดือน-ปีเกิด"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                        child: Text("ตกลง"),
                        color: Colors.teal,
                        onPressed: () {}),
                    RaisedButton(
                        child: Text("ยกเลิก"),
                        onPressed: () {
                          Navigator.pop(
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
