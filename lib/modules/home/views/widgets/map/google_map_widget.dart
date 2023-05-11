// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:likealocal_app_platform/core/utils/geolocator_utils.dart';
import 'package:likealocal_app_platform/modules/home/models/google_find_path_markers.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';
import 'package:likealocal_app_platform/modules/home/provider/home_provider.dart';
import 'package:likealocal_app_platform/modules/home/types/google_map_path_type.dart';
import 'package:likealocal_app_platform/modules/home/utiles/google_map_utils.dart';

class GoogleMapWidget extends ConsumerStatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  ConsumerState<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends ConsumerState<GoogleMapWidget> {
  late GoogleMapController? _googleMapController = null;
  final GoogleMapUtils googleMapUtils = GoogleMapUtils();
  final GoogleFindPathMarkers _googleFindPathMarkers = GoogleFindPathMarkers();

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  late LatLng _initialPosition;

  /// 초기화
  init() async {
    Position myPosition = await GeolocatorUtils.getMyGeolocator();
    setState(() {});
    _initialPosition = LatLng(
      myPosition.latitude,
      myPosition.longitude,
    );
  }

  TextField googleMapPlaceInputWidget(
      BuildContext context,
      GoogleMapController? googleMapController,
      TextEditingController textEditingController,
      GoogleMapProvider googleMapProviderWatch,
      GoogleMapPathType googleMapPathType) {
    return TextField(
      controller: textEditingController,
      onTap: () async {
        MapPosition newPosition = await googleMapUtils.setMapMarkerAndMove(
          context,
          googleMapController,
          googleMapProviderWatch,
          textEditingController,
          googleMapPathType,
        );

        setState(() {});
        if (googleMapPathType == GoogleMapPathType.start) {
          _googleFindPathMarkers.start = newPosition;
        } else {
          _googleFindPathMarkers.goal = newPosition;
        }
      },
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final googleMapProviderWatch = ref.watch(googleMapProvider);
    final homeProviderWatch = ref.watch(homeProvider);
    return Column(
      children: [
        googleMapPlaceInputWidget(
          context,
          _googleMapController,
          _startController,
          googleMapProviderWatch,
          GoogleMapPathType.start,
        ),
        googleMapPlaceInputWidget(
          context,
          _googleMapController,
          _goalController,
          googleMapProviderWatch,
          GoogleMapPathType.goal,
        ),
        ElevatedButton(
          onPressed: () {
            googleMapProviderWatch.googleFindPathMarkers =
                _googleFindPathMarkers;
            googleMapProviderWatch.isDataSet = true;
            homeProviderWatch.pageMove(2);
          },
          child: const Text('길찾기'),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: GoogleMap(
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                setState(() {});
                _googleMapController = controller;
              },
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 5),
              markers: _googleFindPathMarkers.markers,
            ),
          ),
        ),
      ],
    );
  }
}
