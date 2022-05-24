// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/Db/record.dart';
import 'package:generate_rec/widgets/Body.dart';
import 'package:generate_rec/widgets/Loader.dart';
import 'package:generate_rec/widgets/Space.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../Global/globals.dart';
import '../widgets/Button.dart';
import '../widgets/receiptTile.dart';
import 'doc_view.dart';

class ReceiptView extends StatefulWidget {
  final Record? box;
  final Box<Record>? receipts;
  int index;
  ReceiptView({Key? key, required this.index, required this.box, this.receipts})
      : super(key: key);

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  Box<Record> rc = Hive.box<Record>(records);
  double tem = 0.0;
  @override
  Widget build(BuildContext context) {
    return Body(
      appBar: AppBar(title: Text("${widget.box!.owner}'s receipt")),
      child: SafeArea(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Loader(iosStyle: false, text: "Loading receipt..")
                : ListView(
                    children: [
                      ReceiptTile(
                          name: "Customer name", value: widget.box!.owner),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box!.date,
                        name: 'Date',
                      ),
                      const Divider(),
                      const Center(
                        child: Text(
                          "Products summary",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Space(),
                      const SizedBox(
                        height: 10,
                        width: 2,
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      const Space(),
                      SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        child: Table(
                          // border: const TableBorder(bottom: BorderSide(),top: BorderSide(),left: BorderSide(),right: BorderSide()),
                          children: [
                            const TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Product"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Qty"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Price"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Amount"),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: Text("Balance"),
                              // )
                            ]),
                            /**'pdtName': controllers[0].text,
        'pdtPrice': pPrice,
        'qauntity': pQuantity,
        'amt_paid': ppaid,
        'cost_price': cost_price,
        'balance' */
                            for (var i = 0; i < widget.box!.data.length; i++)
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.box!.data[i]['pdtName'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.box!.data[i]['quantity']
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.box!.data[i]['pdtPrice']
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.box!.data[i]['amt_paid']
                                      .toString()),
                                ),
                                // Text(widget.box!.data[i]['balance'].toString())
                              ])
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Center(
                        child: Button(
                            text: "Generate receipt",
                            press: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DocView(
                                          box: widget.box,
                                        ))),
                            width: 200,
                            height: 40,
                            radius: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Center(
                        child: Button(
                            outline: true,
                            color: Colors.red,
                            text: " Clear record",
                            press: () {
                              print(widget.index);
                              // rc.deleteAt(widget.index);
                              //  Navigator.of(context).pushNamed('/');
                            },
                            width: 200,
                            height: 40,
                            radius: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
