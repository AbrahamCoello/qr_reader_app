import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

class AddressPage extends StatelessWidget {
  final ScansBloc scansBloc = ScansBloc();
  AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    scansBloc.getAll();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data!;
        if (scans.isEmpty) {
          return const Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, index) {
            final scan = scans[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) => scansBloc.delete(scan.id!),
              child: ListTile(
                leading: Icon(
                  Icons.link,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scan.value),
                subtitle: Text('ID: ${scan.id}'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  utils.openScanContent(context, scan);
                },
              ),
            );
          },
        );
      },
    );
  }
}
