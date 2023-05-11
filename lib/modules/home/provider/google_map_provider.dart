import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';
import 'package:likealocal_app_platform/core/utils/geolocator_utils.dart';
import 'package:likealocal_app_platform/modules/home/models/google_find_path_markers.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';

final googleMapProvider = ChangeNotifierProvider((ref) => GoogleMapProvider());

class GoogleMapProvider extends BaseProvider {
  bool _isDataSet = false;
  final MapPosition _startPosition = MapPosition();
  final MapPosition _goalPosition = MapPosition();
  late GoogleFindPathMarkers _googleFindPathMarkers = GoogleFindPathMarkers();
  @override
  init() {}

  Future<MapPosition> getStartPosition() async {
    if (_startPosition.lat == 0) {
      Position position = await GeolocatorUtils.getMyGeolocator();
      _startPosition.fromPosition(position);
    }
    return _startPosition;
  }

  getGoalPosition() {
    return _goalPosition;
  }

  setStartPosition(MapPosition position) {
    _startPosition.lat = position.lat;
    _startPosition.lng = position.lng;
    _startPosition.desc = position.desc;
    notifyListeners();
  }

  setGoalPosition(MapPosition position) {
    _goalPosition.lat = position.lat;
    _goalPosition.lng = position.lng;
    _goalPosition.desc = position.desc;
    notifyListeners();
  }

  GoogleFindPathMarkers get googleFindPathMarkers => _googleFindPathMarkers;

  set googleFindPathMarkers(GoogleFindPathMarkers googleFindPathMarkers) {
    _googleFindPathMarkers = googleFindPathMarkers;
    notifyListeners();
  }

  set isDataSet(bool isDataSet) {
    _isDataSet = isDataSet;
    notifyListeners();
  }

  bool get isDataSet => _isDataSet;
}
