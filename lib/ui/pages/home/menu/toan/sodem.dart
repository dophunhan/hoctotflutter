import 'dart:ffi';
import 'dart:math';

import 'package:congthuctieuhoc/widgets/AdManager.dart';
import 'package:congthuctieuhoc/widgets/button.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> _initAdMob() {
  // TODO: Initialize AdMob SDK
  return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
}

class SoDemPages extends StatefulWidget {
  final String subTitle;

  const SoDemPages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SoDemPage();
}

class SoDemPage extends State<SoDemPages> {
  int inputListA = 0;
  BannerAd _bannerAd;

  Color colorA = Colors.white;
  Color colorB = Colors.white;
  Color colorC = Colors.white;
  Color colorD = Colors.white;
  bool hide =true;
  bool checkLanDau =true;
  bool checkLDungSai =true;
  bool checkitem = false;
  String text = 'Bắt đầu';
  String textTitle = 'Hãy chọn bắt đầu để làm bài!';
  int inputNumberA = 0;
  int inputNumberB = 0;
  int inputNumberC = 0;
  int inputNumberD = 0;
  int count=0;
  int indexs=0;
  List<String> images = [
    'assets/images/ic_ga.png',
    'assets/images/ic_ca.png',
    'assets/images/ic_vatly.png',
    'assets/images/ic_vit.png',
    'assets/images/ic_sutu.png',
    'assets/images/ic_bo.png',
    'assets/images/ic_chuoi.png',
    'assets/images/ic_cho.png',
    'assets/images/ic_meo.png',
    'assets/images/ic_chim.png',
    'assets/images/ic_khi.png',
  ];

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

  randomA() {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      setState(() {
        textTitle= 'Hãy chọn kết quả đúng nhất!';
        hide=false;
        checkitem = true;
        checkLanDau = false;
        inputListA = rng.nextInt(50);
        if (inputListA == 0) {
          inputListA = 1;
        }
      });
    }
  }
  randomABCD() {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      setState(() {
        inputNumberA = rng.nextInt(99);
        inputNumberB = rng.nextInt(99);
        inputNumberC = rng.nextInt(99);
        inputNumberD = rng.nextInt(99);
        if(indexs==0||indexs==5||indexs==8){
          inputNumberA = inputListA;
          indexs++;
        }else if(indexs==1||indexs==7||indexs==9){
          inputNumberC = inputListA;
          indexs++;
        }else if(indexs==2||indexs==6||indexs==11){
          inputNumberB = inputListA;
          indexs++;
        }else if(indexs==3||indexs==4||indexs==10){
          inputNumberD = inputListA;
          indexs++;
        }
        if(indexs==11){
          indexs=0;
        }
      });
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

  checkKetQua(String a){
    switch(a){
      case 'Nộp bài':
       setState(() {
         switch(count){
           case 0:
             if(inputListA ==inputNumberA){
               checkLanDau = true;
               checkitem = false;
               checkYesNo();
               text = 'Tiếp tục';
             }else{
               checkLanDau = false;
               text = 'Nộp bài';
               checkNoYes();
             }
             break;
           case 1:
             if(inputListA ==inputNumberB){
               checkLanDau = true;
               checkitem = false;
               text = 'Tiếp tục';
               checkYesNo();
             }else{
               checkLanDau = false;
               text = 'Nộp bài';
               checkNoYes();
             }
             break;
           case 2:
             if(inputListA ==inputNumberC){
               checkLanDau = true;
               checkitem = false;
               text = 'Tiếp tục';
               checkYesNo();
             }else{
               checkLanDau = false;
               text = 'Nộp bài';
               checkNoYes();
             }
             break;
           case 3:
             if(inputListA ==inputNumberD){
               checkLanDau = true;
               text = 'Tiếp tục';
               checkYesNo();
               checkitem = false;
             }else{
               checkLanDau = false;
               text = 'Nộp bài';
               checkNoYes();
             }
             break;
         }
       });
        break;
      case '':
        setState(() {
          hide=false;
          setState(() {
            text = 'Nộp bài';
          });
        });
        break;
    }
  }


   defaulcolor() {
    colorA = Colors.white;
    colorB = Colors.white;
    colorC = Colors.white;
    colorD = Colors.white;
  }


  setColor(int index) {
    if(checkitem){
      switch (index) {
        case 0:
          setState(() {
            count = 0;
            defaulcolor();
            hide=true;
            text = 'Nộp bài';
            colorA = Colors.amberAccent;
          });
          break;
        case 1:
          setState(() {
            count=1;
            defaulcolor();
            hide=true;
            text = 'Nộp bài';
            colorB = Colors.amberAccent;
          });
          break;
        case 2:
          setState(() {
            count=2;
            defaulcolor();
            hide=true;
            text = 'Nộp bài';
            colorC = Colors.amberAccent;
          });
          break;
        case 3:
          setState(() {
            count=3;
            defaulcolor();
            hide=true;
            text = 'Nộp bài';
            colorD = Colors.amberAccent;
          });
          break;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Số đếm'),
        ),
        backgroundColor: Color(0xffAA455D),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                Text(textTitle,style: TextStyle(color: Colors.white,fontSize: 18),),
                SizedBox(
                  height: 0,
                ),
                Container(
                  height:320.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 4,left: 4,right: 4),
                  child: new GridView.count(
                    padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2),
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    children: new List<Widget>.generate(inputListA, (index) {
                      return new GridTile(
                          child: new Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: new BorderSide(color: Colors.grey, width: 0.2)),
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new InkResponse(
                                  child: Image.asset(images[indexs]),
                                  onTap: () => {},
                                )),
                          ));
                    }),
                  ),
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
                            inputNumberA.toString(),
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 60,
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
                            inputNumberB.toString(),
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () => setColor(1),
                      ),
                      height: 60,
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
                            inputNumberC.toString(),
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      height: 60,
                      width: 120,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: colorD,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => setColor(3),
                        child: Center(
                          child: Text(
                            inputNumberD.toString(),
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.purpleAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      height: 60,
                      width: 120,
                      margin: EdgeInsets.only(left: 30),
                    ),


                  ],
                ),
                Visibility(
                  visible: hide,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff00B8F1),
                    ),
                    height: 50,
                    child: InkWell(
                        onTap: () => {
                          if(checkLanDau){
                            randomA(),
                            randomABCD(),
                            defaulcolor()
                          }else{
                            if(checkLDungSai){
                              checkKetQua('Nộp bài')
                            }else{

                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              text,
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
                )
              ],
            ),
          ),
        ));
  }
}
