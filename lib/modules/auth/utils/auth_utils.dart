import 'package:likealocal_app_platform/core/utils/enum_shared_preferences.dart';
import 'package:likealocal_app_platform/modules/auth/models/login/login_api_response_model.dart';
import 'package:likealocal_app_platform/core/call/models/api_info.dart';
import 'package:likealocal_app_platform/core/call/call.dart';
import 'package:likealocal_app_platform/core/call/models/call_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 인증관련 유틸
class AuthUtil {
  // 로그인처리
  static Future<ResponseModel> login(ApiInfo apiInfo) async {
    LoginApiResponseModel loginResModel = LoginApiResponseModel.initObj();
    return await callAPI<LoginApiResponseModel>(
      apiInfo.urlInfo.url,
      apiInfo.urlInfo.method,
      loginResModel,
      params: apiInfo.params,
    );
  }

  // 로그인 이후 처리
  static setInfoAfterLogin(Map<String, dynamic> data) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    sharedPreference.setString(
        SharedPreferencesKeys.tokenKey.name, data['sessionKey'].toString());
    sharedPreference.setString(
        SharedPreferencesKeys.userIdKey.name, data['userId'].toString());
    sharedPreference.setString(
        SharedPreferencesKeys.userEmailKey.name, data['email'].toString());

    sharedPreference.setBool(SharedPreferencesKeys.isLoginKey.name, true);
  }

  // 로그아웃 이후 처리
  static setInfoAfterLogout() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString(SharedPreferencesKeys.tokenKey.name, '');
    sharedPreference.setString(SharedPreferencesKeys.userIdKey.name, '');
    sharedPreference.setString(SharedPreferencesKeys.userEmailKey.name, '');

    sharedPreference.setBool(SharedPreferencesKeys.isLoginKey.name, false);
  }

  // /// 로그아웃
  // Future<ResponseModel> join(String url, Map<String, dynamic> params) async {
  //   JoinResponseDataModel logoutResModel = JoinResponseDataModel.initObj();
  //   return callAPI<JoinResponseDataModel>(
  //     url,
  //     ApiMethod.POST,
  //     logoutResModel,
  //     params: params,
  //   );
  // }
}
