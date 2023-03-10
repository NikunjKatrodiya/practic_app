import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:practic_app/apps_model.dart';
import 'package:practic_app/new_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<PostsModel> postAppList = [];
  PostsModel? postsModel;
  @override
  void initState() {
    // TODO: implement initState
    getPostAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: postsModel == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              separatorBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewScreen(
                              title: postsModel!.title,
                              id: postsModel!.id,
                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text(
                        "Title : ${postsModel!.title![index]}",
                      ),
                      subtitle: Text("${postsModel!.id!}"),
                    ),
                  ),
              itemCount: 6),
    );
  }

  getPostAPI() async {
    var client = http.Client();
    try {
      Response response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        postsModel = PostsModel.fromJson(jsonDecode(response.body));
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
