// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPosition {
  double? lng;
  double? lat;
  String? desc;
  Marker? marker;

  MapPosition({
    this.lat,
    this.lng,
    this.desc,
  });

  fromPosition(Position position) {
    lat = position.latitude;
    lng = position.longitude;
    return this;
  }

  getLatLng() {
    return LatLng(lat!, lng!);
  }

  @override
  String toString() {
    return 'MapPosition(lng: $lng, lat: $lat, desc: $desc, marker: $marker)';
  }
}
