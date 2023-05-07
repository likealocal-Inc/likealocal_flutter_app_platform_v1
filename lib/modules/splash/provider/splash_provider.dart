import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';
import 'package:likealocal_app_platform/modules/splash/provider/services/splash_service.dart';

final splashProvider =
    ChangeNotifierProvider<SplashProvider>((ref) => SplashProvider(ref));

class SplashProvider extends BaseProvider {
  final ChangeNotifierProviderRef _ref;

  late final SplashService _splashService;

  SplashProvider(this._ref) {
    _splashService = _ref.watch(spalshService);
  }

  @override
  init() async {}

  /// 스플레쉬 화면 체크
  check() async {
    // 로그인이 되어 있는 사용자 인지 확인
    await _splashService.check();
  }
}
