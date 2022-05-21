// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/pages/dashboard.dart';
import 'package:generate_rec/pages/doc_view.dart';
import 'package:generate_rec/widgets/Body.dart';
import 'package:generate_rec/widgets/Button.dart';

import 'package:generate_rec/widgets/receiptTile.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Db/receipt.dart';
import '../Global/globals.dart';

class ReceiptView extends StatefulWidget {
  final Receipt box;
  final Box<Receipt>? receipts;
  int index;
  ReceiptView({Key? key, required this.index, required this.box, this.receipts})
      : super(key: key);

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  @override
  Widget build(BuildContext context) {
    return Body(
      appBar: AppBar(title: Text("${widget.box.name}'s receipt")),
      child: SafeArea(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      ReceiptTile(
                          name: "Customer name", value: widget.box.name),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box.pdtName,
                        name: 'Product paid',
                      ),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box.quantity,
                        name: 'Quantity',
                      ),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box.amount,
                        name: 'Amount paid',
                      ),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box.receiptDate,
                        name: 'Transaction Date',
                      ),
                      const Divider(),
                      ReceiptTile(
                        value: (widget.box.amount < costPrice)
                            ? (widget.box.amount - costPrice)
                            : "cleared",
                        name: 'Balance',
                      ),
                      const Divider(),
                      ReceiptTile(
                        value: widget.box.description,
                        name: 'Product description',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      (widget.box.amount < costPrice)
                          ? Container()
                          : Center(
                              child: Button(
                                  text: "Generate receipt",
                                  press: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
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
                      (widget.box.amount < costPrice)
                          ? Container()
                          : Center(
                              child: Button(
                                  outline: true,
                                  color: Colors.red,
                                  text: " Clear record",
                                  press: () {
                                    widget.receipts?.deleteAt(widget.index);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard()));
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
