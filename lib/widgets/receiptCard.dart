// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:generate_rec/Db/record.dart';

class ReceiptCard extends StatelessWidget {
  String title;
  String? owner;
  bool? paid;
  VoidCallback tap;
  ReceiptCard(
      {Key? key,
      this.paid = false,
      this.owner = '',
      required this.tap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () => tap(),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'for $owner!',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
          trailing: Chip(
            backgroundColor:
                (paid == true) ? Colors.red.shade100 : Colors.green.shade100,
            label: (paid == true)
                ? const Icon(
                    Icons.pending_actions_rounded,
                    color: Colors.red,
                  )
                : const Icon(Icons.verified_rounded, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
