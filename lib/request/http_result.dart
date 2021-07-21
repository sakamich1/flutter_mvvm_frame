import 'package:json_annotation/json_annotation.dart';

part 'http_result.g.dart';

@JsonSerializable()
class HttpResult<T> extends Object {
  @JsonKey(name: 'resultCode')
  @JsonKey(name: 'rtnCode')
  @JsonKey(name: 'resultcode')
  @JsonKey(name: 'rtn_code')
  @JsonKey(name: 'code')
  String? resultCode;

  @JsonKey(name: 'rtn_msg')
  @JsonKey(name: 'resultifo')
  @JsonKey(name: 'resultInfo')
  @JsonKey(name: 'rtnMsg')
  String? resultInfo;

  @JsonKey(name: 'mServerDate')
  @JsonKey(name: 'serverDate')
  @JsonKey(name: 'rtn_server_date')
  @JsonKey(name: 'serverTime')
  @JsonKey(name: 'servertime')
  String? serverTime;

  dynamic data;

  HttpResult();

  factory HttpResult.fromJson(Map<String, dynamic> json) {
    HttpResult<T> result = HttpResult();
    //解析返回码
    if (json.containsKey('resultCode')) {
      result.resultCode = json['resultCode'].toString();
    } else if (json.containsKey('rtnCode')) {
      result.resultCode = json['rtnCode'].toString();
    } else if (json.containsKey('resultcode')) {
      result.resultCode = json['resultcode'].toString();
    } else if (json.containsKey('rtn_code')) {
      result.resultCode = json['rtn_code'].toString();
    } else if (json.containsKey('code')) {
      result.resultCode = json['code'].toString();
    }

    //解析msg
    if (json.containsKey('rtn_msg')) {
      result.resultInfo = json['rtn_msg'].toString();
    } else if (json.containsKey('resultifo')) {
      result.resultInfo = json['resultifo'].toString();
    } else if (json.containsKey('resultInfo')) {
      result.resultInfo = json['resultInfo'].toString();
    } else if (json.containsKey('rtnMsg')) {
      result.resultInfo = json['rtnMsg'].toString();
    }

    //解析时间戳
    if (json.containsKey('mServerDate')) {
      result.serverTime = json['mServerDate'].toString();
    } else if (json.containsKey('serverDate')) {
      result.serverTime = json['serverDate'].toString();
    } else if (json.containsKey('rtn_server_date')) {
      result.serverTime = json['rtn_server_date'].toString();
    } else if (json.containsKey('serverTime')) {
      result.serverTime = json['serverTime'].toString();
    } else if (json.containsKey('servertime')) {
      result.serverTime = json['servertime'].toString();
    }

    //解析数据
    if (json.containsKey('data')) {
      result.data = json['data'];
    }else if(json.containsKey('infoFlowList')){
      result.data=json['infoFlowList'];
    }

    return result;
  }

  static Map<String, dynamic> toJson(HttpResult instance) =>
      _$HttpResultToJson(instance);
}
