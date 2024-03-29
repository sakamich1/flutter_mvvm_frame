import 'package:ai_paint/global/injection_service.dart';
import 'package:ai_paint/module/main/report_service.dart';
import 'package:ai_paint/utils/sp_utils.dart';
import 'package:get/get.dart';

Future<void> init() async {
  await Get.putAsync<SPUtil?>(() => SharedPreferenceService().init());
  Get.lazyPut<ReportService>(() => ReportInjector().initReportService());

  //Get.put(DBService().init());
  //Get.put<HomeRepository>(HomeRepository(Get.find<HomeService>()));
}
