// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/pages/receipt.dart';
import 'package:generate_rec/widgets/receiptCard.dart';
import 'package:hive_flutter/adapters.dart';

import '../widgets/CommonView.dart';

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
          valueListenable: Hive.box<Receipt>(boxName).listenable(),
          builder: (context, Box<Receipt> box, widget) {
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
                            paid: data!.amount,
                            title: data.name,
                            tap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ReceiptView(
                                    index: index, box: data, receipts: box),
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
