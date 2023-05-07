import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/modules/auth/models/login/login_api_request_model.dart';
import 'package:likealocal_app_platform/modules/auth/types/login_type.dart';
import 'package:likealocal_app_platform/core/providers/base_provider.dart';
import 'package:likealocal_app_platform/core/call/models/call_models.dart';
import 'package:likealocal_app_platform/core/utils/enum_shared_preferences.dart';
import 'package:likealocal_app_platform/modules/auth/providers/services/auth_email_service.dart';
import 'package:likealocal_app_platform/modules/auth/utils/auth_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref));

class AuthProvider extends BaseProvider {
  final ChangeNotifierProviderRef _ref;

  String message = '';

  late final AuthEmailService _authEmailService;

  AuthProvider(this._ref) {
    _authEmailService = _ref.watch(authEmailService);
  }

  // 초기화 - main.ts에서 호출
  @override
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
  login(LoginApiRequestModel apiLoginModel) async {
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

    /// 로그인 처리 결과 프로세스

    /// 로그인 처리
    if (res.ok) {
      // 로그인 성공

      /// 로그인 정보 세션에 저장
      var data = res.data;
      await AuthUtil.setInfoAfterLogin(data);
    } else {
      // 로그인 실패
      AuthUtil.setInfoAfterLogout();
    }
    notifyListeners();
  }

  getMessage() {
    return message;
  }

  /// 로그아웃
  logout() async {
    await AuthUtil.setInfoAfterLogout();
    notifyListeners();
  }

  /// 회원가입
  join() async {}
}
