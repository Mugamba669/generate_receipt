import 'package:flutter/material.dart';

class ProcessWidget extends StatelessWidget {
  const ProcessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: CircularProgressIndicator.adaptive(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Processing..."),
          )
        ],
      ),
    );
  }
}
