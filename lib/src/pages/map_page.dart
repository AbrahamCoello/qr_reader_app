import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();
  String typeMap = 'mapbox.mapbox-streets-v8';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordenadas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              mapController.move(scan.getLatLng() ?? const LatLng(0, 0), 15);
            },
          ),
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            typeMap = typeMap == 'mapbox.mapbox-streets-v8'
                ? 'mapbox.satellite'
                : 'mapbox.mapbox-streets-v8';
          });
        },
        child: const Icon(Icons.repeat),
      ),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      children: [
        _createMap(),
        _createMarkers(scan),
      ],
    );
  }

  _createMap() {
    return TileLayer(
        urlTemplate:
            'https://api.mapbox.com/v4/{tileset_id}/{z}/{x}/{y}.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiYWJyYWhhbWNvZWxsb3QiLCJhIjoiY2xrbGEwdHVhMTQyYTNscGljZ256c2c3ayJ9.LEgfP9qUX6VHd2NVcdDZnQ',
          'tileset_id': typeMap,
        });
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayer(markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng() ?? const LatLng(0, 0),
        builder: (context) => Icon(
          Icons.location_on,
          size: 45.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }
}
