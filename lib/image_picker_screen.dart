import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 250,
              color: Colors.red,
              child: image == null
                  ? const SizedBox()
                  : Image.file(File(image!.path)),
            ),
            ElevatedButton(
                onPressed: () {
                  pickImage();
                  setState(() {});
                },
                child: Text("Image")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                uploadImage();
              },
              child: const Text(
                'Send Image',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                uploadString();
              },
              child: const Text(
                'Send String',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final storageRef = storage.ref();
                final mountainsRef = storageRef.child('images/one.png');
                String data = await mountainsRef.getDownloadURL();
                debugPrint('Link---------------------->$data');
              },
              child: const Text(
                'get image',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  uploadImage() async {
    try {
      File file = File(image!.path);
      storage.ref().child('images/one.png').putFile(file);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadString() async {
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    try {
      storage
          .ref()
          .child('dataUrl')
          .putString(dataUrl, format: PutStringFormat.dataUrl);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}
