// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationResult {
  bool success;
  LocationData? location;
  LocationResult({
    required this.success,
    this.location,
  });

  static LocationResult getError() {
    return LocationResult(success: false);
  }
}

class GeolocatorUtils {
  static Future<LocationResult> getCurrentLocation() async {
    final location = Location();

    // Check if location service is enabled
    bool _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return LocationResult.getError();
      }
    }

    // Check for permissions
    PermissionStatus _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LocationResult.getError();
      }
    }

    print("-----");
    // Get location
    final _locationData = await location.getLocation();
    print(_locationData);
    print('Location: ${_locationData.latitude}, ${_locationData.longitude}');

    return LocationResult(success: true, location: _locationData);
  }

  /// 내 위치 가져오기
  static Future<Position> getMyGeolocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again (this is also where Android's shouldShowRequestPermissionRationale comes in).
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
