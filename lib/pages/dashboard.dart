import 'package:flutter/material.dart';
import 'package:generate_rec/widgets/CardTiles.dart';
import 'package:generate_rec/widgets/CommonView.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Db/receipt.dart';
import '../Db/record.dart';
import '../Global/globals.dart';
import 'debtors.dart';

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
  Box<Record> recs = Hive.box<Record>(records);
  List<Record> list = [];
  List<Record> debtors = [];
  @override
  void initState() {
    super.initState();
     list = recs.values.toList();
    // get number of debtors

    debtors = list.where((element) => (element.totalPaid! < element.totalCostPrice!)).toList(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: "Dashboard",
      child: ListView(
        children:  [
          CardTiles(
            press: () {
              Navigator.of(context).pushNamed(d[0].route);
            },
            icon: d[0].icon,
            total: recs.values.length,
            color: d[0].color,
            title: d[0].title,
          ),
          CardTiles(
            press: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Debtors(rec: debtors)));
            },
            icon: d[1].icon,
            total: debtors.length,
            color: d[1].color,
            title: d[1].title,
          )
        ],
      ),
    );
  }
}
