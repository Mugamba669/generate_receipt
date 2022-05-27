// ignore_for_file: file_names, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
// import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Db/record.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/models/DashModel.dart';
import 'package:generate_rec/widgets/Button.dart';
import 'package:generate_rec/widgets/Loader.dart';
import 'package:generate_rec/widgets/form_input.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/CommonView.dart';
import '../widgets/receiptCard.dart';

class Debtors extends StatefulWidget {
  List<Record>? rec;
  Debtors({Key? key, this.rec}) : super(key: key);

  @override
  State<Debtors> createState() => _DebtorsState();
}

class _DebtorsState extends State<Debtors> {
  Box<Record> store = Hive.box<Record>(records);
  List<Record> storeList = [];
  List dbList = [];
  @override
  void initState() {
    super.initState();
    storeList = store.values.toList();
    for (var element in storeList) {
      for (var d in element.data) {
        dbList.add(d);
      }
    }
  }

  final updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CommonView(
      search: true,
      title: 'Debtors',
      child: Center(
        child: widget.rec!.isEmpty
            ? const Text(
                "No Debtors Available",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              )
            : FutureBuilder(
                future: Future.delayed(const Duration(seconds: 8)),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: Loader(
                              iosStyle: false, text: "Loading debtors...."),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return ReceiptCard(
                                tap: () => showUpdateDialog(index),
                                paid: widget.rec![index].paid,
                                title: widget.rec![index].owner);
                          },
                          itemCount: widget.rec!.length,
                        );
                },
              ),
      ),
    );
  }

  showUpdateDialog(int id) {
    double x = (widget.rec![id].totalPaid!);
    double y = (widget.rec![id].totalCostPrice!);
    double? bal = (y - x);
    // print(y);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Current Balance",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )),
                        Text("-$bal",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.red)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: 60,
                    child: FormInput(
                      controller: updateController,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.go,
                      input: (input) {},
                      hint: "Enter new amount paid",
                      prefixIcon: Icons.monetization_on_rounded,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Button(
                            text: "Update",
                            press: () {
                              Box<Record> update = Hive.box<Record>(records);
                              List<Record> u =
                                  update.values.toList(growable: true);
                              for (int i = 0; i < u.length; i++) {
                                if (u[i].receiptId ==
                                    widget.rec![id].receiptId) {
                                  var old = box.getAt(i);
                                  update.putAt(
                                    i,
                                    Record(
                                      owner: old!.owner,
                                      totalPaid: (old.totalPaid! +
                                          double.parse(updateController.text)),
                                      totalCostPrice: old.totalCostPrice,
                                      date: old.date,
                                      data: old.data,
                                      receiptId: old.receiptId,
                                      amount: old.amount,
                                      ttcost: old.ttcost,
                                    ),
                                  );

                                  updateController.clear();
                                  ScaffoldMessenger(
                                    child: SnackBar(
                                      content: Text("${old.owner}'s updated"),
                                    ),
                                  );
                                  Navigator.of(context).pushNamed('/');
                                }
                              }
                            },
                            width: 100,
                            height: 30,
                            radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Button(
                          outline: true,
                          text: "Cancel",
                          press: () {
                            updateController.text = "";
                            // close(context, null);
                            Navigator.of(context).pop();
                          },
                          width: 100,
                          height: 30,
                          radius: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
