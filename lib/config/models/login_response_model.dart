import 'package:likealocal_app_platform/core/call/call_models.dart';

/// 로그인 반환 타입
class LoginResponseDataModel extends BaseResponseDataModel {
  late String email;
  late String userId;
  late String sessionKey;
  late String? error;

  LoginResponseDataModel(
      {required this.email,
      required this.userId,
      required this.sessionKey,
      this.error});

  factory LoginResponseDataModel.initObj() =>
      LoginResponseDataModel(email: "", userId: "", sessionKey: "");

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
