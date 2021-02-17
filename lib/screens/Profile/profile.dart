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
  _Profile(this.id);
  final int id;
  UserLogin _userProfile;
  String urlUser = "https://testheroku11111.herokuapp.com/User/";
  double ratingData = 2.5;
  double _rating;
  String profileImage;
  String imageProfile =
      "https://ecp.eng.rmuti.ac.th/wp-content/uploads/2019/12/40554453_1853273344768778_1816059919623782400_n.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("Profile ID : ${id}");
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder(
        future: getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("Profile Data Snapshot : ${snapshot.data}");
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 30, bottom: 30),
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  imageProfile,
                                  height: 220,
                                  width: 370,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.teal[200],
                                  radius: 75,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Center(
                                      child: Text(
                                        "${_userProfile.name[0]}",
                                        style: TextStyle(
                                            fontSize: 85,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    base64Decode(_userProfile.picture),
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                color: Colors.orange[600],
                                onPressed: () {}),
                            SizedBox(width: 10,),
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
        },
      ),
    );
  }

  Future<void> getUserProfile() async {
    var dataUser = await http.get("${urlUser}/${id}");
    var _dataUser = jsonDecode(utf8.decode(dataUser.bodyBytes));
    var _user = _dataUser['data'];
    _userProfile = UserLogin.fromJson(_user);
    print('ID : ${_userProfile.id} | User Profile : ${_userProfile.username} | Name :${_userProfile.name}');
    return _userProfile;
  }
}
