import 'package:congthuctieuhoc/ui/pages/sub/en_tv.dart';
import 'package:congthuctieuhoc/ui/pages/sub/math_01.dart';
import 'package:congthuctieuhoc/ui/pages/sub/math_02.dart';
import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:flutter/material.dart';

import 'home_widget.dart';

class HomePage extends StatelessWidget with HomeWidget {
  @override
  Widget build(BuildContext context) {
    _Math01({String subTitle = 'Tính toán'}) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Math01Pages(
          subTitle: subTitle,
        );
      }));
    }
    _Math02({String subTitle = 'Math 02'}) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Math02Pages(
          subTitle: subTitle,
        );
      }));
    }
    _english({String subTitle = 'English - Vietnamesse'}) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return EnglishPages(
          subTitle: subTitle,
        );
      }));
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Color(0xffFFAC5F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 140,
            child: Image.asset('assets/images/ic_logoht.png'),
          ),
          SizedBox(
            height: 20,
          ),
          textSlogan(context),
          SizedBox(
            height: 20,
          ),
          BigButton(
            image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
            text: 'Toán',
            onTap: _Math01,
            images: AssetImage('assets/images/ic_math.png'),
          ),
//          SizedBox(
//            height: 12,
//          ),
//          BigButton(
//            image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
//            text: 'Lý',
//            onTap: () => _english(subTitle: 'English - Vietnamesse'),
//            images: AssetImage('assets/images/ic_vatly.png'),
//          ),
//          SizedBox(
//            height: 12,
//          ),
//          BigButton(
//            image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
//            text: 'Hoá',
//            onTap: () => _Math02(subTitle: 'Chọn bài tập'),
//            images: AssetImage('assets/images/ic_hoahoc.png'),
//          ),

        ],
      ),
    ),);
  }


}
