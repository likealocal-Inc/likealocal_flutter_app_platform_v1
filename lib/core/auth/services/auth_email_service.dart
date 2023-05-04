import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:likealocal_app_platform/config/models/api_login_model.dart';
import 'package:likealocal_app_platform/config/urls.dart';
import 'package:likealocal_app_platform/core/auth/models/api_info.dart';
import 'package:likealocal_app_platform/core/auth/utils/auth_utils.dart';
import 'package:likealocal_app_platform/core/call/call_models.dart';

final authEmailProvider = Provider((ref) => AuthEmailService());

class AuthEmailService {
  Future<ResponseModel> login(ApiLoginModel apiInfo) async {
    return await AuthUtil()
        .login(ApiInfo(urlInfo: urlEmailLogin, params: apiInfo.params.toMap()));
  }
}
