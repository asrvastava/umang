// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class image_preview extends StatefulWidget {
//   const image_preview({super.key});

//   @override
//   State<image_preview> createState() => _image_previewState();
// }

// class _image_previewState extends State<image_preview> {
//   late File _image;
//   late List _results;
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future loadModel() async {
//     Tflite.close();
//     String? res;
//     res = await Tflite.loadModel(
//       model: "assets/80.tflite",
//       labels: "assets/lables.txt",
//     );
//     print(res);
//   }

//   Future pickAnImage() async {
//     // pick image and...
//     v image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//     // Perform image classification on the selected image.
//     imageClassification(image as File);
//   }

//   Future imageClassification(File image) async {
//     // Run tensorflowlite image classification model on the image
//     final List? results = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.05,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
// // save the values in the variable we created and setstate
//     setState(() {
//       _results = results;
//       _image = image;
//     });
//   }

//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image classification'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickAnImage,
//         tooltip: 'Select Image',
//         child: Icon(Icons.image),
//       ),
      
//       // body: add body below follow blog
// }
