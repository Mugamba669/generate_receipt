import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  String text;
  bool iosStyle;
  Loader({Key? key , required this.iosStyle,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2),
              child:iosStyle == true ?const CupertinoActivityIndicator.partiallyRevealed():const CircularProgressIndicator(),
            ),
             Padding(
              padding: const EdgeInsets.all(10),
              child: Text(text),
            )
          ],
        ));
  }
}
