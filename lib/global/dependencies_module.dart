import 'package:dartin/dartin.dart';
import 'package:flutter_mvvm_frame/module/model/home_repository.dart';
import 'package:flutter_mvvm_frame/module/model/home_service.dart';
import 'package:flutter_mvvm_frame/module/viewmodel/home_vm.dart';
import 'package:flutter_mvvm_frame/utils/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const scope = DartInScope('global');
final modules = [viewModelModule,repoModule,remoteModule,localModule];
SPUtil sp;

final viewModelModule = Module([
  factory<HomeVM>(({params}) => HomeVM(get<HomeRepository>())),
  //factory：普通构造方式 每次都会new
]);

final repoModule = Module([
  single<HomeRepository>(({params}) => HomeRepository(get<HomeService>())),
  //single：全局单例方式 且懒加载
]);

final remoteModule = Module([
  single<HomeService>(({params}) => HomeService())
]);

final localModule = Module([
  single<SPUtil>(({params}) => sp)
]);

init() async {
  sp = await SPUtil.getInstance();
  // DartIn start
  startDartIn(modules);
}

