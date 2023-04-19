import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tflite/tflite.dart';
import 'package:umang/main.dart';

class output extends StatefulWidget {
  const output({super.key});

  @override
  State<output> createState() => _outputState();
}

class _outputState extends State<output> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  List<dynamic> _result = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadcamera();
    loadmodel();
  }

  loadcamera() async {
    cameraController = CameraController(camera![0], ResolutionPreset.medium);
    cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController?.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            runmodel();
          });
        });
      }
    });
  }

  runmodel() async {
    if (cameraImage != null) {
      var prediction = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((Plane) {
            return Plane.bytes;
          }).toList(),
          numResults: 7,
          imageHeight: 48,
          imageWidth: 48,
          imageMean: 127.5,
          imageStd: 127.5,
          threshold: 0.05,
          asynch: true);

      setState(() async {
        _result = prediction!;
      });
    }
  }

  loadmodel() async {
    Tflite.loadModel(model: "assets/80.tflite", labels: "assets/lables.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('emotion detection')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Container(
            child: Column(
              // ignore: unnecessary_null_comparison
              children: _result.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(
                      "${result["label"]} -  ${result["confidence"].toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
