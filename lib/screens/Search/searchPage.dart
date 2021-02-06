import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SearchBar(
              onSearch: search,
              onItemFound: (Post post, int index) {
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.description),
                );
              },
              searchBarStyle: SearchBarStyle(
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ));
  }

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }
}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}