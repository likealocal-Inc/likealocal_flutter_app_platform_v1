import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:likealocal_app_platform/config/models/api_login_model.dart';
import 'package:likealocal_app_platform/config/types/login_type.dart';
import 'package:likealocal_app_platform/core/auth/services/auth_email_service.dart';
import 'package:likealocal_app_platform/core/call/call_models.dart';
import 'package:likealocal_app_platform/core/utils/enum_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier(ref));

class AuthNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef _ref;

  String message = '';

  late final AuthEmailService _authEmailService;

  AuthNotifier(this._ref) {
    _authEmailService = _ref.watch(authEmailProvider);
  }

  // 초기화 - main.ts에서 호출
  init() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var isLogin =
        sharedPreference.getBool(SharedPreferencesKeys.isLoginKey.name);

    // 캐쉬에 로그인정보가 없을경우 -> 처음접속 -> 초기화
    if (isLogin == null) {
    } else {}

    notifyListeners();
  }

  /// 로그인
  login(ApiLoginModel apiLoginModel) async {
    late ResponseModel res;

    message = '로그인요청옴';

    switch (apiLoginModel.loginType) {
      case LoginType.EMAIL:
        res = await _authEmailService.login(apiLoginModel);
        break;
      case LoginType.KAKAO:
        break;
      case LoginType.APPLE:
        break;
      case LoginType.GOOGLE:
        break;
      case LoginType.LINE:
        break;
      case LoginType.WECHAT:
        break;
    }

    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    /// 로그인 처리
    if (res.success) {
      // 로그인 성공
      sharedPreference.setBool(SharedPreferencesKeys.isLoginKey.name, true);
    } else {
      // 로그인 실패
      sharedPreference.setBool(SharedPreferencesKeys.isLoginKey.name, false);
    }

    notifyListeners();
  }

  getMessage() {
    return message;
  }
}
