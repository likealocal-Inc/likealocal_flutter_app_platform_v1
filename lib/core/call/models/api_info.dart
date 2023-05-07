// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:likealocal_app_platform/core/call/models/api_url_model.dart';

class ApiInfo {
  final ApiUrlModel urlInfo;
  Map<String, dynamic>? params;
  ApiInfo({
    required this.urlInfo,
    this.params,
  });
}
