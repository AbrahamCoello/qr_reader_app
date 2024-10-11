import 'package:latlong2/latlong.dart';

class ScanModel {
  int? id;
  String? type;
  String value;

  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    if (value.contains('http')) {
      type = 'http';
    } else {
      type = 'geo';
    }
  }

  ScanModel copyWith({
    int? id,
    String? type,
    String? value,
  }) =>
      ScanModel(
        id: id ?? this.id,
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng? getLatLng() {
    // value: 'geo:11.4110512,-69.6712339'
    final latLng = value.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return latLng.isNotEmpty ? LatLng(lat, lng) : null;
  }
}
