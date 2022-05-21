import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatefulWidget {
  final VoidCallback press;
  final double width;
  Color? color = Colors.indigo[600];
  final double height;
  bool outline;
  Color? textColor;
  double? fontSize;
  final double radius;
  bool textbutton;
  String text;
  Button({
    Key? key,
    this.outline = false,
    required this.text,
    this.textbutton = false,
    required this.press,
    required this.width,
    required this.height,
    this.fontSize,
    this.color,
    this.textColor,
    required this.radius,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return widget.outline == true
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: widget.color,
              fixedSize: Size(widget.width, widget.height),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            onPressed: () => widget.press(),
            child: Text(widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize,
                )),
          )
        : widget.textbutton == false
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.color,
                  fixedSize: Size(widget.width, widget.height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                ),
                onPressed: () {
                  widget.press();
                },
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: widget.fontSize,
                  ),
                ),
              )
            : TextButton(
                onPressed: () => widget.press(),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: widget.fontSize,
                  ),
                ),
              );
  }
}
