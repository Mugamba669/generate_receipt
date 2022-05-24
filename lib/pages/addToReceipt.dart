import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/Global/globals.dart';
import 'package:generate_rec/widgets/Body.dart';
import 'package:generate_rec/widgets/Button.dart';
import 'package:generate_rec/widgets/Space.dart';
import 'package:generate_rec/widgets/form_input.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../Db/record.dart';

class AddToReceipt extends StatefulWidget {
  const AddToReceipt({Key? key}) : super(key: key);

  @override
  State<AddToReceipt> createState() => _AddToReceiptState();
}

class _AddToReceiptState extends State<AddToReceipt> {
  Box<Record> record = Hive.box<Record>(records);
  Uuid id = const Uuid();
  @override
  void initState() {
    super.initState();

    record.watch().listen((event) {
      setState(() {});
    });
  }

  final TextEditingController _name = TextEditingController();
  void dispose(){
    super.dispose();
    _name.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
         const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Create new receipt",
              textScaleFactor: 1.4,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          FormInput(
            focus: true,
            controller: _name,
            input: (String value) {},
            hint: 'Enter receipt owner\'s name',
          ),
          const Space(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(

              press: () => saveNewRecord(),
              color: Colors.green[700],
              fontSize: 18,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 50,
              text: 'Create Receipt',
              radius: 15,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(
              outline: false,
              press: () => cancelReceipt(),
              color: Colors.red[900],
              fontSize: 18,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 50,
              text: 'Cancel',
              radius: 15,
            ),
          ),
        ],
      ),
    );
  }
  cancelReceipt(){
    Navigator.of(context).pop();
    _name.clear();
  }
  saveNewRecord() {
    Navigator.of(context).pop();
    Record r = Record(
      owner: _name.text,
      receiptId: 'REC_${id.v1()}',
      amount: [],
      data: [],
      date: DateTime.now(),
      totalCostPrice: 0,
      totalPaid: 0,
      ttcost: [],
      paid: true,
    );
    record.add(r).whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Record added'),
            ),
          ),
        );
    Navigator.of(context).pushNamed('/');
  }
}
