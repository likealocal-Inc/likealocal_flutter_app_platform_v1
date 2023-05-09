import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPosition {
  double? lng;
  double? lat;
  String? desc;

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
  String toString() => 'MapPosition(lng: $lng, lat: $lat, desc: $desc)';
}
