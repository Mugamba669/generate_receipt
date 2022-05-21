// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  IconData? prefixIcon;
  TextInputAction? inputAction;
  ValueChanged<String> input;
  TextInputType? inputType;
  FormInput(
      {Key? key,
      this.controller,
      required this.input,
      this.inputAction = TextInputAction.next,
      this.inputType = TextInputType.text,
      this.prefixIcon,
      this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          // const BoxShadow(color: Colors.red, blurRadius: 2),
          BoxShadow(
              offset: const Offset(1.3, 1),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: .46),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
          onChanged: (value) => input(value),
          
          validator: (value) =>
              value!.isNotEmpty ? null : "This field is required ..",
          controller: controller,
          keyboardType: inputType,
          textInputAction: inputAction,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            prefixIcon: Icon(prefixIcon),
          )),
    );
  }
}
