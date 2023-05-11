import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:likealocal_app_platform/core/utils/geolocator_utils.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';
import 'package:likealocal_app_platform/modules/home/types/google_map_path_type.dart';
import 'package:likealocal_app_platform/modules/home/utiles/google_map_utils.dart';

class GoogleMapWidget extends ConsumerStatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  ConsumerState<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends ConsumerState<GoogleMapWidget> {
  late GoogleMapController? _googleMapController = null;
  final Set<Marker> markers = {};
  final GoogleMapUtils googleMapUtils = GoogleMapUtils();

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
        Marker marker = await googleMapUtils.setMapMarkerAndMove(
          context,
          googleMapController,
          googleMapProviderWatch,
          textEditingController,
          googleMapPathType,
        );

        setState(() {});
        markers.add(marker);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final googleMapProviderWatch = ref.watch(googleMapProvider);
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
          onPressed: () {},
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
              markers: markers,
            ),
          ),
        ),
      ],
    );
  }
}
