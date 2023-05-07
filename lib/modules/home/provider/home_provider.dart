import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';
import 'package:likealocal_app_platform/modules/home/provider/services/home_service.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider(ref));

class HomeProvider extends BaseProvider {
  late ChangeNotifierProviderRef _ref;

  late final HomeService _homeService;

  HomeProvider(this._ref) {
    _homeService = _ref.watch(homeService);
  }

  @override
  init() async {}
}
