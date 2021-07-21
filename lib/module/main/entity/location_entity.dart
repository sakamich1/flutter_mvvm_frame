import 'package:json_annotation/json_annotation.dart';

part 'location_entity.g.dart';


@JsonSerializable()
class LocationEntity extends Object {

  @JsonKey(name: 'callbackTime')
  String? callbackTime;

  @JsonKey(name: 'locationTime')
  String? locationTime;

  @JsonKey(name: 'locationType')
  String? locationType;

  @JsonKey(name: 'latitude')
  String? latitude;

  @JsonKey(name: 'longitude')
  String? longitude;

  @JsonKey(name: 'accuracy')
  String? accuracy;

  @JsonKey(name: 'altitude')
  String? altitude;

  @JsonKey(name: 'bearing')
  String? bearing;

  @JsonKey(name: 'speed')
  String? speed;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'province')
  String? province;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'district')
  String? district;

  @JsonKey(name: 'street')
  String? street;

  @JsonKey(name: 'streetNumber')
  String? streetNumber;

  @JsonKey(name: 'cityCode')
  String? cityCode;

  @JsonKey(name: 'adCode')
  String? adCode;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'description')
  String? description;

  LocationEntity(this.callbackTime,this.locationTime,this.locationType,this.latitude,this.longitude,this.accuracy,this.altitude,this.bearing,this.speed,this.country,this.province,this.city,this.district,this.street,this.streetNumber,this.cityCode,this.adCode,this.address,this.description,);

  factory LocationEntity.fromJson(Map<String, dynamic> srcJson) => _$LocationEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);

}

  
