// ignore_for_file: file_names, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/models/DashModel.dart';
import 'package:generate_rec/pages/receipt.dart';
import 'package:generate_rec/widgets/Button.dart';
import 'package:generate_rec/widgets/form_input.dart';
import 'package:generate_rec/widgets/receiptCard.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/CommonView.dart';

class Debtors extends StatefulWidget {
  const Debtors({
    Key? key,
  }) : super(key: key);

  @override
  State<Debtors> createState() => _DebtorsState();
}

class _DebtorsState extends State<Debtors> {
  Box<Receipt> store = Hive.box<Receipt>(boxName);
  List<Receipt> storeList = [];
  List<Receipt> dbList = [];
  @override
  void initState() {
    super.initState();
    storeList = store.values.toList();
    for (var element in storeList) {
      if (element.amount < costPrice) {
        dbList.add(element);
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
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 8)),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      if (dbList.isNotEmpty) {
                        return ReceiptCard(
                            tap: () => showSaveDialog(index),
                            paid: dbList[index].amount,
                            title: dbList[index].name);
                      } else {
                        return const Center(
                          child: Text("No debtors"),
                        );
                      }
                    },
                    itemCount: dbList.length,
                  );
          },
        ),
      ),
    );
  }

  showSaveDialog(int id) {
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
                        const Text("Update product price",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )),
                        Text("-${costPrice - (box.getAt(id)!.amount)}",
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
                              Box<Receipt> update = Hive.box(boxName);
                              var old = box.getAt(id);
                              update.putAt(
                                  id,
                                  Receipt(
                                      name: old!.name,
                                      amount: (old.amount +
                                          double.parse(updateController.text)),
                                      pdtName: old.pdtName,
                                      description: old.description,
                                      quantity: old.quantity,
                                      receiptDate: old.receiptDate));
                              updateController.clear();
                              ScaffoldMessenger(
                                child: SnackBar(
                                  content: Text("${old.name} updated"),
                                ),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const Debtors()),
                              );
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
