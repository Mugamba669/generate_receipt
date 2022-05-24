import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/pages/dashboard.dart';
import 'package:generate_rec/pages/receipt.dart';
import 'package:generate_rec/widgets/Space.dart';
import 'package:generate_rec/widgets/form_input.dart';
import 'package:hive/hive.dart';

import '../Db/record.dart';
import '../models/receiptmodel.dart';
import '../widgets/Button.dart';
import '../widgets/CommonView.dart';
import 'saved.dart';

class NewReceipt extends StatefulWidget {
  int index;
  Box<Record>? record;
  Record? box;
  NewReceipt({Key? key, this.box, required this.index, this.record})
      : super(key: key);

  @override
  State<NewReceipt> createState() => _NewReceiptState();
}

class _NewReceiptState extends State<NewReceipt> {
  List<ReceiptModal> form = ReceiptModal.data;
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  GlobalKey<FormFieldState>? formKey = GlobalKey<FormFieldState>();
  Future<void> showDatePickerObject(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // currentDate: ,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1, 1, 30),
      lastDate: DateTime(2047, 9, 7, 17, 30),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked
            .toString()
            .replaceAll("00", "")
            .replaceFirst("::", "")
            .replaceFirst(".0", "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
      showFab: false,
      title: 'Add ${widget.box!.owner}\'s records',
      child: SingleChildScrollView(
        child: Form(
          key: formKey!,
          child: Column(
            children: List.generate(
              form.length + 1,
              (index) => index != (form.length)
                  ? FormInput(
                      hint: form[index].hint,
                      controller: controllers[index],
                      inputType: form[index].inputType,
                      prefixIcon: form[index].prefixIcon,
                      input: (String value) {
                        if (form[index].inputType == TextInputType.datetime) {
                          showDatePickerObject(controllers[index]);
                        }
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Button(
                              outline: false,
                              height: 45,
                              press: () => updateRecord(),
                              radius: 50,
                              text: 'Save new record',
                              width: MediaQuery.of(context).size.width / 1.15,
                            ),
                            const Space(),
                            Button(
                              outline: true,
                              height: 45,
                              press: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ReceiptView(
                                          index: index,
                                          box: widget.box,
                                        )));
                              },
                              radius: 50,
                              text: 'Preview Receipt',
                              width: MediaQuery.of(context).size.width / 1.15,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  double computeCashUsed(List<double>? value) {
    double result = 0.0;
    for (int i = 0; i < value!.length; i++) {
      result += value[i];
    }
    return result;
  }

  updateRecord() {
    if (controllers[0].text != "" &&
        controllers[1].text != "" &&
        controllers[2].text != "" &&
        controllers[3].text != "") {
      Record? update = widget.box;
      Box<Record> newReceipt = Hive.box<Record>(records);
      double pPrice = double.parse(controllers[1].text);
      double pQuantity = double.parse(controllers[2].text);
      double ppaid = double.parse(controllers[3].text);
      double costPrice = (pPrice * pQuantity);
      double pbal = ((pPrice * pQuantity) - ppaid);
      var col = {
        'pdtName': controllers[0].text,
        'pdtPrice': pPrice,
        'quantity': pQuantity,
        'amt_paid': ppaid,
        'cost_price': costPrice,
        'balance': pbal,
      };
      
      update!.owner = widget.box!.owner;
      update.data.add(col);
      update.receiptId = widget.box!.receiptId;
      update.amount?.add(ppaid);
      update.date = DateTime.now();
      update.paid = true;
      update.ttcost?.add(pPrice * pQuantity);
      update.totalCostPrice = computeCashUsed(update.ttcost);
      update.totalPaid = computeCashUsed(update.amount);

      newReceipt.putAt(widget.index, update).then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: 'Back to records',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedReceipts(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
                // backgroundColor: Colors.green[900],
                duration: const Duration(seconds: 6),
                behavior: SnackBarBehavior.floating,
                content: const Text("New record added"),
              ),
            ),
          );

      for (var element in controllers) {
        element.clear();
      }
    }
  }
}
