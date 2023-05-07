import 'package:likealocal_app_platform/core/call/models/call_models.dart';

/// 회원가입 반환 타입
class JoinApiResponseModel extends BaseResponseDataModel {
  late String userId;
  late String? error;
  JoinApiResponseModel({required this.userId, this.error});

  factory JoinApiResponseModel.initObj() => JoinApiResponseModel(userId: "");

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
