// ignore_for_file: file_names, must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Db/record.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/pages/debtors.dart';
import 'package:generate_rec/widgets/receiptCard.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:search_page/search_page.dart';
import '../pages/addToReceipt.dart';
import '../pages/receipt.dart';
import 'Body.dart';

class CommonView extends StatefulWidget {
  Widget child;
  String title;
  bool search;
  bool showFab;
  CommonView(
      {Key? key,
      required this.child,
      this.showFab = true,
      required this.title,
      this.search = false})
      : super(key: key);

  @override
  State<CommonView> createState() => _CommonViewState();
}

class _CommonViewState extends State<CommonView> {
  void routeManager(String route) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(route);
  }

  Box<Record> searchData = Hive.box<Record>(records);
  List<Record> searchList = [];
  List<Record> dataList = [];
  List<Record> debtors = [];
  @override
  void initState() {
    debtors = searchData.values
        .toList(growable: true)
        .where((element) => (element.totalPaid! < element.totalCostPrice!))
        .toList(growable: true);
    super.initState();
    dataList = searchData.values.toList();
    for (var element in dataList) {
      searchList.add(element);
      // print("element: ${element.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Body(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.search == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearchView(),
              ),
            )
          else
            const Text(""),
        ],
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const CircleAvatar()),
                accountName: const Text(
                  "Receipt Generator",
                  style: TextStyle(
                    // fontFamily: 'Dancing',
                    fontSize: 23,
                  ),
                ),
                accountEmail: const Text(""),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text("Dashboard"),
                onTap: () => routeManager("/"),
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.receipt_rounded),
                  title: const Text("Saved Receipts"),
                  onTap: () => routeManager("/savedreceipts")),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Debtors"),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Debtors(
                      rec: debtors,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      fab: widget.showFab == true
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              onPressed: () => showAddReceipt(),
              label: const Text("New receipt"),
            )
          : Container(),
      child: widget.child,
    );
  }

  showAddReceipt() {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
                padding: EdgeInsets.zero,
                child: BottomSheet(
                    elevation: 12,
                    backgroundColor: Colors.transparent,
                    onClosing: () {},
                    builder: (context) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: const AddToReceipt(),
                      );
                    })),
          );
        });
  }

  showSearchView() {
    showSearch(
      context: context,
      delegate: SearchPage<Record>(
        // onQueryUpdate: (s) => print(s),
        items: searchList,
        searchLabel: 'Search here....',
        suggestion: const Center(
          child: Text('Search by customer name or product name'),
        ),
        failure: const Center(
          child: Text('No record found :('),
        ),
        filter: (item) => [item.owner, item.receiptId],
        builder: (result) => ReceiptCard(
            paid: result.paid,
            tap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ReceiptView(index: 0, box: result, receipts: searchData),
                ),
              );
            },
            title: result.owner),
      ),
    );
  }
}
