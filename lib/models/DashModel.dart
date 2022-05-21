// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashModel {
  String title;
  IconData icon;
  String route;
  Color color;

  DashModel(
      {required this.icon,
      required this.color,
      required this.title,
      required this.route,
      });
}

Box<Receipt> box = Hive.box<Receipt>(boxName);
List data = [
  {
    'title': "SAVED RECEIPTS",
    'icon': Icons.receipt,
    'color': Colors.green,
    'route': "/savedreceipts"
  },
  {
    'title': "DEBTORS",
    'icon': Icons.person,
    'color': Colors.orange,
    'route': "/debtors"
  }
];
List<DashModel> d = List.generate(
  data.length,
  (index) => DashModel(
      color: data[index]['color'],
      icon: data[index]['icon'],
      title: data[index]['title'],
      route: data[index]['route']),
);
