import 'package:likealocal_app_platform/core/call/models/call_models.dart';

/// 로그인 반환 타입
class LoginApiResponseModel extends BaseResponseDataModel {
  late String email;
  late String userId;
  late String sessionKey;
  late String? error;

  LoginApiResponseModel(
      {required this.email,
      required this.userId,
      required this.sessionKey,
      this.error});

  factory LoginApiResponseModel.initObj() =>
      LoginApiResponseModel(email: "", userId: "", sessionKey: "");

  @override
  getFromMap(Map<String, dynamic> map) {
    email = map['email'] as String;
    userId = map['userId'].toString();
    sessionKey = map['sessionKey'] as String;
  }

  @override
  setError(String errorMessage) {
    email = '';
    userId = '';
    sessionKey = '';
    error = errorMessage;
  }

  @override
  String toString() {
    return 'LoginResponseInfo(email: $email, userId: $userId, sessionKey: $sessionKey, error: $error)';
  }
}
