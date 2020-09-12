import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      title: 'Prescriptions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrescriptionsPage(),
    );
  }
}

class PrescriptionsPage extends StatefulWidget {
  @override
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  File sampleImage;
  final _picker = ImagePicker();

  Future getImageGallery() async {
    var tempImage = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = File(tempImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Prescriptions"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? Text('Select an image')
            : uploadImage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            tooltip: "Add Image",
            child: Icon(Icons.add_a_photo),
            heroTag: "AddImageTag",
            onPressed: () {
              getImageGallery();
            },
          ),
          SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            tooltip: "View Uploaded Images",
            child: Icon(Icons.image),
            heroTag: "UploadedImagesTag",
            onPressed: () {
              //ToDo: Go to second page to view images on Firebase Storage
            },
          ),
        ],
      ),
    );
  }

  Widget uploadImage(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 400.0, width: 400.0),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () async {
              String _imageName = DateTime.now().toString();

              final StorageReference firebaseStorgeRef =
                  FirebaseStorage().ref().child('Images/$_imageName');

              final StorageUploadTask task =
                  firebaseStorgeRef.putFile(sampleImage);

              await task.onComplete.catchError((e) {
                print(e);
              });

              asuka.showSnackBar(SnackBar(
                content: Text('Upload Complete'),
                backgroundColor: Colors.blue,
              ));
            },
          ),
        ],
      ),
    );
  }
}
