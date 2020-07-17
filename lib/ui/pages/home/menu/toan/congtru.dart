import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:congthuctieuhoc/widgets/AdManager.dart';
import 'package:congthuctieuhoc/widgets/button_math_01.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Future<void> _initAdMob() {
  // TODO: Initialize AdMob SDK
  return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
}

class CongTruPages extends StatefulWidget {
  final String subTitle;

  const CongTruPages({Key key, this.subTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConTruPage();
}

class ConTruPage extends State<CongTruPages> {
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  BannerAd _bannerAd;

  int thisGroup = 0;
  String _output = "";
  String output = "?";
  String outputNumber = "?";
  String outputNumbers = "";
  int inPutA = 0;
  int inPutB = 0;
  int inPutC = 0;
  int kqa;
  var statusTextA = false;
  var statusTextB = false;
  var statusTextC = true;
  var statusCalculation = true;
  var focusInput = true;
  var focusPlusOrMinus = true;
  String title = 'Cộng không nhớ';
  int position = 0;
  String calculation = "+";

//  const Math01Page({Key key, this.subTitle}) : super(key: key);

  final Map<int, Widget> log = const <int, Widget>{
    0: Text('Tính toán'),
    1: Text('Điền số 1'),
    2: Text('Điền số 2'),
  };

  var textEditController;

  buttonPressed(String buttonText) {
    if (output.length > 1) {
      return;
    } else {
      _output = _output + buttonText;
      print(_output);
      setState(() {
        output = int.parse(_output).toString();
      });
    }
  }

  void randomTextA(String input) {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      if (focusPlusOrMinus) {
        if (statusTextC) {
          setState(() {
            inPutA = rng.nextInt(int.parse(input));
          });
        } else {
          setState(() {
            inPutA = rng.nextInt(int.parse(input));
          });
        }
      } else {
        setState(() {
          inPutA = rng.nextInt(int.parse(input));
        });
      }
    }
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

  void randomTextB(String input) {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      if (focusPlusOrMinus) {
        if (statusTextC) {
          setState(() {
            inPutB = rng.nextInt((int.parse(input)));
          });
        } else {
          inPutB = rng.nextInt(int.parse(input));
        }
      } else {
        setState(() {
          inPutB = rng.nextInt(int.parse(input));
        });
      }
    }
  }

  void randomTextC(String outputNumber) {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      setState(() {
        if (focusPlusOrMinus) {
          inPutC = rng.nextInt(int.parse(outputNumber));
        } else {
          inPutC = rng.nextInt(int.parse(outputNumber));
        }
      });
    }
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
  void checkResult() {
    if (output.isNotEmpty) {
      int convertA;
      convertA = int.parse(output);
      setState(() {
        if (focusPlusOrMinus) {
          kqa = (convertA + inPutB);
        } else {
          if (statusTextA) {
            print(inPutB);
            print(convertA);
            kqa = (convertA - inPutB);
          } else if (statusTextB) {
            kqa = (inPutA - convertA);
          }
        }
      });

      if (statusTextC) {
        setState(() {
          if (focusPlusOrMinus) {
            kqa = (inPutA + inPutB);
          } else {
            kqa = (inPutA - inPutB);
          }
        });
        if (kqa == convertA) {
          checkYesNo();
          advancedPlayer.stop();
          audioCache.play('audios/dung.mp3');
        } else {
          checkNoYes();
          advancedPlayer.stop();
          audioCache.play('audios/sai.mp3');
        }
      } else {
        if (kqa == inPutC) {
          checkYesNo();
          advancedPlayer.stop();
          audioCache.play('audios/dung.mp3');
        } else {
          checkNoYes();
          advancedPlayer.stop();
          audioCache.play('audios/sai.mp3');
        }
      }
    }
  }

  void delete(String str, String outputs) {
    if (str.isNotEmpty) {
      setState(() {
        if (str.length == 1) {
          str = str.replaceFirst(str.substring(str.length - 1), "?");
          outputs =
              outputs.replaceFirst(outputs.substring(outputs.length - 1), "");
          _output = "";
          output = str;
        } else {
          str = str.replaceFirst(str.substring(str.length - 1), "");
          outputs =
              outputs.replaceFirst(outputs.substring(outputs.length - 1), "");
          _output = outputs;
          output = str;
        }
      });
    }
  }

  void postProcessing(String titles, int position) {
    setState(() {
      inPutA = 0;
      inPutB = 0;
      inPutC = 0;
      output = '?';
      _output = "";
      title = titles;
      if (focusPlusOrMinus) {
        calculation = '+';
      } else {
        calculation = '-';
      }
    });
  }

  void checkRanDom() {
    if (focusPlusOrMinus) {
      if (statusTextB) {
        setState(() {
          inPutC = inPutA + inPutC;
        });
      } else if (statusTextA) {
        setState(() {
          inPutC = inPutB + inPutC;
        });
      }
    } else {
      if (statusTextB) {
        setState(() {
          inPutA = inPutA + inPutC;
        });
      } else {
        setState(() {
          if (statusTextC) {
            inPutA = inPutA + inPutB;
          }
        });
      }
    }
    if (outputNumbers.isNotEmpty) {
      int a = int.parse(outputNumbers);
      if (inPutA > a) {
        inPutA = a;
      } else if (inPutB > a) {
        inPutB = a;
      } else if (inPutC > a) {
        inPutC = a;
      }
    }
    if (position == 1) {
      if (statusTextA) {
        double a = (inPutB / 10);
        inPutB = a.toInt();
        inPutC = inPutB * 10;
      } else if (statusTextB) {
        double a = (inPutA / 10);
        inPutA = a.toInt();
        inPutC = inPutA * 10;
      } else {
        double a = (inPutA / 10);
        inPutA = a.toInt();
        int c = inPutA * 10;
        inPutB = c - inPutA;
      }
    }
    if (position == 4) {
      if (statusTextA) {
        double a = (inPutB / 10);
        inPutB = a.toInt();
        inPutC = inPutB * 10;
      } else if (statusTextB) {
        double a = (inPutA / 10);
        int c = a.toInt() * 10;
        if (outputNumbers.isEmpty) {
          if (inPutA > 100) {
            inPutA = 100;
          } else {
            inPutA = c;
          }
        } else {
          if (inPutA > int.parse(outputNumbers)) {
            inPutA = int.parse(outputNumbers);
          } else {
            inPutA = c;
          }
        }
        double b = (inPutC / 10);
        inPutC = b.toInt() * 10;
      } else {
        double a = (inPutB / 10);
        inPutB = a.toInt();
        int c = inPutB * 10;
        inPutA = c + inPutB;
      }
    }
  }

//show dialog chọn phép tính
  showPopup() {
    var alert = new CupertinoAlertDialog(
      actions: <Widget>[
        new Container(
          color: Color(0xffFFFFFF),
          child: new Column(
            children: <Widget>[
              new CupertinoDialogAction(
                  child: new Text(
                    'Cộng không nhớ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cộng không nhớ');
                    focusPlusOrMinus = true;
                    postProcessing('Cộng không nhớ', 0);
                    position = 0;
                  }),
              new CupertinoDialogAction(
                  child: new Text(
                    'Cộng tròn chục',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cộng tròn chục');
                    focusPlusOrMinus = true;
                    postProcessing('Cộng tròn chục', 1);
                    position = 1;
                  }),
              new CupertinoDialogAction(
                  child: new Text(
                    'Cộng tự do',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cộng tự do');
                    focusPlusOrMinus = true;
                    postProcessing('Cộng tự do', 2);
                    position = 2;
                  }),
              new CupertinoDialogAction(
                  child: new Text(
                    'Trừ không mượn',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Trừ không mượn');
                    focusPlusOrMinus = false;
                    postProcessing('Trừ không mượn', 3);
                    position = 3;
                  }),
              new CupertinoDialogAction(
                  child: new Text(
                    'Trừ tròn chục',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Trừ tròn chục');
                    focusPlusOrMinus = false;
                    postProcessing('Trừ tròn chục', 4);
                    position = 4;
                  }),
              new CupertinoDialogAction(
                  child: Text(
                    'Trừ tự do',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Trừ tự do');
                    focusPlusOrMinus = false;
                    postProcessing('Trừ tự do', 5);
                    position = 5;
                  }),
            ],
          ),
        ),
      ],
    );
    showDialog(context: context, child: alert);
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

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

//ẩn/hiện button A theo focus chọn bài
  Widget buttonInPutA(bool status) {
    if (status) {
      return new Container(
          width: 80,
          margin: EdgeInsets.only(left: 12, top: 11, bottom: 11, right: 8),
          child: TextField(
            focusNode: FirstDisabledFocusNode(),
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
            textAlign: TextAlign.center,
            onTap: () => hideKeyboard(),
            decoration: new InputDecoration(
              hintText: output,
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(0xff2DBF56),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff2DBF56), width: 0),
              ),
            ),
          ));
    } else {
      return new Expanded(
          child: new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0, right: 0),
            child: new Text(
              inPutA.toString(),
              style: TextStyle(
                  fontSize: 36,
                  color: Color(0xffF79623),
                  fontWeight: FontWeight.bold),
            ),
          ));
    }
  }

  Widget buttonInPutB(bool status) {
    if (status) {
      return new Container(
          width: 80,
          margin: EdgeInsets.only(left: 8, top: 11, bottom: 11, right: 12),
          child: TextField(
            onTap: () => hideKeyboard(),
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              hintText: output,
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(0xff2DBF56),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff2DBF56), width: 0),
              ),
            ),
          ));
    } else {
      return new Expanded(
          child: new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0, right: 0),
            child: new Text(
              inPutB.toString(),
              style: TextStyle(
                  fontSize: 36,
                  color: Color(0xffF79623),
                  fontWeight: FontWeight.bold),
            ),
          ));
    }
  }

  Widget buttonInPutC(bool status) {
    if (status) {
      return new Container(
          width: 80,
          margin: EdgeInsets.only(left: 12, top: 11, bottom: 11, right: 12),
          child: TextField(
            onTap: () => hideKeyboard(),
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              hintText: output,
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Color(0xff2DBF56),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff2DBF56), width: 0),
              ),
            ),
          ));
    } else {
      return new Expanded(
          child: new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 12, right: 20),
            child: new Text(
              inPutC.toString(),
              style: TextStyle(
                  fontSize: 36,
                  color: Color(0xffF79623),
                  fontWeight: FontWeight.bold),
            ),
          ));
    }
  }

  Widget buttonInPutCalculation(bool status) {
    if (status) {
      return new Container(
        width: 30,
        alignment: Alignment.center,
        child: new Text(
          calculation,
          style: TextStyle(
              fontSize: 36,
              color: Color(0xffF79623),
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return new Expanded(
        child: new Container(
          child: new Text(
            '-',
            style: TextStyle(
                fontSize: 36,
                color: Color(0xffF79623),
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

//button nhập phím số
  Widget buildButton(String buttonText) {
    return new Expanded(
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 16),
        child: new RaisedButton(
          color: Color(0xff2D9CDB),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          child: new Text(
            buttonText,
            style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

//button check
  Widget buildButtonYes(String buttonText) {
    return new Expanded(
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 16),
        child: new RaisedButton(
          color: Color(0xff2DBF56),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          child: new Container(
            height: 18,
            width: 22,
            child: new Image.asset('assets/images/vector.png'),
          ),
          onPressed: () => checkResult(),
        ),
      ),
    );
  }

//button delete
  Widget buildButtonDelete(String buttonText) {
    return new Expanded(
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 16),
        child: new RaisedButton(
          color: Color(0xffF2994A),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          child: new Container(
            height: 18,
            width: 26,
            child: new Image.asset('assets/images/ic_dl.png'),
          ),
          onPressed: () => delete(output, _output),
        ),
      ),
    );
  }

  void onBacks() {
    advancedPlayer.stop();
    Navigator.of(context).pop();
  }

  Widget checkManHinh() {
    if (MediaQuery.of(context).orientation != Orientation.landscape) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: new Column(
            children: [
              new Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xff33000000),
                ),
                child: new Column(
                  children: <Widget>[

                    Row(children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 16, top: 6),
                        child: new Text(
                          'Chọn bài:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 48,
                          margin: EdgeInsets.only(top: 5),
                          child: CupertinoSegmentedControl(
                              borderColor: Color(0xff1AFFFFFF),
                              children: log,
                              groupValue: thisGroup,
                              onValueChanged: (value) {
                                thisGroup = value;
                                setState(() {
                                  inPutA = 0;
                                  inPutB = 0;
                                  inPutC = 0;
                                  output = "?";
                                  _output = "";
                                  if (value == 0) {
                                    statusTextA = false;
                                    statusTextB = false;
                                    statusTextC = true;
                                  } else if (value == 1) {
                                    statusTextA = true;
                                    statusTextB = false;
                                    statusTextC = false;
                                  } else {
                                    statusTextA = false;
                                    statusTextB = true;
                                    statusTextC = false;
                                  }
                                });
                              }),
                        ),
                      )
                    ]),
                    Row(children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 16, top: 0),
                        child: new Text(
                          'Phép tính:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 16),
                            child: BigButtons(
                              image: AssetImage('assets/images/ic_py.png'),
                              text: title,
                              onTap: () => showPopup(),
                            ),
                          ))

//                            child:new Row(
//                              children: <Widget>[
//                                new Expanded(child: new Text('aaaa',style: TextStyle(),textAlign: TextAlign.center,),),
//
//                                new Image.asset('assets/images/ic_py.png'),
//                              ],
//
                    ]),
                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        color: Color(0xffF2994A),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: () {
                          if (outputNumbers.isEmpty) {
                            randomTextA("100");
                            randomTextB("100");
                            randomTextC("100");
                          } else {
                            randomTextA(outputNumber);
                            randomTextB(outputNumber);
                            randomTextC(outputNumber);
                          }
                          checkRanDom();

                          setState(() {
                            output = '?';
                            _output = '';
                          });
                        },
                        child: Text(
                          'Chọn dữ liệu',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 100,
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xffFFFFFF),
                ),
                child: Row(
                  children: <Widget>[
                    buttonInPutA(statusTextA),
                    buttonInPutCalculation(statusCalculation),
                    buttonInPutB(statusTextB),
                    new Container(
                      child: new Text(
                        '=',
                        style: TextStyle(
                            fontSize: 36,
                            color: Color(0xffF79623),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    buttonInPutC(statusTextC),
                  ],
                ),
              ),
              new Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xffFFFFFF),
                  ),
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(top: 16),
                        child: new Row(children: [
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                        ]),
                      ),
                      new Row(children: [
                        buildButton("4"),
                        buildButton("5"),
                        buildButton("6"),
                      ]),
                      new Row(children: [
                        buildButton("3"),
                        buildButton("2"),
                        buildButton("1"),
                      ]),
                      new Row(children: [
                        buildButtonDelete("3"),
                        buildButton("0"),
                        buildButtonYes("2"),
                      ]),
                    ],
                  )),
              new Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xff4ACCF5),
                  ),
                  margin:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Align(
                          alignment: FractionalOffset.topCenter,
                          child: new SizedBox(
                            height: 50,
                            width: 500.0,
                            child: FlatButton(
                              onPressed: () {
                                checkResult();
                              },
                              color: Color(0xff4ACCF5),
                              child: Text(
                                'Kiểm tra kết quả',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Color(0xff33000000),
                            ),
                            child: new Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Padding(
                                      padding:
                                      const EdgeInsets.only(left: 16, top: 0),
                                      child: new Text(
                                        'Chọn bài:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 48,
                                        margin: EdgeInsets.only(top: 0),
                                        child: CupertinoSegmentedControl(
                                            borderColor: Color(0xff1AFFFFFF),
                                            children: log,
                                            groupValue: thisGroup,
                                            onValueChanged: (value) {
                                              thisGroup = value;
                                              setState(() {
                                                inPutA = 0;
                                                inPutB = 0;
                                                inPutC = 0;
                                                output = "?";
                                                _output = "";
                                                if (value == 0) {
                                                  statusTextA = false;
                                                  statusTextB = false;
                                                  statusTextC = true;
                                                } else if (value == 1) {
                                                  statusTextA = true;
                                                  statusTextB = false;
                                                  statusTextC = false;
                                                } else {
                                                  statusTextA = false;
                                                  statusTextB = true;
                                                  statusTextC = false;
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: <Widget>[
                                  new Padding(
                                    padding:
                                    const EdgeInsets.only(left: 16, top: 0),
                                    child: new Text(
                                      'Phép tính:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, top: 0, right: 14),
                                        child: BigButtons(
                                          image:
                                          AssetImage('assets/images/ic_py.png'),
                                          text: title,
                                          onTap: () => showPopup(),
                                        ),
                                      )),
//
                                ]),
                                new Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 4, right: 20),
                                  child: RaisedButton(
                                    color: Color(0xffF2994A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(24.0),
                                    ),
                                    onPressed: () {
                                      if (outputNumbers.isEmpty) {
                                        randomTextA("100");
                                        randomTextB("100");
                                        randomTextC("100");
                                      } else {
                                        randomTextA(outputNumber);
                                        randomTextB(outputNumber);
                                        randomTextC(outputNumber);
                                      }
                                      checkRanDom();

                                      setState(() {
                                        output = '?';
                                        _output = '';
                                      });
                                    },
                                    child: Text(
                                      'Chọn dữ liệu',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Row(
                              children: <Widget>[
                                buttonInPutA(statusTextA),
                                buttonInPutCalculation(statusCalculation),
                                buttonInPutB(statusTextB),
                                new Container(
                                  child: new Text(
                                    '=',
                                    style: TextStyle(
                                        fontSize: 36,
                                        color: Color(0xffF79623),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                buttonInPutC(statusTextC),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Color(0xffFFFFFF),
                              ),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: new Row(children: [
                                      buildButton("7"),
                                      buildButton("8"),
                                      buildButton("9"),
                                    ]),
                                  ),
                                  new Row(children: [
                                    buildButton("4"),
                                    buildButton("5"),
                                    buildButton("6"),
                                  ]),
                                  new Row(children: [
                                    buildButton("1"),
                                    buildButton("2"),
                                    buildButton("3"),
                                  ]),
                                  new Row(children: [
                                    buildButtonDelete("3"),
                                    buildButton("0"),
                                    buildButtonYes("2"),
                                  ]),
                                ],
                              )),
                          new Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Color(0xff4ACCF5),
                              ),
                              margin: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: new ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.topCenter,
                                      child: new SizedBox(
                                        height: 50,
                                        width: 500.0,
                                        child: FlatButton(
                                          onPressed: () {
                                            checkResult();
                                          },
                                          color: Color(0xff4ACCF5),
                                          child: Text(
                                            'Kiểm tra kết quả',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: new IconButton(
//          icon: SizedBox(
//              width: 24,
//              height: 24,
//              child: Image.asset('assets/images/ic_backs.png')),
//          onPressed: () => onBacks(),
//        ),
//        iconTheme: IconThemeData(color: Color(0xffFFE083)),
//        backgroundColor: Color(0xff2D9CDB),
//        bottomOpacity: 0.0,
//        elevation: 0.0,
        title: Text('Tính toán'),
      ),
      backgroundColor: Color(0xff2D9CDB),
      body: checkManHinh(),
    );
  }
}

class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
