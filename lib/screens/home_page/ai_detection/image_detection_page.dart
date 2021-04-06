import 'dart:io';

import 'package:flower/configs/assets.dart';
import 'package:flower/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

class ImageDetctionPage extends StatefulWidget {
  @override
  _ImageDetctionPageState createState() => _ImageDetctionPageState();
}

class _ImageDetctionPageState extends State<ImageDetctionPage> {
  String res;
  File file;
  var recognitions;
  @override
  void initState() {
    _initModel();
    super.initState();
  }

  _pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image != null) {
      this.file = File(image.path);
      img.Image oriImage = img.decodeImage(await image.readAsBytes());
      img.Image resizedImage =
          img.copyResize(oriImage, height: 300, width: 300);
      var binary = Helper.imageToByteListUint8(resizedImage, 300);
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        this.recognitions = recognitions;
      });
    }
  }

  _initModel() async {
    try {
      Tflite.close();
      print('loading...');
      String res = await Tflite.loadModel(
        model: AppAssets.mobileNetModel,
        labels: AppAssets.mobileNetLabel,
      );
      print('load model done');
      this.res = res;
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickImage();
        },
      ),
      body: Center(
        child: Text("$recognitions"),
      ),
    );
  }
}
