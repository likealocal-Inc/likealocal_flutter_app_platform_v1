import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BaseResponseDataModel {
  getFromMap(Map<String, dynamic> map);
  setError(String errorMessage);
}

class ResponseModel {
  bool success;
  dynamic? data;
  String? msg;
  String? code;
  ResponseModel({required this.success, this.data, this.msg, this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'data': data,
      'msg': msg,
      'code': code,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      success: map['success'] as bool,
      data: map['data'] != null ? map['data'] as dynamic : null,
      msg: map['msg'] != null ? map['msg'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel(success: $success, data: $data, msg: $msg, code: $code)';
  }
}
