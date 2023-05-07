import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:likealocal_app_platform/core/call/models/api_url_model.dart';
import 'package:likealocal_app_platform/core/call/types/call_enums.dart';

var baseUrl = dotenv.env["BASE_URL"];

var urlEmailJoin =
    ApiUrlModel(url: "$baseUrl/api/email/join", method: ApiMethod.POST);
var urlEmailLogin =
    ApiUrlModel(url: "$baseUrl/api/c.auth/login/email", method: ApiMethod.POST);
