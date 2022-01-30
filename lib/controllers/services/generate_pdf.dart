import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfApi {
  static Future<pw.Widget> createTable(int start, int end) async {
    List<pw.TableRow> _tableChildren = [];
    List<pw.Widget> _rowChildren = [];
    int count = 0;
    for (int i = start; i <= end; i++) {
      Uint8List _qrImageBytes = await toQrImageData(i.toString());
      var heading = pw.Padding(
          padding:
              const pw.EdgeInsets.only(bottom: 5, top: 0, left: 5, right: 5),
          child: pw.Text("Package ID: " + i.toString(),
              style: const pw.TextStyle(fontSize: 20)));
      var image =
          pw.Image(pw.MemoryImage(_qrImageBytes), height: 100, width: 100);
      var rowChildWidget = pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
          child: pw.Column(children: [heading, image]));

      _rowChildren.add(rowChildWidget);
      count += 1;
      if (count == 2) {
        _tableChildren.add(pw.TableRow(children: _rowChildren));
        count = 0;
        _rowChildren = [];
      }
    }
    if (count != 0) {
      _tableChildren.add(pw.TableRow(children: _rowChildren));
    }

    return pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(1),
        1: const pw.FlexColumnWidth(1),
      },
      border: const pw.TableBorder(
          horizontalInside:
              pw.BorderSide(width: 1, style: pw.BorderStyle.solid),
          verticalInside: pw.BorderSide(width: 1, style: pw.BorderStyle.solid)),
      children: _tableChildren,
    );
  }

  static Future<File> generateNew(int start, int end) async {
    final pdf = pw.Document();
    List<pw.Widget> tablesList = [];

    for (int i = start; i <= end; i = i + 10) {
      if (end <= i + 9) {
        var childTable = await createTable(i, end);
        tablesList.add(childTable);
        break;
      } else {
        var childTable = await createTable(i, i + 9);
        tablesList.add(childTable);
      }
    }

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (context) => tablesList));
    return saveDocument(name: 'qr_pdf.pdf', pdf: pdf);
  }

  static Future<Uint8List> toQrImageData(String text) async {
    try {
      final image = await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: true,
        emptyColor: Colors.white,
      ).toImage(400);
      // final img_resized =  Image(ResizeImage(image, width: 70, height: 80));
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw e;
    }
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
