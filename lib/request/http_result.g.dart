// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult<T> _$HttpResultFromJson<T>(Map<String, dynamic> json) {
  return HttpResult<T>()
    ..code = json['code'] as int?
    ..msg = json['msg'] as String?
    ..others = json['others'] as String?
    ..data = json['data'];
}

Map<String, dynamic> _$HttpResultToJson<T>(HttpResult<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'others': instance.others,
      'data': instance.data,
    };
