import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/core/call/constants/urls_constant.dart';
import 'package:likealocal_app_platform/core/call/models/api_info.dart';
import 'package:likealocal_app_platform/core/call/models/call_models.dart';
import 'package:likealocal_app_platform/modules/auth/models/login/login_api_request_model.dart';
import 'package:likealocal_app_platform/modules/auth/utils/auth_utils.dart';

final authEmailService = Provider((ref) => AuthEmailService());

class AuthEmailService {
  Future<ResponseModel> login(LoginApiRequestModel apiInfo) async {
    return await AuthUtil.login(
        ApiInfo(urlInfo: urlEmailLogin, params: apiInfo.params.toMap()));
  }
}
