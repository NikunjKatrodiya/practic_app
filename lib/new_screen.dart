import 'package:flutter/material.dart';
import 'package:practic_app/apps_model.dart';

class NewScreen extends StatefulWidget {
  final int? id;
  final String? title;
  const NewScreen({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  PostsModel? postsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("id: ${postsModel!.title}"),
          Text("id: ${postsModel!.id}")
        ],
      ),
    );
  }
}
