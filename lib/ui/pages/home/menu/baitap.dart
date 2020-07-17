import 'package:congthuctieuhoc/ui/pages/home/menu/load_pdf.dart';
import 'package:congthuctieuhoc/ui/pages/home/menu/toan/congtru.dart';
import 'package:congthuctieuhoc/ui/pages/home/menu/toan/sodem.dart';
import 'package:congthuctieuhoc/ui/pages/home/menu/toan/sosanh.dart';
import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:congthuctieuhoc/widgets/button_baitap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class BaiTapPages extends StatefulWidget {
  final String subTitle;

  const BaiTapPages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BaiTapPage();
}

class BaiTapPage extends State<BaiTapPages> {

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
   showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Toán'),
        ),
        backgroundColor: Color(0xffAA455D),
        body: Container(
          padding: EdgeInsets.all(20),
          child: new GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                BigBaiTapButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'Số đếm',
                  onTap: ()=>{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SoDemPages(),
                        ))
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                BigBaiTapButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'So Sánh',
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SoSanhPages(),
                      ))
                },
                ),
                SizedBox(
                  height: 12,
                ),
                BigBaiTapButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'Cộng-Trừ',
                onTap: () => {  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CongTruPages(),
                    ))},
                ),
                SizedBox(
                  height: 12,
                ),
                BigBaiTapButton(
                  image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                  text: 'Nhân-Chia',
                onTap: () => {
                showToast("Tính năng đang phát triển", gravity: Toast.BOTTOM)
                },
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

class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
