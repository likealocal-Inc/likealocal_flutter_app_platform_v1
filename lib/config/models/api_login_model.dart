// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:likealocal_app_platform/config/types/login_type.dart';

/// 로그인 파라메터 root 클래스
abstract class ApiLoginParamBase {
  Map<String, dynamic> toMap();
}

/// 이메일 로그인 파라메터
class ApiEmailLoginParam extends ApiLoginParamBase {
  String email;
  String password;
  ApiEmailLoginParam({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory ApiEmailLoginParam.fromMap(Map<String, dynamic> map) {
    return ApiEmailLoginParam(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiEmailLoginParam.fromJson(String source) =>
      ApiEmailLoginParam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiEmailLoginParam(email: $email, password: $password)';
}

// 로그인 모델
class ApiLoginModel {
  LoginType loginType;
  ApiLoginParamBase params;
  ApiLoginModel({
    required this.loginType,
    required this.params,
  });

  @override
  String toString() => 'ApiLoginModel(loginType: $loginType, params: $params)';
}
