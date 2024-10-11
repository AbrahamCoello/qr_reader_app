import 'dart:async';

import 'package:qr_reader_app/src/models/scan_model.dart';

mixin Validators {
  final validateGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((scan) => scan.type == 'geo').toList();
      sink.add(geoScans);
    },
  );
  final validateHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final httpScans = scans.where((scan) => scan.type == 'http').toList();
      sink.add(httpScans);
    },
  );
}
