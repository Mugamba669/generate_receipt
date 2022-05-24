// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTile extends pw.StatelessWidget {
  String name;
  var value;
  // ignore: non_constant_identifier_names
  PdfTile({Key? key, required this.name, required this.value});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(15.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            name,
            style: const pw.TextStyle(
              fontSize: 18,
            ),
          ),
          pw.Text(
            (value is String) ? value : '$value',
            style: const pw.TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
