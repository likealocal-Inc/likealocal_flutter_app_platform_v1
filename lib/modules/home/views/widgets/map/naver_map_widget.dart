import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  /// 경로 그리기
  drawPathOnMap() async {
    const start = "127.059151,37.5116828";
    const goal = "128.1297905,35.205153";

    NaverMapUtils.drawPathOnMap(_naverMapController, start, goal);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              drawPathOnMap();
            },
            child: const Text("button")),
        TextField(
          enabled: false,
          controller: _startController,
        ),
        TextField(
          enabled: false,
          controller: _startController,
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
