import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/splash/provider/splash_provider.dart';

/// 홈페이지
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final slplashProvider = ref.watch(splashProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Splash")),
      body: Column(
        children: const [
          Text("Splash body"),
        ],
      ),
    );
  }
}
