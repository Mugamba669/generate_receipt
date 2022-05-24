// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/pages/newreceipt.dart';
import 'package:generate_rec/pages/receipt.dart';
import 'package:hive_flutter/adapters.dart';

import '../Db/record.dart';
import '../widgets/CommonView.dart';
import '../widgets/receiptCard.dart';

class SavedReceipts extends StatefulWidget {
  const SavedReceipts({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedReceipts> createState() => _SavedReceiptsState();
}

class _SavedReceiptsState extends State<SavedReceipts> {
  @override
  Widget build(BuildContext context) {
    return CommonView(
      search: true,
      title: 'Saved Receipts',
      child: ValueListenableBuilder(
          valueListenable: Hive.box<Record>(records).listenable(),
          builder: (context, Box<Record> box, widget) {
            if (box.isEmpty)
              // ignore: curly_braces_in_flow_control_structures
              return const Center(
                child: Text(
                  "You no saved receipts yet",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            return FutureBuilder(
              future: Future.delayed(const Duration(seconds: 3)),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          var data = box.getAt(index);

                          return ReceiptCard(
                            paid: (data!.totalPaid! < data.totalCostPrice!) && (data.totalPaid! != 0.0 && data.totalCostPrice! != 0.0) ,
                            title: data.receiptId,
                            owner: data.owner,
                            tap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewReceipt(
                                  box: data,
                                  index: index,
                                  record: box,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: box.length,
                      );
              },
            );
          }),
    );
  }
}
