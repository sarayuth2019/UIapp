import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Login/data_login.dart';


class Profile extends StatefulWidget {
  Profile(this.id);

  final int id;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile(id);
  }
}

class _Profile extends State {
  UserLogin _userProfile;

  _Profile(this.id);

  final int id;
  String urlUser = "https://testheroku11111.herokuapp.com/User/";
  double ratingData = 2.5;
  double _rating;
  String profileImage;
  String imageProfile =
      "https://danbooru.donmai.us/data/sample/__klee_genshin_impact_drawn_by_yukie_kusaka_shi__sample-6603dffff95dcb7c9cb42573045ad694.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("User ID profile : ${id}");
    return Scaffold(
      backgroundColor: Colors.teal,
      body: FutureBuilder(
        future: getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("Profile Data Snapshot : ${snapshot.data}");
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white60,
                    shadowColor: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                          child: Container(
                              height: 200,
                              width: 400,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageProfile),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: CircleAvatar(
                                      backgroundImage: MemoryImage(base64Decode(_userProfile.picture)),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                        //ignoreGestures: true,
                                        initialRating: ratingData,
                                        allowHalfRating: true,
                                        minRating: 1,
                                        itemCount: 5,
                                        itemBuilder: (context, i) => Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                            ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            _rating != null
                                                ? _rating = rating
                                                : _rating = ratingData;
                                          });
                                          print(_rating);
                                        }),
                                    Text("$_rating")
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.account_circle),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_userProfile.name}  ${_userProfile.surname}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.alternate_email),
                                title: Text(
                                  _userProfile.email,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.cake),
                                title: Text(
                                  _userProfile.birthday,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
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
                                    Navigator.of(context).pop();
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> getUserProfile() async {
    var dataUser = await http.get("${urlUser}/${id}");
    var _dataUser = jsonDecode(utf8.decode(dataUser.bodyBytes));
    var _user = _dataUser['data'];
    _userProfile = UserLogin.fromJson(_user);
    print('ID : ${_userProfile.id} User Profile : ${_userProfile.username}');
    return _userProfile;
  }
}
