import 'package:flutter/material.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/pages/dashboard.dart';
import 'package:generate_rec/widgets/form_input.dart';
import 'package:hive/hive.dart';

import '../models/receiptmodel.dart';
import '../widgets/Button.dart';
import '../widgets/CommonView.dart';

class NewReceipt extends StatefulWidget {
  const NewReceipt({Key? key}) : super(key: key);

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
      title: 'New record',
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
                      child: Button(
                        outline: false,
                        height: 45,
                        press: () {
                          var collected = {
                            'field1': controllers[0].text,
                            'field2': controllers[1].text,
                            'field3': controllers[2].text,
                            'field4': controllers[3].text,
                            'field5': controllers[4].text,
                            'field6': controllers[5].text,
                          };
                          // if (formKey!.currentState!.validate()) {
                          Box<Receipt> newReceipt = Hive.box<Receipt>(boxName);

                          newReceipt.add(
                            Receipt(
                              amount:
                                  double.parse(collected['field3'].toString()),
                              quantity:
                                  int.parse(collected['field5'].toString()),
                              name: collected['field1'].toString(),
                              receiptDate: collected['field4'].toString(),
                              description: collected['field6'].toString(),
                              pdtName: collected["field2"].toString(),
                            ),
                          );
                          for (var element in controllers) {
                            element.clear();
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green[900],
                              duration: const Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                              content: const Text("New record added"),
                            ),
                          );
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                          // }
                        },
                        radius: 50,
                        text: 'Save new record',
                        width: MediaQuery.of(context).size.width / 1.15,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
