import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

///syncfusion_flutter_pdfviewer
class PdfViewer extends StatefulWidget {
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      // body: SfPdfViewer.network(
      //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      //   key: _pdfViewerKey,
      // ),
      body: SfPdfViewer.asset(
        'assets/Android.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
