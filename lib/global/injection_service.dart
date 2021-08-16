
import 'package:flutter_mvvm_frame/module/main/report_service.dart';
import 'package:flutter_mvvm_frame/utils/sp_utils.dart';
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
