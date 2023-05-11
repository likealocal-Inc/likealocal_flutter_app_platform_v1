import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:likealocal_app_platform/modules/home/models/naver_map_new_position.dart';

class NaverMapUtils {
  /// 네이버 지도에 경로 그리기
  static Future<void> drawPathOnMap(
      NaverMapController naverMapController, String start, String goal) async {
    List pathData = await NaverMapUtils._getPath(start, goal);
    await NaverMapUtils._updateMapOverlay(naverMapController, pathData);
  }

  /// 네이버 지도 경로 업데이트
  static _updateMapOverlay(
      NaverMapController naverMapController, List pathData) async {
    List<NLatLng> paths = [];
    for (var element in pathData) {
      paths.add(NLatLng(element[1], element[0]));
    }

    final overlay = NPathOverlay(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      coords: paths,
      color: Colors.red,
    );
    naverMapController.addOverlay(overlay);

    NaverMapNewPositioin newPosition = NaverMapUtils._findPosition(paths);

    final up = NCameraUpdate.withParams(
        zoom: newPosition.newZoom,
        target: NLatLng(newPosition.newLat, newPosition.newLng));
    naverMapController.updateCamera(up);
  }

  /// 경로 가져오기
  static Future<List> _getPath(String start, String goal) async {
    final Response res = await Dio().get(
      "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=$start&goal=$goal",
      options: Options(
        headers: {
          "X-NCP-APIGW-API-KEY-ID": dotenv.env["NAVER.MAP.CLIENT.ID"]!,
          "X-NCP-APIGW-API-KEY": dotenv.env["NAVER.MAP.CLIENT.SECRET"]!,
        },
      ),
    );

    List pathData = res.data["route"]["traoptimal"][0]["path"];

    return pathData;
  }

  /// 경로에 따른 새 위치 찾기
  static NaverMapNewPositioin _findPosition(List<NLatLng> paths) {
    double north = paths[0].latitude;
    double south = paths[0].latitude;
    double west = paths[0].longitude;
    double east = paths[0].longitude;

    for (NLatLng el in paths) {
      if (el.latitude > north) {
        north = el.latitude;
      }
      if (el.latitude < south) {
        south = el.latitude;
      }
      if (el.longitude > east) {
        east = el.longitude;
      }
      if (el.longitude < west) {
        west = el.longitude;
      }
    }

    var lat = (north - south).abs();
    var lng = (east - west).abs();
    const extra = 1.6;
    double latZoom = lat * extra;
    double lngZoom = lng * extra;

    var newLng = west + lng / 2;
    var nwqLat = south + lat / 2;

    return NaverMapNewPositioin(
        newLat: nwqLat,
        newLng: newLng,
        newZoom: (latZoom * lngZoom).round() * 0.98);
  }
}
