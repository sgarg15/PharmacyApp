import 'package:flutter/material.dart';

void main() async {
  runApp(PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            tooltip: "Add Image",
            child: Icon(Icons.add_a_photo),
            heroTag: "AddImageTag",
            onPressed: () {
              // ToDo: Open Image Gallery and Pick Photo
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
}
