import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';

class PdfViewerScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  const PdfViewerScreen({Key? key, required this.pdfBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Quiz Result PDF"),
      body: SfPdfViewer.memory(pdfBytes),
    );
  }
}
