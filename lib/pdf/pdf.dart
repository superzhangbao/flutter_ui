import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_ui/pdf/report.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'dart:async';


import 'package:pdf/widgets.dart' as pw;

class Pdf extends StatefulWidget {
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  String generatedPdfFilePath;
  String path;
  String fileName= "test.pdf";
  bool show = false;

  // Future<void> _saveAsFile(
  //   BuildContext context,
  //   LayoutCallback build,
  //   PdfPageFormat pageFormat,
  // ) async {
  //   final bytes = await build(pageFormat);
  //
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final appDocPath = appDocDir.path;
  //   final file = File(appDocPath + '/' + 'document.pdf');
  //   print('Save as file ${file.path} ...');
  //   await file.writeAsBytes(bytes);
  //   await OpenFile.open(file.path);
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
   return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () async {
              //Save and launch the file.
              // await buildPdf(PdfPageFormat.a4);
              // await generateReport(PdfPageFormat.a4);
              savePdf(generateReport(PdfPageFormat.a4));
              // await generateExampleDocument();
              setState(() {
                show = true;
              });
              // _saveAsFile(context, (constraints) { }, pageFormat)
            },
          ),
        ],
      ),
      // body: SfPdfViewer.network(
      //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      //   key: _pdfViewerKey,
      // ),
      body: show
          ? SfPdfViewer.file(
        File('$path/$fileName'),
        key: _pdfViewerKey,
      )
          : Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text("aaa"),
            ),
    );
  }

  /// This method takes a page format and generates the Pdf file data
  Future<void> buildPdf(PdfPageFormat format) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.ConstrainedBox(
            constraints: pw.BoxConstraints.expand(),
            child: pw.FittedBox(
              child: pw.Text('Hello World'),
            ),
          );
        },
      ),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    path = documentDirectory.path;
    File file = File("$path/$fileName");
    print('file:$file');
    file.writeAsBytesSync(await doc.save()); //t
    // Build and return the final Pdf file data
    // await doc.save();

    // final bytes = LayoutCallback;
    //
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final appDocPath = appDocDir.path;
    // final file = File(appDocPath + '/' + 'document.pdf');
    // print('Save as file ${file.path} ...');
    // await file.writeAsBytes(bytes);
    // await OpenFile.open(file.path);
    // await FileSaveHelper.saveAndLaunchFile2(, 'test.pdf');
    // await _getFilePath();
  }

  Future<void> _getFilePath() async {
    final Directory directory = await getApplicationSupportDirectory();
    path = directory.path;
  }

Future savePdf(Future<Uint8List> data) async {
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  path = documentDirectory.path;
  File receiptFile = File("$path/$fileName");
  receiptFile.writeAsBytesSync(await data); //this line shows error pdf.save() is highlighted in red line
}


//SfPdfViewer.asset(
//               'assets/Android.pdf',
//               key: _pdfViewerKey,
//             )

  Future<void> generateExampleDocument() async {
    final htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
        
        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>
        
        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
    print('generatedPdfFilePath:$generatedPdfFilePath');
  }
}
