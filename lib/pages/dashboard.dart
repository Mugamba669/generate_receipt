import 'package:flutter/material.dart';
import 'package:generate_rec/models/DashModel.dart';
import 'package:generate_rec/widgets/Body.dart';
import 'package:generate_rec/widgets/CardTiles.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Db/receipt.dart';
import '../Global/globals.dart';
import '../widgets/Space.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
// ignore_for_file: file_names

class DashModel {
  String title;
  IconData icon;
  String route;
  Color color;

  DashModel({
    required this.icon,
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

class _DashboardState extends State<Dashboard> {
  Box<Receipt> box = Hive.box<Receipt>(boxName);
  List<Receipt> list = [];
  List<Receipt> dataList = [];
  @override
  void initState() {
    super.initState();
    list = box.values.toList();
    for (var element in list) {
      if (element.amount < costPrice) {
        dataList.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Body(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh_rounded,
                size: 24,
              ))
        ],
      ),
      fab: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/newreceipt');
        },
        label: const Text("New receipt"),
      ),
      child: ListView(
        children: [
          CardTiles(
            press: () {
              Navigator.of(context).pushNamed(d[0].route);
            },
            icon: d[0].icon,
            total: box.values.length,
            color: d[0].color,
            title: d[0].title,
          ),
          CardTiles(
            press: () {
              Navigator.of(context).pushNamed(d[1].route);
            },
            icon: d[1].icon,
            total: dataList.length,
            color: d[1].color,
            title: d[1].title,
          )
        ],
      ),
    );
  }
}
