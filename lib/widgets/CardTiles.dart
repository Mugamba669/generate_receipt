// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTiles extends StatelessWidget {
  int total;
  String title;
  IconData icon;
  Color? color;
  VoidCallback press;
  CardTiles(
      {Key? key,
      required this.press,
      required this.icon,
      required this.title,
      required this.total,
      this.color = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Card(
        child: SizedBox(
          height: 180,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$total',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tap to view"),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: color!.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        icon,
                        color: color,
                        size: 26,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
