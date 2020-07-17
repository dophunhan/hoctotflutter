import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:flutter/material.dart';

class Math02Pages extends StatefulWidget {
  final String subTitle;

  const Math02Pages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Math02Page();
}

class Math02Page extends State<Math02Pages> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoá học'),
      ),
      backgroundColor: Color(0xff6762A2),
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
//                onTap: _Math01,
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
