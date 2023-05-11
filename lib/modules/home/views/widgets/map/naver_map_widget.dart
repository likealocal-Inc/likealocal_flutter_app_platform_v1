import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/home/models/google_find_path_markers.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';
import 'package:likealocal_app_platform/modules/home/utiles/naver_map_utils.dart';

class NaverMapWidget extends ConsumerStatefulWidget {
  const NaverMapWidget({super.key});

  @override
  ConsumerState<NaverMapWidget> createState() => _NaverMapWidgetState();
}

class _NaverMapWidgetState extends ConsumerState<NaverMapWidget> {
  late NaverMapController _naverMapController;
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  late GoogleMapProvider googleMapProviderWatch;
  bool isLoadedNaverMap = false;
  // /// 경로 그리기
  drawPathOnMap() async {
    GoogleFindPathMarkers pathMarkers =
        googleMapProviderWatch.googleFindPathMarkers;

    _startController.text = pathMarkers.start.desc;
    _goalController.text = pathMarkers.goal.desc;

    NaverMapUtils.drawPathOnMap(
        _naverMapController, pathMarkers.startStr, pathMarkers.goalStr);
  }

  @override
  Widget build(BuildContext context) {
    googleMapProviderWatch = ref.watch(googleMapProvider);
    if (googleMapProviderWatch.isDataSet == true) {
      drawPathOnMap();
    }
    return Column(
      children: [
        TextField(
          enabled: false,
          controller: _startController,
        ),
        TextField(
          enabled: false,
          controller: _goalController,
        ),
        Expanded(
          child: NaverMap(
            forceGesture: true,
            options: const NaverMapViewOptions(
                locale: Locale('en'),
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(37.5089, 127.0631),
                  zoom: 7,
                ),
                zoomGesturesEnable: true),
            onMapReady: (controller) {
              _naverMapController = controller;
              isLoadedNaverMap = true;
            },
            onMapTapped: (point, latLng) {},
            onSymbolTapped: (symbol) {},
            onCameraChange: (position, reason) {},
            onCameraIdle: () {},
            onSelectedIndoorChanged: (indoor) {},
          ),
        )
      ],
    );
  }
}
