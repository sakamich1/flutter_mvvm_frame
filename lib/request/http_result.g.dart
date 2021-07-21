// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult<T> _$HttpResultFromJson<T>(Map<String, dynamic> json) {
  return HttpResult<T>()
    ..resultCode = json['resultCode'] as String?
    ..resultInfo = json['rtn_msg'] as String?
    ..serverTime = json['mServerDate'] as String?
    ..data = json['data'];
}

Map<String, dynamic> _$HttpResultToJson<T>(HttpResult<T> instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'rtn_msg': instance.resultInfo,
      'mServerDate': instance.serverTime,
      'data': instance.data,
    };
