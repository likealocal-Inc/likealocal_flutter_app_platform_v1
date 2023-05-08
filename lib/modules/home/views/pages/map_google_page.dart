import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 홈페이지
class MapGooglePage extends ConsumerStatefulWidget {
  const MapGooglePage({super.key});

  @override
  ConsumerState<MapGooglePage> createState() => _MapGooglePageState();
}

class _MapGooglePageState extends ConsumerState<MapGooglePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMapRouteExample(),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
    // body: GoogleMap(
    //   mapType: MapType.hybrid,
    //   initialCameraPosition: _kGooglePlex,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //   },
    // ),
    // floatingActionButton: FloatingActionButton.extended(
    //   onPressed: _goToTheLake,
    //   label: const Text('To the lake!'),
    //   icon: const Icon(Icons.directions_boat),
    // ),
    // );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class GoogleMapRouteExample extends StatefulWidget {
  const GoogleMapRouteExample({super.key});

  @override
  _GoogleMapRouteExampleState createState() => _GoogleMapRouteExampleState();
}

class _GoogleMapRouteExampleState extends State<GoogleMapRouteExample> {
  late GoogleMapController _controller;
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final Set<Polyline> _polylines = {};
  final LatLng _initialPosition =
      const LatLng(37.42796133580664, -122.085749655962);

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _departureController,
            decoration: const InputDecoration(
              labelText: 'Departure',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {},
          child: const Text('Get Route'),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: GoogleMap(
              mapType: MapType.hybrid,
              // initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                // _controller.complete(controller);
                _controller = controller;
              },

              // onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 11),
              polylines: _polylines,
            ),
          ),
        ),
      ],
    );
    //     floatingActionButton: FloatingActionButton.extended(
    //   onPressed: _goToTheLake,
    //   label: const Text('To the lake!'),
    //   icon: const Icon(Icons.directions_boat),
    // )
  }

  // void _fetchRoute() async {
  //   LatLng? start = await _getLatLngFromAddress(_departureController.text);
  //   LatLng? goal = await _getLatLngFromAddress(_destinationController.text);

  //   if (start != null && goal != null) {
  //     final path = await getDirections(start, goal);
  //     setState(() {
  //       _polylines.add(Polyline(
  //         polylineId: PolylineId('route'),
  //         points: path,
  //         color: Colors.blue,
  //         width: 5,
  //       ));
  //       _controller.animateCamera(
  //         CameraUpdate.newLatLngBounds(_boundsFromLatLngList(path), 50),
  //       );
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Unable to find route'),
  //     ));
  //   }
  // }

  // Future<LatLng?> _getLatLngFromAddress(String address) async {
  //   final response = await http.get(Uri.parse(
  //       'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeQueryComponent(address)}&key=AIzaSyDlqOtOYYlsDxiuRPacA2Q1DVb_q9nA29w'));

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     if (jsonResponse['status'] == 'OK') {
  //       final location = jsonResponse['results'][0]['geometry']['location'];
  //       return LatLng(location['lat'], location['lng']);
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     throw Exception('Failed to fetch geocoding data');
  //   }
  // }

  // Future<List<LatLng>> getDirections(LatLng start, LatLng goal) async {
  //   final response = await http.get(Uri.parse(
  //       'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${goal.latitude},${goal.longitude}&key=AIzaSyDlqOtOYYlsDxiuRPacA2Q1DVb_q9nA29w'));

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     if (jsonResponse['status'] == 'OK') {
  //       final points = jsonResponse['routes'][0]['overview_polyline']['points'];
  //       return decodePolyline(points);
  //     } else {
  //       throw Exception('Failed to fetch directions');
  //     }
  //   } else {
  //     throw Exception('Failed to fetch directions data');
  //   }
  // }

  // List<LatLng> decodePolyline(String encoded) {
  //   List<LatLng> points = [];
  //   int index = 0, len = encoded.length;
  //   int lat = 0, lng = 0;

  //   while (index < len) {
  //     int shift = 0, result = 0;
  //     int c;
  //     do {
  //       c = encoded.codeUnitAt(index++) - 63;
  //       result |= (c & 0x1F) << shift;
  //       shift += 5;
  //     } while (c >= 0x20);
  //     int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
  //     lat += dlat;

  //     shift = 0;
  //     result = 0;
  //     do {
  //       c = encoded.codeUnitAt(index++) - 63;
  //       result |= (c & 0x1F) << shift;
  //       shift += 5;
  //     } while (c >= 0x20);
  //     int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
  //     lng += dlng;

  //     LatLng p = LatLng(lat / 1E5, lng / 1E5);
  //     points.add(p);
  //   }

  //   return points;
  // }

  // LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
  //   late double x0, x1, y0, y1;
  //   for (LatLng latLng in list) {
  //     if (x0 == null) {
  //       x0 = x1 = latLng.latitude;
  //       y0 = y1 = latLng.longitude;
  //     } else {
  //       if (latLng.latitude > x1) x1 = latLng.latitude;
  //       if (latLng.latitude < x0) x0 = latLng.latitude;
  //       if (latLng.longitude > y1) y1 = latLng.longitude;
  //       if (latLng.longitude < y0) y0 = latLng.longitude;
  //     }
  //   }
  //   return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  // }
}
