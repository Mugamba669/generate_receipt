// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
      width: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
