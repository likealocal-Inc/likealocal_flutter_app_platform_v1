// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:likealocal_app_platform/core/utils/geolocator_utils.dart';
import 'package:likealocal_app_platform/core/utils/uuid.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';

enum PathType { start, goal }

class MapGooglePage extends ConsumerStatefulWidget {
  const MapGooglePage({super.key});

  @override
  ConsumerState<MapGooglePage> createState() => _GoogleMapState();
}

class _GoogleMapState extends ConsumerState<MapGooglePage> {
  late GoogleMapController _controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final TextEditingController _startController = new TextEditingController();
  final TextEditingController _goalController = new TextEditingController();

  late LatLng _initialPosition;

  setLocation() async {
    Position myPosition = await GeolocatorUtils.getMyGeolocator();
    setState(() {});
    _initialPosition = LatLng(myPosition.latitude, myPosition.longitude);
  }

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  Future<MapPosition?> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: dotenv.env["GOOGLE.MAP.KEY.IOS"]!,
        onError: onError,
        mode: Mode.overlay,
        language: "en",
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        components: [Component(Component.country, "kr")],
        logo: const Text(''));

    MapPosition? position = await displayPrediction(p);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final googleMapProviderWatch = ref.watch(googleMapProvider);
    return Column(
      children: [
        TextField(
          controller: _startController,
          onTap: () async {
            await setMapMarkerAndMove(
                googleMapProviderWatch, _startController, PathType.start);
          },
        ),
        TextField(
          controller: _goalController,
          onTap: () async {
            await setMapMarkerAndMove(
                googleMapProviderWatch, _goalController, PathType.goal);
          },
        ),
        // Expanded(
        //   child: CustomSearchScaffold(
        //     callback: (MapPosition position) {
        //       googleMapProviderWatch.setStartPosition(position);
        //     },
        //   ),
        // ),
        // Expanded(
        //     child: Text(googleMapProviderWatch.startPosition.lat.toString())),
        // Expanded(
        //   child: CustomSearchScaffold(
        //     callback: (MapPosition position) {
        //       googleMapProviderWatch.setGoalPosition(position);
        //     },
        //   ),
        // ),
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
                setState(() {
                  _controller = controller;
                });
              },
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 5),
              markers: markers.values.toSet(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  Future<void> setMapMarkerAndMove(GoogleMapProvider googleMapProviderWatch,
      TextEditingController controller, PathType type) async {
    MapPosition? position = await _handlePressButton();
    var address = position!.desc!;
    controller.text = address;
    position.desc = address;
    switch (type) {
      case PathType.start:
        googleMapProviderWatch.setStartPosition(position);
        break;
      case PathType.goal:
        googleMapProviderWatch.setGoalPosition(position);
        break;
    }

    MarkerId markerId = MarkerId(type.name);
    final marker = Marker(
      markerId: markerId,
      position: LatLng(position.lat!, position.lng!),
      infoWindow: InfoWindow(title: type.name, snippet: 'address'),
    );

    markers[markerId] = marker;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.lat!, position.lng!), zoom: 10),
      ),
    );

    MapPosition startP = await googleMapProviderWatch.getStartPosition();
    MapPosition goalP = await googleMapProviderWatch.getGoalPosition();
    await updateCameraLocation(
        startP.getLatLng(), goalP.getLatLng(), _controller);
  }

  Future<void> mapMarkAndMove(GoogleMapProvider googleMapProviderWatch) async {
    {
      MapPosition? position = await _handlePressButton();
      _startController.text = position!.desc!;
      googleMapProviderWatch.setStartPosition(position);
      const MarkerId markerId = MarkerId("start");
      final marker = Marker(
        markerId: markerId,
        position: LatLng(position.lat!, position.lng!),
        infoWindow: const InfoWindow(title: 'start', snippet: 'address'),
      );

      setState(() {});
      markers[markerId] = marker;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.lat!, position.lng!), zoom: 10),
        ),
      );
    }
  }
}

// ignore: must_be_immutable
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  Function callback;
  CustomSearchScaffold({Key? key, required this.callback})
      : super(
          key: key,
          apiKey: dotenv.env["GOOGLE.MAP.KEY.IOS"]!,
          sessionToken: Uuid().generateV4(delim: "-"),
          language: "en",
          components: [Component(Component.country, "kr")],
        );

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchScaffoldState createState() =>
      // ignore: no_logic_in_create_state
      _CustomSearchScaffoldState(callback: callback);
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  Function callback;
  _CustomSearchScaffoldState({
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    const search = AppBarPlacesAutoCompleteTextField();
    final result = PlacesAutocompleteResult(
      onTap: (p) async {
        MapPosition? position = await displayPrediction(p, context);
        callback(position);
      },
      logo: const Text(''),
    );
    return Column(
      children: [
        search,
        Expanded(child: result),
      ],
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Got answer")),
      );
    }
  }

  Future<MapPosition?> displayPrediction(
      Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: dotenv.env["GOOGLE.MAP.KEY.IOS"]!,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("${p.description} - $lat/$lng")),
      // );

      MapPosition position =
          MapPosition(lat: lat, lng: lng, desc: p.description);
      return position;
    }
    return null;
  }
}

Future<MapPosition?> displayPrediction(Prediction? p) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: dotenv.env["GOOGLE.MAP.KEY.IOS"]!,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("${p.description} - $lat/$lng")),
    // );

    MapPosition position = MapPosition(lat: lat, lng: lng, desc: p.description);
    return position;
  }
  return null;
}
