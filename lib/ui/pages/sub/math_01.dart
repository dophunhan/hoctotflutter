import 'package:congthuctieuhoc/ui/pages/home/menu/baitap.dart';
import 'package:congthuctieuhoc/ui/pages/home/menu/load_pdf.dart';
import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class Math01Pages extends StatefulWidget {
  final String subTitle;

  const Math01Pages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Math01Page();
}

class Math01Page extends State<Math01Pages> {

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
                onTap: ()=>{
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => Load_Pdf_State(),
//                      ))
                  showToast("Tính năng đang phát triển", gravity: Toast.BOTTOM)
                },
                images: AssetImage('assets/images/ic_bg_tinhtoan.png'),
              ),
              SizedBox(
                height: 12,
              ),
              BigButton(
                image: AssetImage('assets/images/ic_bg_tinhtoan.png'),
                text: 'Bài tập',
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaiTapPages(),
                      ))
                },
                images: AssetImage('assets/images/ic_bg_tinhtoan.png'),
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
