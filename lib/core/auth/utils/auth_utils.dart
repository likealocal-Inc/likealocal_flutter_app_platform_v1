import 'package:likealocal_app_platform/config/models/login_response_model.dart';
import 'package:likealocal_app_platform/core/auth/models/api_info.dart';
import 'package:likealocal_app_platform/core/call/call_utils.dart';
import 'package:likealocal_app_platform/core/call/call_models.dart';

/// 인증관련 유틸
class AuthUtil {
  // 로그인처리
  Future<ResponseModel> login(ApiInfo apiInfo) async {
    LoginResponseDataModel loginResModel = LoginResponseDataModel.initObj();
    return await callAPI<LoginResponseDataModel>(
      apiInfo.urlInfo.url,
      apiInfo.urlInfo.method,
      loginResModel,
      params: apiInfo.params,
    );
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
