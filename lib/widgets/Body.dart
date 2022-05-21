// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Widget child;
  PreferredSizeWidget? appBar;
  Widget? drawer;
  GlobalKey<ScaffoldState>? scaffoldkey;
  Widget? fab;
  Body(
      {Key? key,
      required this.child,
      this.drawer,
      this.appBar,
      this.scaffoldkey,
      this.fab, Widget? box})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldkey,
      appBar: widget.appBar,
      drawer: widget.drawer,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              child: Text(""),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: widget.child,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: widget.fab,
    );
  }
}
