import 'package:congthuctieuhoc/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: new Column(children: <Widget>[
          Divider(
            height: 250.0,
            color: Colors.white,
          ),
          new Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
          ),
          Divider(
            height: 101.2,
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}