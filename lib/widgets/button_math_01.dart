import 'package:flutter/material.dart';

class BigButtons extends StatelessWidget {
  final AssetImage image;
  final String text;
  final Function onTap;

  const BigButtons(
      {Key key, @required this.image, @required this.text, this.onTap})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Color(0xff1AFFFFFF),
        ),height: 28,
        width: 100,
        child: Row(
          children: <Widget>[

            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title

                      .copyWith(fontSize: 14, color: Colors.white),
                  ),
                )),
           Padding(
             padding: const EdgeInsets.only(right: 16),
             child: Image(
               image: image,
               width: 12,
               height: 12,
               fit: BoxFit.cover,
             ),
           )

          ],
        ),
      ),
    );
  }
}
