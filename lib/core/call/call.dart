import 'package:dio/dio.dart';
import 'package:likealocal_app_platform/core/call/models/call_models.dart';
import 'package:likealocal_app_platform/core/call/types/call_enums.dart';

/// API 호출
Future<ResponseModel> callAPI<T extends BaseResponseDataModel>(
    String url, ApiMethod apiMethod, T responseData,
    {Map<String, dynamic>? params, Options? options}) async {
  late final Response<dynamic> res;
  switch (apiMethod) {
    case ApiMethod.GET:
      res = await Dio().get(url, queryParameters: params, options: options);
      break;
    case ApiMethod.POST:
      res = await Dio().post(url, data: params, options: options);
      break;
    case ApiMethod.DELETE:
      res = await Dio().delete(url, queryParameters: params, options: options);
      break;
  }

  return ResponseModel.fromMap(res.data);
}
