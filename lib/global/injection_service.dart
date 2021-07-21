
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