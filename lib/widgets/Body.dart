// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import 'fade_animation.dart';

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
      this.fab,
      Widget? box})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000), value: 6);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldkey,
      appBar: widget.appBar,
      drawer: widget.drawer,
      body: BottomTopMoveAnimationView(
        animationController: controller,
        child: Stack(
          children: [const Positioned(top: 10, child: Text("")), widget.child],
        ),
      ),
      floatingActionButton: widget.fab,
    );
  }
}
