import 'package:flutter_mvvm_frame/global/injection_service.dart';
import 'package:flutter_mvvm_frame/utils/sp_utils.dart';
import 'package:get/get.dart';

Future<void> init() async {
  await Get.putAsync<SPUtil?>(() => SharedPreferenceService().init());

  Get.put(DBService().init());
  //Get.put<HomeRepository>(HomeRepository(Get.find<HomeService>()));
}
