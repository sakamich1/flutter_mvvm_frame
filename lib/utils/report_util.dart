import 'package:flutter_mvvm_frame/common/constants.dart';
import 'package:flutter_mvvm_frame/module/main/report_service.dart';
import 'package:flutter_mvvm_frame/utils/device_info.dart';
import 'package:get/get.dart';

class ReportUtil {
  ReportUtil._();

  static ReportService? _service;

  static report(String eventId) async {
    if (_service == null) {
      _service = Get.find<ReportService>();
    }

    Map<String, dynamic> content = await DeviceInfoUtil.getReportContent()
      ..[Keys.REPORT_KEY_EVENT_ID] = eventId;

    ///友盟上报
   /* UmengCommonSdk.onEvent(
        eventId, {'channel': await PackageUtil.getChannelNameNative()});*/

    ///自有后台上报
    _service?.report(content);
  }
}
