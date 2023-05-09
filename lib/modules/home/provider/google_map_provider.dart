import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';
import 'package:likealocal_app_platform/core/utils/geolocator_utils.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';

final googleMapProvider = ChangeNotifierProvider((ref) => GoogleMapProvider());

class GoogleMapProvider extends BaseProvider {
  final MapPosition startPosition = MapPosition();
  final MapPosition goalPosition = MapPosition();

  @override
  init() {}

  Future<MapPosition> getStartPosition() async {
    if (startPosition.lat == 0) {
      Position position = await GeolocatorUtils.getMyGeolocator();
      startPosition.fromPosition(position);
    }
    return startPosition;
  }

  getGoalPosition() {
    return goalPosition;
  }

  setStartPosition(MapPosition position) {
    startPosition.lat = position.lat;
    startPosition.lng = position.lng;
    startPosition.desc = position.desc;
    notifyListeners();
  }

  setGoalPosition(MapPosition position) {
    goalPosition.lat = position.lat;
    goalPosition.lng = position.lng;
    goalPosition.desc = position.desc;
    notifyListeners();
  }
}
