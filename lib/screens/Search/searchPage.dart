import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Profile/profile.dart';
import 'package:untitled/screens/Search/onSearch.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends State {
  String urlSearch = "https://testheroku11111.herokuapp.com/User/search";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[300],
        child: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUserSearch(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("UserAll Snapshot data : ${snapshot.data}");
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(snapshot.data[index].id)));
                        print('User ID : ${snapshot.data[index].id}');
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[200],
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                    child: Text(
                                        "${snapshot.data[index].name[0]}",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    base64Decode(snapshot.data[index].picture),
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                              "${snapshot.data[index].name}  ${snapshot.data[index].surname}"),
                          subtitle: Text("${snapshot.data[index].email}"),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Future<List<UserAll>> _getUserSearch() async {
    print("Get AllUser Data !");
    var _allUserData = await http.get(urlSearch);
    var jsonDataAllUser = jsonDecode(utf8.decode(_allUserData.bodyBytes));
    print('User data all ${jsonDataAllUser}');
    var dataJsonAllUser = jsonDataAllUser['data'];

    List<UserAll> userAll = [];
    for (var p in dataJsonAllUser) {
      UserAll _allUser = UserAll(
          p["id"],
         // p["username"],
         // p["password"],
          p["name"],
          p["surname"],
          p["birthday"],
          p["email"],
          p["picture"],
          p["dateRegister"]);
      userAll.add(_allUser);
    }
    print('User All : ${userAll.length}');
    return userAll;
  }
}

class UserAll {
  UserAll(this.id,
      //this.username,
      // this.password,
      this.name, this.surname,
      this.birthday, this.email, this.picture, this.dateRegister);

  final int id;
 // final String username;
  //final String password;
  final String name;
  final String surname;
  final String birthday;
  final String email;
  final String picture;
  final String dateRegister;
}
