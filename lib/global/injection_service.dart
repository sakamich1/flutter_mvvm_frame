
import 'package:ai_paint/module/main/report_service.dart';
import 'package:ai_paint/utils/sp_utils.dart';
import 'package:get/get.dart';

class SharedPreferenceService extends GetxService{
  Future<SPUtil?> init() async {
    final sp = await SPUtil.getInstance();
    return sp;  
  }
  
}

class DBService extends GetxService{

}

class ReportInjector extends GetxService {
  ReportService initReportService() => ReportService();
}
