import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:likealocal_app_platform/modules/home/views/widgets/map/google_map_widget.dart';

class MapGooglePage extends ConsumerStatefulWidget {
  const MapGooglePage({super.key});

  @override
  ConsumerState<MapGooglePage> createState() => _GoogleMapState();
}

class _GoogleMapState extends ConsumerState<MapGooglePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GoogleMapWidget();
  }
}

  // // ignore: avoid_init_to_null
  // late GoogleMapController? _googleMapController = null;
  // final Set<Marker> markers = {};
  // final GoogleMapUtils googleMapUtils = GoogleMapUtils();

  // final TextEditingController _startController = TextEditingController();
  // final TextEditingController _goalController = TextEditingController();

  // late LatLng _initialPosition;

  // /// 초기화
  // init() async {
  //   Position myPosition = await GeolocatorUtils.getMyGeolocator();
  //   setState(() {});
  //   _initialPosition = LatLng(
  //     myPosition.latitude,
  //     myPosition.longitude,
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   init();
  // }

  // TextField googleMapPlaceInputWidget(
  //     BuildContext context,
  //     GoogleMapController? googleMapController,
  //     TextEditingController textEditingController,
  //     GoogleMapProvider googleMapProviderWatch,
  //     GoogleMapPathType googleMapPathType) {
  //   return TextField(
  //     controller: textEditingController,
  //     onTap: () async {
  //       Marker marker = await googleMapUtils.setMapMarkerAndMove(
  //         context,
  //         googleMapController,
  //         googleMapProviderWatch,
  //         textEditingController,
  //         googleMapPathType,
  //       );

  //       setState(() {});
  //       markers.add(marker);
  //     },
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final googleMapProviderWatch = ref.watch(googleMapProvider);
  //   return Column(
  //     children: [
  //       googleMapPlaceInputWidget(
  //         context,
  //         _googleMapController,
  //         _startController,
  //         googleMapProviderWatch,
  //         GoogleMapPathType.start,
  //       ),
  //       googleMapPlaceInputWidget(
  //         context,
  //         _googleMapController,
  //         _goalController,
  //         googleMapProviderWatch,
  //         GoogleMapPathType.goal,
  //       ),
  //       ElevatedButton(
  //         onPressed: () {},
  //         child: const Text('길찾기'),
  //       ),
  //       Expanded(
  //         child: Container(
  //           padding: const EdgeInsets.all(10),
  //           child: GoogleMap(
  //             zoomGesturesEnabled: true,
  //             mapType: MapType.normal,
  //             onMapCreated: (GoogleMapController controller) {
  //               setState(() {});
  //               _googleMapController = controller;
  //             },
  //             initialCameraPosition:
  //                 CameraPosition(target: _initialPosition, zoom: 5),
  //             markers: markers,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
