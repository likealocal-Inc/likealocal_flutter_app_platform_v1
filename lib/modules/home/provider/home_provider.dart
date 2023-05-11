import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends BaseProvider {
  int _pageIndex = 0;

  HomeProvider();

  @override
  init() async {}

  /// 홈화면에서 페이지 이동
  void pageMove(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  /// 페이지번호
  get pageIndex => _pageIndex;
}
