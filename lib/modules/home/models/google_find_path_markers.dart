// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';

/// 구글맵 경로찾기를 위한 시작, 목적지를 가지는 클래스
class GoogleFindPathMarkers {
  late MapPosition _start;
  late MapPosition _goal;
  GoogleFindPathMarkers();

  final Set<Marker> _markers = {};

  get start => _start;
  get goal => _goal;

  set start(start) {
    _start = start;
    _markers.add(_start.marker!);
  }

  set goal(goal) {
    _goal = goal;
    _markers.add(_goal.marker!);
  }

  get startStr => "${_start.lng},${_start.lat}";

  get goalStr => "${_goal.lng},${_goal.lat}";

  Set<Marker> get markers => _markers;

  @override
  String toString() => 'GoogleFindPathMarkers(_start: $_start, _goal: $_goal)';
}
