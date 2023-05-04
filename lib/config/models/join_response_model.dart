import 'package:likealocal_app_platform/core/call/call_models.dart';

/// 회원가입 반환 타입
class JoinResponseDataModel extends BaseResponseDataModel {
  late String userId;
  late String? error;
  JoinResponseDataModel({required this.userId, this.error});

  factory JoinResponseDataModel.initObj() => JoinResponseDataModel(userId: "");

  @override
  getFromMap(Map<String, dynamic> map) {
    userId = map['userId'] as String;
  }

  @override
  setError(String errorMessage) {
    userId = '';
    error = errorMessage;
  }

  @override
  String toString() => 'JoinResponseInfo(userId: $userId)';
}
