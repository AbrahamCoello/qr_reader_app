import 'dart:async';

import 'package:qr_reader_app/src/bloc/validators.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    getAll();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validateHttp);
  Stream<List<ScanModel>> get scansStreamGeo =>
      _scansController.stream.transform(validateGeo);

  dispose() {
    _scansController.close();
  }

  create(ScanModel scan) async {
    await DBProvider.db.createScan(scan);
    getAll();
  }

  getAll() async {
    final List<ScanModel> list = await DBProvider.db.getAllScans();
    _scansController.sink.add(list);
  }

  delete(int id) async {
    await DBProvider.db.deleteScan(id);
    getAll();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    getAll();
  }
}
