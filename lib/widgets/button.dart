import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final AssetImage image;
  final String text;
  final Function onTap;
  final AssetImage images;

  const BigButton(
      {Key key,
      @required this.image,
      @required this.text,
      this.onTap,
      this.images})
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
                width: 100,
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Image(
                  image: images,
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
