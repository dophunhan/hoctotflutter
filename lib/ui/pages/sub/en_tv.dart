import 'dart:ffi';
import 'dart:math';

import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnglishPages extends StatefulWidget {
  final String subTitle;

  const EnglishPages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EnglishPage();
}

class EnglishPage extends State<EnglishPages> {
//  https://drive.google.com/file/d/1eLjnnEBBqTSOJXcLO43UGNgJ-p2pNRfK/view?usp=sharing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vậy lý'),
        ),
        backgroundColor: Color(0xffAA455D),
        body: Container(
          padding: EdgeInsets.all(20),
          child: new GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                BigButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'Lý thuyết',
                  onTap: ()=>{

                  },
                  images: AssetImage(''),
                ),
                SizedBox(
                  height: 12,
                ),
                BigButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'Bài tập',
//                onTap: () => _english(subTitle: 'English - Vietnamesse'),
                  images: AssetImage(''),
                ),
              ],
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
        ));
  }
}
