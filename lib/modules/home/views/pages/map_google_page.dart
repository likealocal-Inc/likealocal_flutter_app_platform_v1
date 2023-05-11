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
