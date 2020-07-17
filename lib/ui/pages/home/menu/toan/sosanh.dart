import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:congthuctieuhoc/ui/pages/home/menu/load_pdf.dart';
import 'package:congthuctieuhoc/widgets/AdManager.dart';
import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:congthuctieuhoc/widgets/button_baitap.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> _initAdMob() {
  // TODO: Initialize AdMob SDK
  return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
}

class SoSanhPages extends StatefulWidget {
  final String subTitle;

  const SoSanhPages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SoSanhPage();
}

class SoSanhPage extends State<SoSanhPages> {
  BannerAd _bannerAd;

  Color colorA = Colors.white;
  Color colorB = Colors.white;
  Color colorC = Colors.white;
  Color colorD = Colors.white;
  String textKetQua='?';
  int inPutA = 0;
  int inPutB = 0;
  bool checkStatus = true;
  bool checkDungSai = true;
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  int count =0;
  String textCheck = 'Bắt đầu';

  void defaulcolor() {
    colorA = Colors.white;
    colorB = Colors.white;
    colorC = Colors.white;
    colorD = Colors.white;
  }

  // TODO: Implement _loadBannerAd()
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }
  @override
  void dispose() {
    // TODO: Dispose BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
    adUnitId: AdManager.bannerAdUnitId,
    size: AdSize.banner,
    );

    // TODO: Load a Banner Ad
    _loadBannerAd();
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

   randomTextAB() {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      setState(() {
        textCheck = "Nộp bài";
        checkStatus=false;
          inPutA = rng.nextInt(int.parse("100"));
      });
    }
    for (var i = 0; i < 1; i++) {
      setState(() {
        inPutB = rng.nextInt(int.parse("100"));
      });
    }
  }
  void radiosYes() {
    advancedPlayer.stop();
    audioCache.play('audios/dung.mp3');
  }

  void radiosNo() {
    advancedPlayer.stop();
    audioCache.play('audios/sai.mp3');
  }
  checkButtonNext(String a){
    switch(a){
      case 'Tiếp tục':
        setState(() {
          randomTextAB();
          checkStatus = false;
          checkDungSai =true;
        });
        break;
    }

  }
  checkKetQua(){
    switch(textKetQua){
      case '>':
        if(inPutA > inPutB){
          radiosYes();
          setState(() {
            textCheck = "Tiếp tục";
            checkDungSai = false;
            checkYesNo();
          });
        }else{
          radiosNo();
          setState(() {
            textCheck = "Nộp bài";
            checkDungSai = true;
            checkNoYes();
          });
        }
        break;
      case '<':
        if(inPutA < inPutB){
          radiosYes();
          setState(() {
            textCheck = "Tiếp tục";
            checkDungSai = false;
            checkYesNo();
          });
        }else{
          radiosNo();
          setState(() {
            textCheck = "Nộp bài";
            checkDungSai = true;
            checkNoYes();
          });
        }
        break;

      case '=':
        if(inPutA == inPutB){
          radiosYes();
          setState(() {
            textCheck = "Tiếp tục";
            checkDungSai = false;
            checkYesNo();
          });
        }else{
          radiosNo();
          setState(() {
            textCheck = "Nộp bài";
            checkDungSai = true;
            checkNoYes();
          });
        }
        break;
    }

  }

  setColor(int index) {
    switch (index) {
      case 0:
        setState(() {
          defaulcolor();
          colorA = Colors.amberAccent;
          textKetQua = '>';
        });
        break;
      case 1:
        setState(() {
          defaulcolor();
          colorB = Colors.amberAccent;
          textKetQua = '<';
        });
        break;
      case 2:
        setState(() {
          defaulcolor();
          colorC = Colors.amberAccent;
          textKetQua = '=';
        });
        break;
      case 3:
        setState(() {
          defaulcolor();
          colorD = Colors.amberAccent;
          textKetQua = '>=';
        });
        break;
    }
  }

  //show dialog dung
  checkYesNo() {
    var alert = new CupertinoAlertDialog(
      actions: <Widget>[
        new Container(
          color: Color(0xffFFFFFF),
          child: new Column(
            children: <Widget>[
              new CupertinoDialogAction(
                  child: Container(
                    height: 22,
                    child: Image.asset('assets/images/yellow_star.png'),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new CupertinoDialogAction(
                  child: Container(
                    height: 92,
                    width: 92,
                    child: Image.asset('assets/images/badge.png'),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, '');
                  }),
              new CupertinoDialogAction(
                  child: const Text(
                    'Đáp án chính xác!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Đáp án chính xác!');
                  }),
              new CupertinoDialogAction(
                  child: new Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Color(0xff2D9CDB),
                    ),
                    width: 200.0,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Trừ tự do');
                  }),
            ],
          ),
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

//show dialog sai
  checkNoYes() {
    var alert = new CupertinoAlertDialog(
      actions: <Widget>[
        new Container(
          color: Color(0xffFFFFFF),
          child: new Column(
            children: <Widget>[
              new CupertinoDialogAction(
                  child: Container(
                    height: 22,
                    child: Image.asset('assets/images/grey_star.png'),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new CupertinoDialogAction(
                  child: Container(
                    height: 92,
                    width: 92,
                    child: Image.asset('assets/images/ic_vc.png'),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, '');
                  }),
              new CupertinoDialogAction(
                  child: const Text(
                    'Đáp án chưa chính xác!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Đáp án chưa chính xác!');
                  }),
              new CupertinoDialogAction(
                  child: new Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Color(0xff2D9CDB),
                    ),
                    width: 200.0,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Trừ tự do');

                  }),
            ],
          ),
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('So Sánh Các Số'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Đã hoàn thành: ',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text('0',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text('/100',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.lightBlueAccent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      height: 70,
                      width: 90,
                      child: Center(
                        child: Text(
                          inPutA.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 12),
                      height: 70,
                      width: 90,
                      child: Center(
                        child: Text(
                          textKetQua,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 12),
                      height: 70,
                      width: 90,
                      child: Center(
                        child: Text(
                          inPutB.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hãy chọn kết quả đúng nhất vào chỗ trống!',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: colorA,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                        child: Center(
                          child: Text(
                            '>',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      height: 80,
                      width: 120,
                    ),
                    onTap: () => setColor(0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: colorB,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: InkWell(
                      child: Center(
                        child: Text(
                          '<',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () => setColor(1),
                    ),
                    height: 80,
                    width: 120,
                    margin: EdgeInsets.only(left: 30),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: colorC,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => setColor(2),
                      child: Center(
                        child: Text(
                          '=',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    height: 80,
                    width: 120,
                  ),


                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff00B8F1),
                  ),
                  height: 50,
                  child: InkWell(
                      onTap: ()=> {
                        if(checkStatus){
                          randomTextAB()
                        }else{
                          if(checkDungSai){
                            checkKetQua()
                          }else{
                            checkButtonNext("Tiếp tục")
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            textCheck,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 24,
                            width: 24,
                            margin: EdgeInsets.only(left: 12),
                            child: Image.asset('assets/images/ic_arrow.png'),
                          )
                        ],
                      )),

                  ),
            ],
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
