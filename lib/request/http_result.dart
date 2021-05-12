import 'package:json_annotation/json_annotation.dart';

part 'http_result.g.dart';

@JsonSerializable()
class HttpResult<T>{
  int? code;
  String? msg;
  String? others;
  dynamic data;
  
  HttpResult();
  
 factory  HttpResult.fromJson(Map<String, dynamic> json) =>
    _$HttpResultFromJson(json);

  static Map<String, dynamic> toJson(HttpResult instance) =>
    _$HttpResultToJson(instance);

}