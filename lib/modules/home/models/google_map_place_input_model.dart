import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:likealocal_app_platform/modules/home/provider/google_map_provider.dart';
import 'package:likealocal_app_platform/modules/home/types/google_map_path_type.dart';

class GoogleMapPlaceInputModel {
  BuildContext context;
  GoogleMapController? googleMapController;
  TextEditingController textEditingController;
  GoogleMapProvider googleMapProviderWatch;
  GoogleMapPathType googleMapPathType;
  GoogleMapPlaceInputModel({
    required this.context,
    this.googleMapController,
    required this.textEditingController,
    required this.googleMapProviderWatch,
    required this.googleMapPathType,
  });
}
