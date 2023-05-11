import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:likealocal_app_platform/modules/home/models/map_position.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';
import 'package:likealocal_app_platform/modules/home/types/google_map_path_type.dart';

class GoogleMapUtils {
  // static void onError(PlacesAutocompleteResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(response.errorMessage!)),
  //   );
  // }

  Future<MapPosition?> placeAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: dotenv.env["GOOGLE.MAP.KEY.IOS"]!,
        // onError: onError,
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

  Future<MapPosition?> displayPrediction(Prediction? p) async {
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

  Future<Marker> setMapMarkerAndMove(
      BuildContext context,
      GoogleMapController? googleMapController,
      GoogleMapProvider googleMapProviderWatch,
      TextEditingController controller,
      GoogleMapPathType type) async {
    MapPosition? position = await placeAutoComplete(context);
    var address = position!.desc!;
    controller.text = address;
    position.desc = address;
    switch (type) {
      case GoogleMapPathType.start:
        googleMapProviderWatch.setStartPosition(position);
        break;
      case GoogleMapPathType.goal:
        googleMapProviderWatch.setGoalPosition(position);
        break;
    }

    MarkerId markerId = MarkerId(type.name);
    final marker = Marker(
      markerId: markerId,
      position: LatLng(position.lat!, position.lng!),
      infoWindow: InfoWindow(title: type.name, snippet: 'address'),
    );

    googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.lat!, position.lng!), zoom: 10),
      ),
    );

    MapPosition startP = await googleMapProviderWatch.getStartPosition();
    MapPosition goalP = await googleMapProviderWatch.getGoalPosition();

    if (startP.lat == null || goalP.lat == null) {
      return marker;
    } else {
      await updateCameraLocation(
          startP.getLatLng(), goalP.getLatLng(), googleMapController);

      return marker;
    }
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController? mapController,
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

    return checkCameraLocation(cameraUpdate, mapController!);
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
}
