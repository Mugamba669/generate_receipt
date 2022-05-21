import 'package:flutter/material.dart';

class ReceiptModal {
  String? hint;
  IconData? prefixIcon;
  TextInputAction? inputAction;
  TextInputType? inputType;
  ReceiptModal({this.hint, this.prefixIcon, this.inputAction, this.inputType});

  static List<ReceiptModal> data = [
    ReceiptModal(
        hint: "Enter customer's name",
        prefixIcon: Icons.person,
        inputType: TextInputType.text),
    ReceiptModal(
        hint: "Enter product name",
        prefixIcon: Icons.text_fields,
        inputType: TextInputType.text),
    ReceiptModal(
        hint: "Enter amount paid",
        prefixIcon: Icons.monetization_on_rounded,
        inputType: TextInputType.number),
    ReceiptModal(
        hint: "Enter transaction date",
        prefixIcon: Icons.date_range_rounded,
        inputType: TextInputType.datetime),
    ReceiptModal(
        hint: "Enter product quantity",
        prefixIcon: Icons.category_rounded,
        inputType: TextInputType.number),
    ReceiptModal(
        hint: "Enter product description",
        prefixIcon: Icons.description_rounded,
        inputType: TextInputType.text),
  ];
}
