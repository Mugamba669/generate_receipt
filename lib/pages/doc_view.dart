import 'dart:async';
import 'dart:typed_data';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/widgets/CommonView.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generate_rec/widgets/Body.dart';
import 'dart:math' as m;

class DocView extends StatefulWidget {
  final Receipt box;
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
          child: pw.Text("Hi from pdf writer"),
        ),
      ),
    );
    m.Random random = m.Random();
    int id = random.nextInt(100);
    // if (await Permission.storage.request().isGranted) {
    // getTemporaryDirectory().then((dir) async {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return const Dialog(
    //           backgroundColor: Colors.transparent,
    //           child: ProcessWidget(),
    //         );
    //       });

    //   final file = File('${dir.path}/test$id.pdf');
    //   file.writeAsBytesSync(await pdf.save());
    //   Timer(const Duration(seconds: 3), () => Navigator.of(context).pop());
    //   if (kDebugMode) {
    //     print(file.path);
    //   }
    // });
    return pdf.save();
  }

/**
 * pw.Column(
            children: [
              // pw.PdfLogo(),
              // pw.SizedBox(height: 100),
              PdfTile(name: "Customer name", value: widget.box.name),
              pw.Divider(),
              PdfTile(
                value: widget.box.pdtName,
                name: 'Product paid',
              ),
              pw.Divider(),
              PdfTile(
                value: widget.box.quantity,
                name: 'Quantity',
              ),
              pw.Divider(),
              PdfTile(
                value: widget.box.amount,
                name: 'Amount paid',
              ),
              pw.Divider(),
              PdfTile(
                value: widget.box.receiptDate,
                name: 'Transaction Date',
              ),
              pw.Divider(),
              PdfTile(
                value: (widget.box.amount < costPrice)
                    ? (widget.box.amount - costPrice)
                    : "cleared",
                name: 'Balance',
              ),
              pw.Divider(),
              PdfTile(
                value: widget.box.description,
                name: 'Product description',
              ),
              pw.Divider()
            ],
          ),
 */
  @override
  Widget build(BuildContext context) {
    return CommonView(
      showFab: false,
      title: 'Print Receipt',
      child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: PdfPreview(
                  build: (format) => pdfFile(format),
                ),
              );
            }
          }),
    );
  }
}
