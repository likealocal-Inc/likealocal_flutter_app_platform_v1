import 'package:flutter/material.dart';
import 'package:likealocal_app_platform/widgets/webviews/custom_webview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 홈페이지
class MapWebviewPage extends ConsumerStatefulWidget {
  const MapWebviewPage({super.key});

  @override
  ConsumerState<MapWebviewPage> createState() => _MapWebviewPageState();
}

class _MapWebviewPageState extends ConsumerState<MapWebviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomWebviewWidget();
  }
}
