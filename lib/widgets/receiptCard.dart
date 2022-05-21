// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../Global/globals.dart';

class ReceiptCard extends StatelessWidget {
  String title;
  double paid;
  VoidCallback tap;
  ReceiptCard({Key? key, required this.paid,required this.tap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () => tap(),
          title: Text(title),
          subtitle: (paid < costPrice)
              ? Text('Balance: ${costPrice - paid}')
              : const Text('Balance: no balance'),
          trailing: Chip(
            backgroundColor: (paid < costPrice)
                ? Colors.red.shade100
                : Colors.green.shade100,
            label: (paid < costPrice)
                ? const Icon(
                    Icons.pending_actions_rounded,
                    color: Colors.red,
                  )
                : const Icon(Icons.verified_rounded, color: Colors.green),
            // avatar: ,
          ),
        ),
      ),
    );
  }
}
