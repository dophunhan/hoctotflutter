import 'package:flutter/material.dart';

class BigBaiTapButton extends StatelessWidget {
  final AssetImage image;
  final String text;
  final Function onTap;

  const BigBaiTapButton(
      {Key key,
        @required this.image,
        @required this.text,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Image(
                  image: image,
                  width: 40,
                  height: 40,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
