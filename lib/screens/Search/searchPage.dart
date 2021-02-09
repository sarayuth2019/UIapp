import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/Profile/profile.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends State {
  String urlSearch = "https://testheroku11111.herokuapp.com/User/search";
  List<UserAll> _user = List();
  List<UserAll> _searchUser = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserSearch().then((value) {
      setState(() {
        _user = value;
        _searchUser = _user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search Name...', border: InputBorder.none),
                      onChanged: (textSearch) {
                        setState(() {
                          _searchUser = _user
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(textSearch.toLowerCase()))
                              .toList();
                        });
                      }),
                ),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: FutureBuilder(
                future: _getUserSearch(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print("UserAll Snapshot data : ${snapshot.data}");
                  if (snapshot.data == null) {
                    _searchUser = _user;
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: _searchUser.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(_searchUser[index].id)));
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal[200],
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Center(
                                          child: Text(
                                            "${_searchUser[index].name[0]}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.memory(
                                          base64Decode(
                                              _searchUser[index].picture),
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                    "${_searchUser[index].name}  ${_searchUser[index].surname}"),
                                subtitle: Text("${_searchUser[index].email}"),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<UserAll>> _getUserSearch() async {
    print("Get AllUser Data....");
    var _allUserData = await http.get(urlSearch);
    var jsonDataAllUser = jsonDecode(utf8.decode(_allUserData.bodyBytes));
    print("Get AllUser Data Success !");
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
    _user = userAll;
    print('User All : ${_user.length}');
    return userAll;
  }
}

class UserAll {
  UserAll(
      this.id,
      //this.username,
      // this.password,
      this.name,
      this.surname,
      this.birthday,
      this.email,
      this.picture,
      this.dateRegister);

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
