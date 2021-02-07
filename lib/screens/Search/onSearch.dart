import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'searchPage.dart';

class DataSearch extends SearchDelegate<String> {
  String urlSearch = "https://testheroku11111.herokuapp.com/User/search";
  var _listUser = [];


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
      future: _getUserSearch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                final onSearch = query.isEmpty
                    ? snapshot.data[index].name+"  "+snapshot.data[index].surname
                    : snapshot.data[index].name.where((p)=>p.title.startsWith(query)).toList();

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        MemoryImage(base64Decode(snapshot.data[index].picture)),
                  ),
                  title: Text("${onSearch.toString()}"),
                );
              });
        }
      },
    );
  }

  Future<List<UserAll>> _getUserSearch() async {
    print("Get AllUser Data !");
    var _allUserData = await http.get(urlSearch);
    var jsonDataAllUser = jsonDecode(utf8.decode(_allUserData.bodyBytes));
    print('User data all ${jsonDataAllUser}');
    var dataJsonAllUser = jsonDataAllUser['data'];
    List<UserAll> _userAll = [];
    for (var p in dataJsonAllUser) {
      UserAll _allUser = UserAll(
          p["id"],
          //p["username"],
          //p["password"],
          p["name"],
          p["surname"],
          p["birthday"],
          p["email"],
          p["picture"],
          p["dateRegister"]);
      _userAll.add(_allUser);
    }
    _listUser = _userAll;
    print('User All : ${_listUser.length}');
    return _userAll;
  }
}
