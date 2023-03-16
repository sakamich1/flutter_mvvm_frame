import 'package:ai_paint/common/constants.dart';
import 'package:ai_paint/request/http_manager.dart';
import 'package:ai_paint/request/http_result.dart';


class ReportService {
  Stream<HttpResult> report(Map<String, dynamic> params) =>
      sendReport(API.URL_REPORT, params);
}
