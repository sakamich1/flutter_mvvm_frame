import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:flutter_mvvm_frame/request/http_manager.dart';
import 'package:flutter_mvvm_frame/request/http_result.dart';


class ReportService {
  Stream<HttpResult> report(Map<String, dynamic> params) =>
      sendReport(API.URL_REPORT, params);
}
