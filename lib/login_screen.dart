import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:practic_app/secound_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPreferences? sharedPreferences;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  getInstanceData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  setData() async {
    await sharedPreferences!.setString('controller', "Nikunj");
    await sharedPreferences!
        .setStringList('controller', ["passwordController", "Sachin"]);
  }

  getData() {
    if (sharedPreferences!.containsKey('controller')) {
      debugPrint('true');

      emailController.text = sharedPreferences!.getString('emailController')!;
      passwordController.text =
          sharedPreferences!.getString('passwordController')!;
    } else {
      debugPrint('false');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form Validation"),
        leading: const Icon(Icons.filter_vintage),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //form
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImage();
                  setState(() {});
                },
                child: Container(
                    height: 200,
                    width: 300,
                    color: Colors.blue,
                    child: image == null
                        ? const Icon(Icons.account_box_sharp)
                        : Image.file(
                            File(image!.path),
                            height: 100,
                            width: 200,
                          )),
              ),
              //styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
              //box styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              //text input
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {},
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value)) {
                    return 'Enter a valid Password!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              ElevatedButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                onPressed: () {
                  submit();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecoundScreen(),
        ));
  }

  getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
