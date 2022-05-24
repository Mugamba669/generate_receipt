import 'dart:async';
import 'dart:typed_data';
import 'package:generate_rec/widgets/CommonView.dart';
import 'package:generate_rec/widgets/Loader.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';

import '../Db/record.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/pdf_widget.dart';

class DocView extends StatefulWidget {
  final Record? box;
  const DocView({Key? key, required this.box}) : super(key: key);

  @override
  State<DocView> createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  Future<Uint8List> pdfFile(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) => pw.Center(
            child: pw.Padding(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(15),
                child: pw.PdfLogo(),
              ),
              pw.SizedBox(height: 50),

              // pw.Signature(),
              PdfTile(name: "Customer name", value: widget.box!.owner),
              PdfTile(
                value: widget.box!.date,
                name: 'Date of transaction',
              ),
              pw.Divider(),

              pw.Center(
                  child: pw.Text("Products summary",
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Padding(
                padding: const pw.EdgeInsets.all(15),
                child: pw.Table(
                  children: [
                    pw.TableRow(children: [
                      pw.Text("Product"),
                      pw.Text("Qty"),
                      pw.Text("Price"),
                      pw.Text("Amount"),
                    ]),
                    // pw.SizedBox(height: 10),
                    /**'pdtName': controllers[0].text,
        'pdtPrice': pPrice,
        'qauntity': pQuantity,
        'amt_paid': ppaid,
        'cost_price': cost_price,
        'balance' */
                    for (var i = 0; i < widget.box!.data.length; i++)
                      pw.TableRow(children: [
                        pw.Text(
                          widget.box!.data[i]['pdtName'],
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(widget.box!.data[i]['quantity'].toString()),
                        pw.Text(widget.box!.data[i]['pdtPrice'].toString()),
                        pw.Text(widget.box!.data[i]['amt_paid'].toString()),
                        // pw.Text(widget.box!.data[i]['balance'].toString())
                      ])
                  ],
                ),
              ),

              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              PdfTile(name: "Total Amount paid", value: widget.box!.totalPaid),
              PdfTile(
                  name: "Total Product Price",
                  value: widget.box!.totalCostPrice),
              PdfTile(
                  name: "Balance ",
                  value:
                      (widget.box!.totalCostPrice! - widget.box!.totalPaid!)),
            ],
          ),
        )),
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return CommonView(
      showFab: false,
      title: 'Print Receipt',
      child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader(iosStyle: true, text: "Loading document....");
            } else {
              return Center(
                child: PdfPreview(
                  initialPageFormat: PdfPageFormat.standard,
                  build: (format) => pdfFile(format),
                  pdfFileName: widget.box!.receiptId,
                  pdfPreviewPageDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  loadingWidget:
                      Loader(iosStyle: true, text: "Processing document...."),
                ),
              );
            }
          }),
    );
  }
}
