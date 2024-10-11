import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openScanContent(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    final opened = await launchUrl(Uri.parse(scan.value));
    if (!opened) {
      throw 'No se pudo abrir ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
