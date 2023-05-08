import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/home/views/pages/naver.map/base_map.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

/// 홈페이지
class MapNaverPage extends ConsumerStatefulWidget {
  const MapNaverPage({super.key});

  @override
  ConsumerState<MapNaverPage> createState() => _MapNaverPageState();
}

class _MapNaverPageState extends ConsumerState<MapNaverPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseMapPage();
  }
}
