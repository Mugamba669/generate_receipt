import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                bottom: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Receipt generator",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    CircularProgressIndicator.adaptive(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text("Loading..."),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
