import 'package:flutter/material.dart';
import 'package:practic_app/login_model.dart';

class SecoundScreen extends StatefulWidget {
  final LoginModel? item;
  const SecoundScreen({Key? key, this.item}) : super(key: key);

  @override
  State<SecoundScreen> createState() => _SecoundScreenState();
}

class _SecoundScreenState extends State<SecoundScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    if (widget.item != null) {
      emailController.text = widget.item!.emailController!;
      passwordController.text = widget.item!.passwordController!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("email :${widget.item!.emailController}"),
          Text("email :${widget.item!.passwordController}")
        ],
      ),
    );
  }
}
